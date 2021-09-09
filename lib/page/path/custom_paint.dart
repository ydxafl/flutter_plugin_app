

import 'package:flutter/material.dart';

class MyCustomPaint extends CustomPainter {



  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;

    Paint _paint2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width/2;

    Paint _paint3 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Paint _pain4 = Paint()

      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    /*var _path = Path()
      ..moveTo(0, size.height/3)
      ..lineTo(size.width, size.height/3)
      ..lineTo(size.width/5, size.height)
      ..lineTo(size.width/2, 0)
      ..lineTo(size.width/5 * 4, size.height)
      ..close();
    canvas.drawPath(_path, _paint);*/
    const PI = 3.1415926;
    Rect rect = Rect.fromCircle(center: Offset(size.width/2,size.height/2), radius: size.width/3);

    Rect rect2 = Rect.fromCircle(center: Offset(size.width/2,size.height/2), radius: size.width/3 + 5);
    Rect rect3 = Rect.fromCircle(center: Offset(size.width/2,size.height/2), radius: size.width/5);

    for(int i = 0; i < 60 ; i ++){
      if(i % 5 == 0){
        canvas.drawArc(rect, PI/30 * i, PI/90, false, _paint);
      }else{
        canvas.drawArc(rect, PI/30 * i, PI/90, false, _paint2);
      }
      canvas.drawArc(rect2, PI/30 * i, PI/90, false, _paint3);
    }

    canvas.drawArc(rect2, 0, 2 * PI, false, _pain4);

    canvas.drawArc(rect3, 0, 2 * PI, false, _paint3);


  }

  @override
  bool shouldRepaint(MyCustomPaint oldDelegate) {
    return this != oldDelegate;
  }

}