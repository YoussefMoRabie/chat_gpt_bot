import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'ai_api.dart';
import 'chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

ChatBotWithPaLM api = ChatBotWithPaLM();

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];


  @override
  void dispose(){
    super.dispose();
  }

bool sending = false;
  Future<void> _sendMessage() async {
    ChatMessage message = ChatMessage(text: _controller.text, sender: "User");
    setState(() {
      sending=true;
      _messages.insert(0, message);
    });
    _controller.clear();

    await api.sendMessage(_messages[0].text).then((value) {
      setState(() {
        _messages.insert(0, ChatMessage(text: value["response"], sender: "Bot"));
        sending = false;
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });

  }

  Widget _buildTextComposer(){
    return Row(
      children: [
        Expanded( child:
          TextField(
          controller: _controller,
          onSubmitted: (value)=>_sendMessage(),
          decoration:
          const InputDecoration.collapsed(hintText: "Send a message"),

        ),
        ),
        if(!sending)
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _sendMessage(),
        ),
        if(sending)
          CircularProgressIndicator(),

        ],


    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ChatGPT Demo",textAlign: TextAlign.center,),),
      body: SafeArea(
        child: Column(
          children: [
           Flexible(

              child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  padding: Vx.m8,
                  itemBuilder: (context,index) {
                  return _messages[index];
              },
            )),


              Container(
                  decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              ),



          ],
        ),
      )
    );
  }
}
