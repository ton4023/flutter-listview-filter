import 'package:flutter/material.dart';
import 'package:flutter_fetch_data/theme/color.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    isLoading = true;
    var url = 'https://reqres.in/api/users';
    var res = await Http.get(url);
    if (res.statusCode == 200) {
      var items = jsonDecode(res.body)['data'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing Users'),
      ),
      body: Center(
        child: Container(
          child: getBody(),
        ),
      ),
    );
  }

  Widget getBody() => (users.contains(null) || isLoading)
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => getCard(users[index]),
        );

  Widget getCard(item) => Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(item['avatar'].toString()),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['first_name'].toString() +
                          " " +
                          item['last_name'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      item['email'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
