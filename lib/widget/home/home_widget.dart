import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_bbc/login_page/login_widget.dart';
import 'package:restaurant_bbc/models/home_menu_item.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'package:restaurant_bbc/widget/page_discount/discount_widget.dart';
import 'package:restaurant_bbc/widget/page_historypayment/historypayment.dart';
import 'package:restaurant_bbc/widget/page_information/information_widget.dart';
import 'package:restaurant_bbc/widget/page_menu/menus_widget.dart';
import 'package:restaurant_bbc/widget/page_notification/notification_wedget.dart';
import 'package:restaurant_bbc/widget/page_setting/setting_widget.dart';
import 'package:restaurant_bbc/widget/table/tables_widget.dart';

const String boxUser = 'users';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Box<Login> usered;

  void initState() {
    usered = Hive.box<Login>(boxUser);
    super.initState();
  }

  final List<MenuItem> menuItems = MenuItem.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.brown,
        title: Text(
          'Restaurant BBC',
          style: TextStyle(fontSize: 35, color: Colors.yellowAccent),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  usered.delete('key').then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginWidget()))
                      });
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2,
              mainAxisExtent: 200),
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return menuItemWidget(menuItems[index]);
          }),
    );
  }

  Widget menuItemWidget(MenuItem item) {
    return InkWell(
        onTap: () {
          switch (item) {
            case MenuItem.menu:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenusWidget()));
              break;
            case MenuItem.discount:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiscountWidget()));
              break;
            case MenuItem.notification:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationWidget()));
              break;
            case MenuItem.infomation:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InformationWidget()));
              break;
            case MenuItem.history:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryPayment()));
              break;
            case MenuItem.table:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableWidget()));
              break;
            case MenuItem.setting:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingWidget()));
              break;
            default:
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(
              item.iconMenu,
              size: 70,
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              item.title,
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ]),
          decoration: BoxDecoration(
              color: item.color, borderRadius: BorderRadius.circular(15)),
        ));
  }
}
