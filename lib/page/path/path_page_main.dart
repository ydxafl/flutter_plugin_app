
import 'package:flutter/material.dart';
import 'package:flutter_plugin_app/page/path/custom_paint.dart';

class PathPageMain extends StatelessWidget {
  const PathPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path'),
      ),
      body: Center(
        child:  CustomPaint(
          size: Size(300,300),
          painter: MyCustomPaint(),
        ),
      ),
    );
  }
}
