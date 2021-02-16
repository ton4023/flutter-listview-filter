import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_fetch_data/models/user.dart';

class Services {
  static const String url = 'https://reqres.in/api/users/';

  static Future<List<User>> getUsers() async {
    final response = await http.get(url);
    List<User> data = (jsonDecode(response.body)['data'] as List)
        .map((i) => User.fromJson(i))
        .toList();
    return data;
  }
}
