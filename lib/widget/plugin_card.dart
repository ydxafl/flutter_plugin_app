
import 'package:flutter/material.dart';

class PluginCard extends StatelessWidget {
  final name;
  final color;
  final Function onTap;
  const PluginCard({Key? key,this.name,this.color,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: color,
        shadowColor: Colors.blue,
        child: Container(
          child: Text('$name'),
          alignment: Alignment.center,
        )
      ),
      onTap: (){
        onTap();
      },
    );
  }
}
