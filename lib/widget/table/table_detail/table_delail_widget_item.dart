import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_bbc/models/menu.dart';
import 'package:restaurant_bbc/models/table.dart';
import 'package:restaurant_bbc/widget/page_menu/menus_widget.dart';
import 'package:restaurant_bbc/widget/table/tables_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const String tableBoxName = 'tablehistory';

class TableDetailWidgetItems extends StatefulWidget {
  final TableModel tableItem;
  TableDetailWidgetItems({Key? key, required this.tableItem}) : super(key: key);

  @override
  _TableDetailWidgetItemsState createState() => _TableDetailWidgetItemsState();
}

class _TableDetailWidgetItemsState extends State<TableDetailWidgetItems> {
  late Box<TableModel> tableBox;

  @override
  void initState() {
    tableBox = Hive.box<TableModel>(tableBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int t = 0;
    List<int> s = widget.tableItem.oderedfood
        .map((e) => e.amount * int.parse(e.price.toString()))
        .toList();
    for (int i = 0; i < s.length; i++) {
      t = t + s[i];
    }

    showMenuWidget() async {
      List<MenuModel> thisresultdata = widget.tableItem.oderedfood;
      List<dynamic> result = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => MenusWidget()));
      result as List<MenuModel>;
      if (result.isEmpty) {
        thisresultdata = widget.tableItem.oderedfood;
      } else {
        thisresultdata.addAll(result);
      }
      table_bloc.updateTable(widget.tableItem).then((value) {
        setState(() {
          thisresultdata = widget.tableItem.oderedfood;
        });
      });
    }

    return Scaffold(
        // ignore: unnecessary_brace_in_string_interps
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, true);
                });
              }),
          title: Text(
            'Table ' + '${widget.tableItem.id}',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.brown,
          centerTitle: true,
        ),
        body: (widget.tableItem.oderedfood.isEmpty)
            ? Center(
                child: Column(
                  children: [
                    Text(
                      'You have not Foods yet',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          showMenuWidget();
                        },
                        color: Colors.red,
                        child: Text(
                          'Order',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'RESTAURANT BBC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Address: Dong Khuong, Dien Phuong, DB, QN',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Mobile: 0788.036 920',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Bill Payment',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Text(
                            'Table:   ' + '${widget.tableItem.id}',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Member ID: ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Text('Name Foods',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(width: 30),
                        Text('Unit',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(width: 30),
                        Text('Price',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: widget.tableItem.oderedfood.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Slidable(
                                    actionExtentRatio: 1 / 5,
                                    actionPane: SlidableScrollActionPane(),
                                    actions: <Widget>[
                                      IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          setState(() {
                                            widget.tableItem.oderedfood
                                                .removeAt(index);
                                            table_bloc
                                                .updateTable(widget.tableItem);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${widget.tableItem.oderedfood[index].name}',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.tableItem.oderedfood[index].amount}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.tableItem.oderedfood[index].price}' +
                                                '.00\$',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'ToTal: ',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Container(
                          child: Text(
                            // ignore: unnecessary_brace_in_string_interps
                            '${t}' + '.00\$',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            showMenuWidget();
                          },
                          color: Colors.red,
                          child: Text(
                            'Order more',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          color: Colors.green,
                          child: Text(
                            'Complete',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            TableModel table = TableModel(
                                id: widget.tableItem.id,
                                status: widget.tableItem.status,
                                oderedfood: widget.tableItem.oderedfood);
                            tableBox.add(table);
                            setState(() {
                              table_bloc
                                  .payTable(widget.tableItem)
                                  .then((value) {
                                Navigator.pop(context, true);
                              });
                            });
                          },
                          color: Colors.green,
                          child: Text(
                            'Payment',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
  }
}
