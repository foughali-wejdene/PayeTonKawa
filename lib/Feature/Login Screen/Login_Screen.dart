import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mspr/Core/sharedPref.dart';
import 'package:mspr/Feature/Pin%20Code/Pin_Code_Screen.dart';
import 'package:mspr/Feature/product/list.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/service/userService.dart';

import '../../Core/Animation/Fade_Animation.dart';
import '../../Core/Colors/Hex_Color.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

enum FormData {
  email,
  password,
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color disable = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;
  String email = "";

  TextEditingController emailController = TextEditingController();

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', 'Cancel', true, ScanMode.BARCODE)!.listen((barcode) => print(barcode));
  }

  Future<bool> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      SharedPref sharedPref = SharedPref();
      Map<dynamic, dynamic> usrObj = await sharedPref.read("currentUser");
      String usr = json.encode(usrObj);
      if (barcodeScanRes == usr) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Authentification incorrect",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return false;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      print(barcodeScanRes);
      return false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [HexColor("#4b4293").withOpacity(0.8), HexColor("#4b4293"), HexColor("#08418e"), HexColor("#08418e")],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const NetworkImage(
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/01b4bd84253993.5d56acc35e143.jpg',
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color: const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.network(
                            "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: const Text(
                            "Merci de vous connecter pour continuer",
                            style: TextStyle(color: Colors.white, letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.email ? enabled : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (txt) {
                                setState(() {
                                  email = txt;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  selected = FormData.email;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: selected == FormData.email ? enabledtxt : disable,
                                  size: 20,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: selected == FormData.email ? enabledtxt : disable, fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(color: selected == FormData.email ? enabledtxt : disable, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () async {
                                if (selected == null || email == "") {
                                  Fluttertoast.showToast(
                                      msg: "Une erreur est survenue. L'email ne peut pas être vide",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (email.isValidEmail()) {
                                  User? usr = await UserService.login(email);
                                  if (usr != null) {
                                    var cameras = await availableCameras();
                                    if (cameras.isNotEmpty) {
                                      bool isSuccess = await scanQR();
                                      if (isSuccess) {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return const ProductList();
                                        }));
                                        return;
                                      }
                                    }
                                    // Si une camera existe alors activer le scan du QRCode;
                                    // Scan non disponible donc on procède par code pin
                                    Navigator.pop(context);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return PinCodeVerificationScreen(email: usr.email, id: usr.id);
                                    }));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Aucun utilisateur n'existe avec cet email",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Le format de l'email est incorrect",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                              child: const Text(
                                "Connexion",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
