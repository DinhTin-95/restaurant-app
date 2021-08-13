import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restaurant_bbc/models/table.dart';
import 'package:intl/intl.dart';

const String tableBoxName = 'tablehistory';
DateTime now = DateTime.now();

class HistoryPayment extends StatefulWidget {
  HistoryPayment({Key? key}) : super(key: key);
  @override
  _HistoryPaymentState createState() => _HistoryPaymentState();
}

class _HistoryPaymentState extends State<HistoryPayment> {
  String currenttime = DateFormat('yyyy-MM-dd - kk:mm').format(now);

  late Box<TableModel> tableBox;

  @override
  void initState() {
    tableBox = Hive.box<TableModel>(tableBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History Payment'),
        ),
        // ignore: deprecated_member_use
        body: Container(
            child: ValueListenableBuilder(
          valueListenable: tableBox.listenable(),
          builder: (context, Box<TableModel> histable, _) {
            List<int> keys = histable.keys.cast<int>().toList();
            return ListView.separated(
              itemCount: keys.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                int money = 0;
                final int key = keys[index];
                final TableModel? table = histable.get(key);
                table!.oderedfood.forEach((element) {
                  money += element.price;
                });
                return Container(
                  color: index % 2 == 0 ? Colors.cyan : Colors.amber,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Table: ' + table.id.toString()),
                          SizedBox(
                            width: 120,
                          ),
                          Text('Time: ' + currenttime.toString())
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: table.oderedfood
                                .map((e) => Text(e.name))
                                .toList(),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: table.oderedfood
                                .map((e) => Text(e.amount.toString()))
                                .toList(),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: table.oderedfood
                                .map((e) => Text(e.price.toString()))
                                .toList(),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Row(children: [
                            Text('Total: '),
                            Text(money.toString())
                          ])
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        )));
  }
}
