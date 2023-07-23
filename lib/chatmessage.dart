import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child:CircleAvatar(backgroundColor: sender=="Bot"?Colors.transparent:Colors.grey.shade400,
              child: sender=="Bot"? Image.asset("assets/ai.png"):Text(sender[0]),),
          ),
          Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(sender, style: Theme.of(context).textTheme.subtitle1,),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text),
              )
            ],
          ),),

        ],
      ).px16(),
    );
  }
}
