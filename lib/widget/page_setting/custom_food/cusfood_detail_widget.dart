import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:restaurant_bbc/models/menu.dart';
import 'package:restaurant_bbc/widget/page_menu/menus_bloc.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_food/createfood.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_food/edit-information_foods_widget.dart';

class AddFoodFuture extends StatefulWidget {
  AddFoodFuture({Key? key}) : super(key: key);

  @override
  _AddFoodFutureState createState() => _AddFoodFutureState();
}

class _AddFoodFutureState extends State<AddFoodFuture> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Foods'),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Createfood())).then((value) {
                      setState(() {});
                    });
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: menu_bloc.fetchMenus(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Load faild');
            }
            return snapshot.hasData
                ? AddFoodWidget(
                    menu: menu_bloc.items,
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddFoodWidget extends StatefulWidget {
  List<MenuModel> menu;
  AddFoodWidget({Key? key, required this.menu}) : super(key: key);

  @override
  _AddFoodWidgetState createState() => _AddFoodWidgetState();
}

class _AddFoodWidgetState extends State<AddFoodWidget> {
  regen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 0.5),
        itemCount: widget.menu.length,
        itemBuilder: (context, index) {
          return Container(
              color: Colors.brown,
              child: Column(
                children: [
                  Slidable(
                    actionExtentRatio: 1 / 5,
                    actionPane: SlidableScrollActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'edit',
                        color: Colors.green,
                        icon: Icons.edit,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditinformationFood(
                                        food: widget.menu[index],
                                      )));
                        },
                      ),
                      IconSlideAction(
                        caption: 'delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          menu_bloc
                              .deleteFood(widget.menu[index])
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                      IconSlideAction(
                        caption: 'Close',
                        color: Colors.grey,
                        icon: Icons.close,
                        onTap: () {},
                      ),
                    ],
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(3),
                            color: Colors.brown,
                            width: 100,
                            height: 100,
                            child: Image.network(
                              'http://bonchon.com.vn/sites/default/files/2-salad-ga_gion-3_0.jpg',
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.menu[index].name.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(widget.menu[index].subtitle.toString(),
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 5),
                                Container(
                                  child: Text(
                                      '\$' + '${widget.menu[index].price}.00',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
