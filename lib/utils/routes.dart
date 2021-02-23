import 'package:flutter/material.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/screens/auth/login.dart';
import 'package:flutter_basic/screens/auth/register.dart';
import 'package:flutter_basic/screens/splash.dart';
import 'package:flutter_basic/screens/users/user.dart';
import 'package:flutter_basic/screens/users/users.dart';

const String LOGIN = "_login";
const String REGISTER = "_register";
const String SPLASH = "_splash";
const String USERS = "_users";
const String USER = "_user";

class RouteManager {
  RouteManager(BuildContext context);

  Map<String, WidgetBuilder> routes() => {
        SPLASH: (context) => SplashScreen(),
        LOGIN: (context) => LoginScreen(),
        REGISTER: (context) => RegisterScreen(),
        USERS: (context) => UsersScreen(),
        USER: (context) => UserScreen(),
      };

  MaterialPageRoute handleRoutesWithParam(RouteSettings settings) {
    MaterialPageRoute materialPageRoute;
    switch (settings.name) {
      case USERS:
        break;
      case LOGIN:
        break;
      case REGISTER:
        break;
      case USERS:
        break;
      case USER:
        final User user = settings.arguments;
        materialPageRoute = makeRoute(UserScreen.fromUserScreen(user));
        break;
      default:
        materialPageRoute = null;
        break;
    }
    return materialPageRoute;
  }

  MaterialPageRoute makeRoute(Object screen) =>
      MaterialPageRoute(builder: (context) {
        return screen;
      });
}
