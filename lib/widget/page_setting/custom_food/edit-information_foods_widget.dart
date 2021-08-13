import 'package:flutter/material.dart';
import 'package:restaurant_bbc/models/menu.dart';
import 'package:restaurant_bbc/widget/page_menu/menus_bloc.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_member/textinput_wedget.dart';

// ignore: must_be_immutable
class EditinformationFood extends StatefulWidget {
  late MenuModel food;
  EditinformationFood({Key? key, required this.food}) : super(key: key);

  @override
  _EditinformationFoodState createState() => _EditinformationFoodState();
}

class _EditinformationFoodState extends State<EditinformationFood> {
  TextEditingController nameFoodController = new TextEditingController();
  TextEditingController subtitleFoodController = new TextEditingController();
  TextEditingController priceFoodController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameFoodController.text = widget.food.name;
    subtitleFoodController.text = widget.food.subtitle;
    priceFoodController.text = widget.food.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Foods'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  menu_bloc
                      .editFood(
                          food: widget.food,
                          name: nameFoodController.text,
                          price: int.parse(priceFoodController.text),
                          subtitle: subtitleFoodController.text)
                      .then((value) => Navigator.pop(context));
                });
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextInput(nameFoodController, 'Name\'s', Icons.room_service),
            TextInput(priceFoodController, 'Price', Icons.price_change),
            TextInput(subtitleFoodController, 'Subtitle\'s Foods', Icons.book)
          ],
        ),
      ),
    );
  }
}
