import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final showIcon;
  final image;
  LoginBackground({this.showIcon = true, this.image});

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Flexible(
      flex: 2,
      child: ClipPath(
        clipper: ArcClipper(),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: UIData.kitGradients,
              )),
            ),
            showIcon
                ? Center(
                    child: SizedBox(
                        height: deviceSize.height / 8,
                        width: deviceSize.width / 2,
                        child: const FlutterLogo(
                          textColor: Colors.yellow,
                        )),
                  )
                : Container(
                    width: double.infinity,
                    child: image != null
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        : Container())
          ],
        ),
      ),
    );
  }

  final bottomHalf = Flexible(
    flex: 3,
    child: Container(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class UIData {
  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
  static List<Color> kitGradients2 = [Colors.cyan.shade600, Colors.blue.shade900];

  //randomcolor
  static final Random _random = Random();

  /// Returns a random color.
  static Color next() {
    return Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
