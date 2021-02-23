import 'dart:convert';
import 'package:flutter_basic/data/login.dart';
import 'package:flutter_basic/data/register.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://reqres.in/";
const String LOGIN = "api/login";
const String REGISTER = "api/register";
const String USERS = "api/users?page=";
const String USER = "api/users/";

class HttpRepository {
  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(makeUrl(LOGIN),
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
    final response = await http.get(makeUrl("$USERS$page"));

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RegisterResponse> register(String email, String password) async {
    final response = await http.post(makeUrl(REGISTER),
        body: Register(email: email, password: password).toJson());

    if (response.statusCode == 200) {
      RegisterResponse registerResponse =
          RegisterResponse.fromJson(jsonDecode(response.body));

      return registerResponse;
    } else {
      return null;
    }
  }

  Future<SingleUserResponse> getSingleUser(int userId) async {
    final response = await http.get(makeUrl("$USER$userId"));

    if (response.statusCode == 200) {
      return SingleUserResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  String makeUrl(String endpoint) => "$BASE_URL$endpoint";
}
