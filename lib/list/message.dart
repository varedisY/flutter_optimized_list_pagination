import 'package:flutter/material.dart';
import 'package:flutter_performance/list/list.dart';

class MessageModel {
  String id;
  String text;
  String username;

  MessageModel({required this.id, required this.text, required this.username});
}

MessageModel message = MessageModel(
    id: uuid.v4(), text: "Hello! Nice to meet you!", username: "Author1");

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.username,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(message.text),
            ],
          )
        ],
      ),
    );
  }
}
