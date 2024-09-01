import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupMessage extends StatefulWidget {
  final name;
  const GroupMessage({super.key, required this.name});

  @override
  State<GroupMessage> createState() => _GroupMessageState();
}

class _GroupMessageState extends State<GroupMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
    );
  }
}
