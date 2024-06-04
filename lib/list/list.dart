import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_performance/list/message.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _controller = ScrollController();
  List<MessageModel> messageList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent) {
        //make an API call for more items. // use Throttling for less calls and better performance.

        EasyThrottle.throttle('pagination', const Duration(milliseconds: 500),
            () {
          addItems();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text("List Performance"),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    addItems();
                  },
                  child: const Text("Add Message"))
            ],
          ),
        ),
        SliverList.builder(
            findChildIndexCallback: (key) {
              //we use the previously assigned id to find the index of existing widget,
              //therefore, preventing it form unnecesary repaint.

              final valueKey = key as ValueKey<String>;
              final val = messageList.indexWhere((m) => m.id == valueKey.value);

              if (val == -1) {
                return null;
              }

              return val;
            },
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              // we use the message's id to create a reference key to our widget.
              final message = messageList[index];
              return Message(key: ValueKey(message.id));
            }),
      ],
    );
  }

  addItems() {
    setState(() {
      messageList = [
        ...messageList,
        ...List.generate(
            10,
            (index) => MessageModel(
                id: uuid.v4(), text: "Hello World!", username: "Author"))
      ];
    });
  }
}
