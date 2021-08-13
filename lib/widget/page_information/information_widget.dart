import 'package:flutter/material.dart';

class InformationWidget extends StatefulWidget {
  InformationWidget({Key? key}) : super(key: key);

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Information',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          children: [
            Text(
              'Option don\'t yet update, Sorry for the inconvenience!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.amber,
                  child: Text(
                    'Back!',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
