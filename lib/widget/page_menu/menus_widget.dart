import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_bbc/models/menu.dart';
import 'menus_bloc.dart';

class MenusWidget extends StatefulWidget {
  MenusWidget({
    Key? key,
  }) : super(key: key);

  @override
  _MenusWidgetState createState() => _MenusWidgetState();
}

class _MenusWidgetState extends State<MenusWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Container(
          child: FutureBuilder<List<MenuModel>>(
            future: menu_bloc.fetchMenus(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Load faild');
              }

              return snapshot.hasData
                  ? ListMenusWidget(
                      menus: menu_bloc.items,
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List<MenuModel> selectedItems =
                menu_bloc.items.where((element) => element.amount > 0).toList();
            // ignore: unnecessary_null_comparison
            Navigator.pop(context, selectedItems == null ? [] : selectedItems);
          },
          child: const Icon(
            Icons.task_alt,
            size: 30,
          ),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class ListMenusWidget extends StatefulWidget {
  final List<MenuModel> menus;

  ListMenusWidget({
    Key? key,
    required this.menus,
  }) : super(key: key);

  @override
  _ListMenusWidgetState createState() => _ListMenusWidgetState();
}

class _ListMenusWidgetState extends State<ListMenusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 0.5),
        itemCount: widget.menus.length,
        itemBuilder: (context, index) {
          return Container(
              color: Colors.brown,
              child: Column(
                children: [
                  Row(
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
                                widget.menus[index].name.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(widget.menus[index].subtitle.toString(),
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.only(right: 4),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Text(
                                        '\$' +
                                            '${widget.menus[index].price}.00',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                  Container(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.menus[index].amount -=
                                                      widget.menus[index]
                                                                  .amount ==
                                                              0
                                                          ? 0
                                                          : 1;
                                                });
                                              },
                                              icon:
                                                  Icon(Icons.remove_outlined)),
                                          Container(
                                            color: Colors.red,
                                            child: Text(
                                              '${widget.menus[index].amount}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.menus[index].amount +=
                                                      1;
                                                });
                                              },
                                              icon: Icon(Icons.add))
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
