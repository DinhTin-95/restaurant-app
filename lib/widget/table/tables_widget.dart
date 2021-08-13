import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bbc/models/table.dart';
import 'package:restaurant_bbc/widget/table/table_detail/table_delail_widget_item.dart';
import 'package:restaurant_bbc/widget/table/tables_bloc.dart';

class TableWidget extends StatefulWidget {
  TableWidget({Key? key}) : super(key: key);

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                }),
            title: Text(
              'Choose Table',
              style: TextStyle(fontSize: 30),
            )),
        body: FutureBuilder<List<TableModel>>(
            future: table_bloc.fetchListTable(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              // ignore: unused_local_variable
              // final List<TableModel> tables = snapshot.data ??[];
              return snapshot.hasData
                  ? ListTableWidget()
                  : Center(child: CircularProgressIndicator());
            }));
  }
}

// ignore: must_be_immutable
class ListTableWidget extends StatefulWidget {
  ListTableWidget({Key? key}) : super(key: key);

  @override
  _ListTableWidgetState createState() => _ListTableWidgetState();
}

class _ListTableWidgetState extends State<ListTableWidget> {
  _setRequests() async {
    table_bloc.fetchListTable().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: table_bloc.tables.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(5),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: table_bloc.tables[index].oderedfood.isEmpty
                      ? Colors.green
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'image/table1.png',
                    height: 90,
                    width: 90,
                  ),
                  Text(
                    'Table ' + '${table_bloc.tables[index].id}',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TableDetailWidgetItems(
                            tableItem: table_bloc.tables[index],
                          ))).then((value) => value ? _setRequests() : null);
            },
          );
        });
  }
}
