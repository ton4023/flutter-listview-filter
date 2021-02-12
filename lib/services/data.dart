import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

Future<List<User>> fetchUser() async {
  final response = await http.get(Uri.https('reqres.in', '/api/users/'));

  List<User> users = (jsonDecode(response.body)['data'] as List)
      .map((i) => User.fromJson(i))
      .toList();
  return users;
}
