import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:restaurant_bbc/login_page/login_bloc.dart';
import 'package:restaurant_bbc/models/login.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_member/addmem_widget.dart';
import 'package:restaurant_bbc/widget/page_setting/custom_member/edit_information_member.dart';

class AddMemberWidget extends StatefulWidget {
  AddMemberWidget({Key? key}) : super(key: key);

  @override
  _AddMemberWidgetState createState() => _AddMemberWidgetState();
}

class _AddMemberWidgetState extends State<AddMemberWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Member'),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMember()))
                    .then(
                        (value) => login_bloc.fetchListAccount().then((value) {
                              setState(() {});
                            }));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Login>>(
          future: login_bloc.fetchListAccount(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print('load fail');
              } else if (snapshot.hasData) {
                return ListMemberWidget();
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListMemberWidget extends StatefulWidget {
  ListMemberWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ListMemberWidgetState createState() => _ListMemberWidgetState();
}

class _ListMemberWidgetState extends State<ListMemberWidget> {
  regen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: login_bloc.arrayAccount.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Slidable(
                actionExtentRatio: 1 / 5,
                actionPane: SlidableScrollActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Are you sure?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      login_bloc
                                          .deleteListAccount(
                                              member: login_bloc
                                                  .arrayAccount[index])
                                          .then((value) =>
                                              Navigator.pop(context));
                                    },
                                    child: Text('OK')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'))
                              ],
                            );
                          }).then((value) => regen());
                    },
                  ),
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.green,
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditInformation(
                                    memedit: login_bloc.arrayAccount[index],
                                  ))).then((value) => regen());
                    },
                  ),
                  IconSlideAction(
                    caption: 'Close',
                    color: Colors.grey,
                    icon: Icons.close,
                    onTap: () {},
                  ),
                ],
                child: Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 5),
                    color:
                        index % 2 == 1 ? Colors.lightGreen : Colors.amberAccent,
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            child: Image(image: AssetImage('image/mario.png'))),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Fullname: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(login_bloc.arrayAccount[index].fullname),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                Text(
                                  'Level: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  login_bloc.arrayAccount[index].level,
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'IDmember: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(login_bloc.arrayAccount[index].idmember),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  'Description: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
