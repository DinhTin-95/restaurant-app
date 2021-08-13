import 'package:flutter/material.dart';

class DiscountWidget extends StatefulWidget {
  DiscountWidget({Key? key}) : super(key: key);

  @override
  _DiscountWidgetState createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Discount'),
        ),
        body: Center(
          child:
              Text('Option don\'t yet update, Sorry for the inconvenience!!'),
        ),
      ),
    );
  }
}
