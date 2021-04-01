import "package:flutter/material.dart";

class MessageSnack extends StatelessWidget {
  final String message;

  const MessageSnack({this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
    );
  }
}
