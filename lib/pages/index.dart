import 'package:flutter/material.dart';
import 'package:flutter_fetch_data/services/user.dart';

import '../services/user.dart';
import '../models/user.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<User> users = List<User>();
  List<User> filteredUsers = List<User>();

  @override
  void initState() {
    Services.getUsers().then((res) => setState(() => {users = res}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing Users'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildTextField(),
        ),
        Expanded(
          child:
              filteredUsers.length != 0 ? buildSearchView() : buildListView(),
        )
      ]),
    );
  }

  TextField buildTextField() {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(Icons.search), hintText: 'Filter by name or email'),
      onChanged: (value) {
        setState(() {
          filteredUsers = users
              .where((item) =>
                  (item.firstName.toLowerCase().contains(value.toLowerCase()) ||
                      item.email.toLowerCase().contains(value.toLowerCase())))
              .toList();
        });
      },
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCard(users, index);
      },
    );
  }

  ListView buildSearchView() {
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCard(filteredUsers, index);
      },
    );
  }

  Card buildCard(List<User> user, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(avatar(user, index)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  firstname(user, index) + " " + lastname(user, index),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  email(user, index),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  firstname(user, index) => user[index].firstName;
  lastname(user, index) => user[index].lastName;
  email(user, index) => user[index].email;
  avatar(user, index) => user[index].avatar;
}
