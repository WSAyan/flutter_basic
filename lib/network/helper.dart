import 'dart:convert';
import 'package:flutter_basic/data/login.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://reqres.in/";
const String LOGIN = "api/login";
const String REGISTER = "api/register";
const String USERS = "api/users?page=";

class HttpRepository {
  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post("$BASE_URL$LOGIN",
        body: Login(email: email, password: password).toJson());

    if (response.statusCode == 200) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.body));

      return loginResponse;
    } else {
      return null;
    }
  }

  Future<UsersResponse> fetchUsers(int page) async {
    final response = await http.get("$BASE_URL$USERS$page");

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
