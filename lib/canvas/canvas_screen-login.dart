import 'package:flutter/material.dart';

class BackgroundSignIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Color.fromRGBO(250, 250, 250, 1);
    canvas.drawPath(mainBackground, paint);

    Path orangeWave = Path();
    orangeWave.lineTo(sw, 0);
    orangeWave.lineTo(sw, sh * 0.1);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    orangeWave.cubicTo(sw * 1.50, sh * 0.75, sw * 0.4, sh * 0.20, 0, sh * 0.48);
    orangeWave.close();
    paint.color = Color.fromRGBO(245, 134, 52, 1);
    canvas.drawPath(orangeWave, paint);

    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.1);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    blueWave.cubicTo(sw * 1.40, sh * 0.65, sw * 0.3, sh * 0.25, 0, sh * 0.42);
    blueWave.close();
    paint.color = Color.fromRGBO(36, 82, 108, 1);
    canvas.drawPath(blueWave, paint);

    /// Color.fromRGBO(245, 134, 52, 1);

    Path whiteWave = Path();
    whiteWave.lineTo(sw, 0);
    whiteWave.lineTo(sw, sh * 0.01);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    whiteWave.cubicTo(sw * 1.35, sh * 0.59, sw * 0.4, sh * 0.26, 0, sh * 0.38);
    whiteWave.close();
    //paint.color = Color.fromRGBO(36,82,108,1);
    paint.color = Colors.white;
    canvas.drawPath(whiteWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


class BackgroundSignInDetahlesDoProduto extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    // Path mainBackground = Path();
    // mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    // paint.color = Color.fromRGBO(250, 250, 250, 1);
    // canvas.drawPath(mainBackground, paint);

    Path orangeWave = Path();
    orangeWave.lineTo(sw, 0);
    orangeWave.lineTo(sw, sh * 1);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    orangeWave.cubicTo(
        sw * 1.2,
        sh * 0.29,
        sw * 0.19,
        sh * 1.04,
        0,
        sh * 0.75
    );
    orangeWave.close();
    orangeWave.close();
    paint.color = Color.fromRGBO(245, 134, 52, 1);
    canvas.drawPath(orangeWave, paint);

    Path blueMestreWave = Path();
    blueMestreWave.lineTo(sw, 0);
    blueMestreWave.lineTo(sw, sh * 1);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    blueMestreWave.cubicTo(
        sw * 1.2,
        sh * 0.15,
        sw * 0.15,
        sh * 1.1,
        0,
        sh * 0.70
    );
    blueMestreWave.close();
    //paint.color = Color.fromRGBO(36,82,108,1);
    paint.color = Colors.white;
    canvas.drawPath(blueMestreWave, paint);

    Path whiteWave = Path();
    whiteWave.lineTo(sw, 0);
    whiteWave.lineTo(sw, sh * 1);
    //greyWave.cubicTo(sw*0.95, sh*0.15, sw*0.65, sh*0.15, sw*0.6, sh*0.38);
    whiteWave.cubicTo(
        sw * 1.2,
        sh * 0.15,
        sw * 0.15,
        sh * 1.1,
        0,
        sh * 0.70
    );
    whiteWave.close();
    //paint.color = Color.fromRGBO(36,82,108,1);
    paint.color = Color.fromRGBO(36, 82, 108, 22);
    canvas.drawPath(whiteWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
} // não utilizado