import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:http/http.dart' as http;

class UsersScreen extends StatefulWidget {
  @override
  UsersState createState() => UsersState();
}

class UsersState extends State<UsersScreen> {
  List<User> users = new List<User>();
  Future<UsersResponse> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(1);
  }

  Future<UsersResponse> fetchUsers(int page) async {
    final response =
        await http.get('${HttpServer.BASE_URL}${HttpServer.USERS}$page');

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void paginationController(
      int lastVisibleIndex, int currentPage, int totalPages) {
    final lastIndex = lastVisibleIndex;
    if (lastIndex >= users.length) {
      int nextPage = currentPage + 1;
      if (nextPage <= totalPages) {
        futureUsers = fetchUsers(nextPage);
      }
    }
  }

  Widget buildUsersList() {
    //paginationController(7, 1, 6); // hard coded

    return FutureBuilder<UsersResponse>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            users.addAll(snapshot.data.data);

            return ScrollablePositionedList.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = users[index];

                  ListTile listTile = CommonAppWidgets.makeCommonListRow(
                      user.email,
                      "${user.firstName} ${user.lastName}",
                      user.avatar);

                  return listTile;
                });
          }

          return Center(child: CommonAppWidgets.makeCommonLoader());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.USERS_SCREEN_TITLE),
      ),
      body: buildUsersList(),
    );
  }
}
