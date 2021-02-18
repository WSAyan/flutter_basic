import 'package:flutter/material.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/screens/auth/login.dart';
import 'package:flutter_basic/screens/auth/register.dart';
import 'package:flutter_basic/screens/splash.dart';
import 'package:flutter_basic/screens/users/user.dart';
import 'package:flutter_basic/screens/users/users.dart';

import 'constants.dart';

class RouteManager {
  RouteManager(BuildContext context);

  Map<String, WidgetBuilder> routes() => {
        Routes.SPLASH: (context) => SplashScreen(),
        Routes.LOGIN: (context) => LoginScreen(),
        Routes.REGISTER: (context) => RegisterScreen(),
        Routes.USERS: (context) => UsersScreen(),
        Routes.USER: (context) => UserScreen(),
      };

  MaterialPageRoute handleRoutesWithParam(RouteSettings settings){
    MaterialPageRoute materialPageRoute;
    switch (settings.name) {
      case Routes.USERS:
      //materialPageRoute = makeRoute(SplashScreen());
        break;
      case Routes.LOGIN:
        break;
      case Routes.REGISTER:
        break;
      case Routes.USERS:
        break;
      case Routes.USER:
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
