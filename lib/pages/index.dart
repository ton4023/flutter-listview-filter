import 'package:flutter/material.dart';

import '../services/user.dart';
import '../models/user.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Future<List<User>> futureUser;

  @override
  initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing Users'),
      ),
      body: FutureBuilder<List<User>>(
          future: futureUser,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            var userList = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Container(
                    child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        var name = userList[index].firstName;
                        var last = userList[index].lastName;
                        var email = userList[index].email;
                        var avatar = userList[index].avatar;
                        return card(name, last, email, avatar);
                      },
                    ),
                  );
            }
          }),
    );
  }

  Widget card(name, last, email, avatar) => Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(avatar),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (name + " " + last),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
