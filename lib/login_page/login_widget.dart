import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_bbc/login_page/login_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'package:restaurant_bbc/widget/home/home_widget.dart';

const String boxUser = 'users';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late Box<Login> usered;
  late Login listaccount;
  bool hintpassword = true;

  bool checkid = false;
  bool checkpass = false;

  TextEditingController textidmembercontroller = TextEditingController();
  TextEditingController textpasswordcontroller = TextEditingController();
  @override
  void initState() {
    usered = Hive.box<Login>(boxUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: login_bloc.fetchListAccount(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Stack(children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.daynauan.info.vn/wp-content/uploads/2019/05/thuc-don-mon-au.jpg'),
                      fit: BoxFit.cover)),
              padding: EdgeInsets.only(top: 70, left: 30, right: 30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 30),
                  child: Text(
                    'Restaurant\'s',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 70),
                  child: Row(
                    children: [
                      Text(
                        'Member',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        '.cld',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow()]),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    controller: textidmembercontroller,
                    validator:
                        EmailValidator(errorText: 'type email not correct'),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.people_alt, color: Colors.black),
                        hintText: 'ID member'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow()]),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                      cursorColor: Colors.black,
                      obscureText: hintpassword,
                      controller: textpasswordcontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye_rounded),
                            onPressed: () {
                              setState(() {
                                hintpassword = !hintpassword;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          hintText: 'Password')),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  onPressed: () {
                    checkUser();
                    setState(() {
                      if (checkUser()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      } else
                        return null;
                    });
                  },
                )
              ],
            ),
          ]);
        },
      )),
    );
  }

  checkUser() {
    String idmem = textidmembercontroller.text;
    String passmem = textpasswordcontroller.text;
    List<Login> users = login_bloc.arrayAccount
        .where((e) => e.idmember == idmem && e.password == passmem)
        .toList();
    final name = users.map((e) => e.fullname);
    final lv = users.map((e) => e.level);
    final i = users.map((e) => e.id);
    if (users.length > 0) {
      Login login = Login(
          fullname: name.toString(),
          idmember: textidmembercontroller.text,
          password: textpasswordcontroller.text,
          level: lv.toString(),
          id: i.toString());

      usered.put('key', login);
      return true;
    } else
      return false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
