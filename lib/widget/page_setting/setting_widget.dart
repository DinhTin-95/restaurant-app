import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_food/cusfood_detail_widget.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_member/cusmem_detail_widget.dart';

const String boxUser = 'users';

class SettingWidget extends StatefulWidget {
  SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  late Box<Login> checkacc;

  @override
  void initState() {
    checkacc = Hive.box<Login>(boxUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN SETTING'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              width: 300,
              height: 30,
              color: Colors.redAccent,
              child: InkWell(
                child: Text('CUSTOM FOOD',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                onTap: () {
                  if (checkadmin()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFoodFuture()));
                  } else {
                    final snackBar =
                        SnackBar(content: const Text('You do have not access'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            color: Colors.orangeAccent,
            child: InkWell(
              child: Text('CUSTOM MEMBER',
                  style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              onTap: () {
                if (checkadmin()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMemberWidget()));
                } else {
                  final snackBar =
                      SnackBar(content: const Text('You do have not access'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  checkadmin() {
    Login? check = checkacc.get('key');
    if (check!.fullname == '(ADMIN)' || check.level == '(1)') {
      return true;
    } else
      return false;
  }
}
