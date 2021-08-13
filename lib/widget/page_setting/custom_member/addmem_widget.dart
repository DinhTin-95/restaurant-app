import 'package:flutter/material.dart';
import 'package:restaurant_bbc/login_page/login_bloc.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'textinput_wedget.dart';

class AddMember extends StatefulWidget {
  AddMember({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  late Login mem = Login(
    fullname: nameController.text,
    idmember: idController.text,
    level: lvController.text,
    password: pwController.text,
    id: '11',
  );
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController lvController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Member'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, mem);
            },
          ),
        ),
        body: Column(
          children: [
            TextInput(nameController, 'Fullname', Icons.people_alt),
            TextInput(idController, 'ID Member', Icons.people_outline),
            TextInput(lvController, 'Level', Icons.verified_user),
            TextInput(pwController, 'Password', Icons.password),
            TextButton(
                onPressed: () {
                  login_bloc
                      .createAccount(
                          member: mem,
                          ten: nameController.text,
                          idmem: idController.text,
                          pw: pwController.text,
                          lv: lvController.text)
                      .then((value) => Navigator.pop(context));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  height: 60,
                  width: 120,
                  // color: Colors.red,
                  child: Text(
                    'Create',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                ))
          ],
        ));
  }
}
