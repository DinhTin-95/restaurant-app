import 'package:flutter/material.dart';
import 'package:restaurant_bbc/login_page/login_bloc.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'textinput_wedget.dart';

// ignore: must_be_immutable
class EditInformation extends StatefulWidget {
  Login memedit;
  EditInformation({Key? key, required this.memedit}) : super(key: key);

  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController lvController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.memedit.fullname;
    idController.text = widget.memedit.idmember;
    lvController.text = widget.memedit.level;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.green,
                size: 30,
              ),
              onPressed: () {
                login_bloc
                    .updateListAccount(
                      mem: widget.memedit,
                      fullname: nameController.text,
                      idmember: idController.text,
                      level: lvController.text,
                    )
                    .then((value) => Navigator.pop(context));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              TextInput(nameController, 'FullName', Icons.people_alt),
              TextInput(idController, 'ID Member', Icons.account_circle),
              TextInput(lvController, 'Level', Icons.verified_user),
            ],
          ),
        ),
      ),
    );
  }
}
