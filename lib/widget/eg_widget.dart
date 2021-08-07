
import 'package:flutter/material.dart';

class EgWidget extends StatelessWidget {
  final title;
  final mark;
  final Function onTap;
  const EgWidget({Key? key,this.title,this.mark,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      padding: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text('$title',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Text('$mark',style: TextStyle(fontSize: 15),),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 40,
            child: OutlinedButton(
              onPressed: (){
                onTap();
              },
              child: Text('试试看'),
            ),
          ),
        ],
      ),
    );
  }
}
