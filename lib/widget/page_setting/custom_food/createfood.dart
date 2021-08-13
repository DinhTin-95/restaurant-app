import 'package:flutter/material.dart';
import 'package:restaurant_bbc/models/menu.dart';
import 'package:restaurant_bbc/widget/page_menu/menus_bloc.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_member/textinput_wedget.dart';

class Createfood extends StatefulWidget {
  Createfood({Key? key}) : super(key: key);

  @override
  _CreatefoodState createState() => _CreatefoodState();
}

class _CreatefoodState extends State<Createfood> {
  TextEditingController nameFoodController = TextEditingController();
  TextEditingController subtitleFoodController = TextEditingController();
  TextEditingController priceFoodController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Foods'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                MenuModel food = MenuModel(
                    name: nameFoodController.text,
                    price: int.parse(priceFoodController.text),
                    subtitle: subtitleFoodController.text,
                    amount: 0);
                menu_bloc
                    .createFood(food)
                    .then((value) => Navigator.pop(context));
              });
            },
            icon: Icon(Icons.done),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextInput(nameFoodController, 'Name\'s', Icons.room_service),
          TextInput(priceFoodController, 'Price', Icons.price_change),
          TextInput(subtitleFoodController, 'Subtitle\'s Foods', Icons.book)
        ]),
      ),
    );
  }
}
