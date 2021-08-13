import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_bbc/login_page/login_widget.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'package:restaurant_bbc/models/table.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:restaurant_bbc/widget/home/home_widget.dart';
import 'models/menu.dart';

const String tableBoxName = 'tablehistory';
const String boxUser = 'users';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<TableModel>(TableModelAdapter());
  Hive.registerAdapter<MenuModel>(MenuModelAdapter());
  await Hive.openBox<TableModel>(tableBoxName);
  Hive.registerAdapter<Login>(LoginAdapter());
  await Hive.openBox<Login>(boxUser);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box<Login> usered;
  @override
  void initState() {
    usered = Hive.box<Login>(boxUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: checkLogin() ? MyHomePage() : LoginWidget());
  }

  bool checkLogin() {
    if (usered.length > 0) {
      return true;
    }
    return false;
  }
}
