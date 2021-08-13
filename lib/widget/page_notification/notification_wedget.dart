import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: Center(
          child:
              Text('Option don\'t yet update, Sorry for the inconvenience!!'),
        ),
      ),
    );
  }
}
