import 'package:flutter/material.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/network/helper.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_basic/utils/routes.dart' as routes;

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
    futureUsers = HttpRepository().fetchUsers(1);
  }

  void paginationController(
      int lastVisibleIndex, int currentPage, int totalPages) {
    final lastIndex = lastVisibleIndex;
    if (lastIndex >= users.length) {
      int nextPage = currentPage + 1;
      if (nextPage <= totalPages) {
        futureUsers = HttpRepository().fetchUsers(nextPage);
      }
    }
  }

  void onListItemClick(Object data) {
    User user = data as User;
    Navigator.pushNamed(
      context,
      routes.USER,
      arguments: user.id,
    );
  }

  Widget buildUsersList() {
    //paginationController(7, 1, 6); // hard coded

    return FutureBuilder<UsersResponse>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            users.clear();
            users.addAll(snapshot.data.data);

            return ScrollablePositionedList.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  User selectedUser = users[index];

                  ListTile listTile = CommonAppWidgets.makeCommonListRow(
                      selectedUser.email,
                      "${selectedUser.firstName} ${selectedUser.lastName}",
                      selectedUser.avatar,
                      selectedUser,
                      onListItemClick);

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
