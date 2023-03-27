import 'package:flutter/material.dart';
import 'package:mspr/Feature/Home/tab_bar_part.dart';
import 'package:mspr/Feature/product/menu_box.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String now = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.white60,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.format_align_left,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "PayeTonKawa",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              //  margin: const EdgeInsets.only(top: 30),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MenuWidget(
                    icon: Icons.home,
                    text: "Accueil",
                  ),
                  MenuWidget(
                    icon: Icons.production_quantity_limits,
                    text: "Produit",
                  ),
                  MenuWidget(
                    icon: Icons.phone,
                    text: "Contact",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),

                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: const TabBarPart(),
                //child: Text('data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
