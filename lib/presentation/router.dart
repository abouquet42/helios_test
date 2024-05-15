import 'package:flutter/material.dart';
import 'package:helios_test/core/model/navigation_arguments/detail_page_arguments.dart';
import 'package:helios_test/core/model/navigation_arguments/home_page_arguments.dart';
import 'package:helios_test/core/model/user.dart';
import 'package:helios_test/data/repository/users_repository.dart';
import 'package:helios_test/presentation/detail_page.dart';

import 'home_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final dynamicArguments = routeSettings.arguments;
    // Instantiate the default route here
    Widget route = Scaffold(
      body: Center(
        child: Text('No route defined for ${routeSettings.name}'),
      ),
    );
    switch (routeSettings.name) {
      case MyHomePage.routeName:
        String title;
        UsersRepository usersRepository;
        if (dynamicArguments is HomePageArguments) {
          title = dynamicArguments.title;
          usersRepository = dynamicArguments.usersRepository;
          route = MyHomePage(
            title: title,
            usersRepository: usersRepository,
          );
          break;
        }
      case DetailPage.routeName:
        User user;
        if (dynamicArguments is DetailPageArguments) {
          user = dynamicArguments.user;
          route = DetailPage(
            user: user,
          );
          break;
        }
    }
    return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => route);
  }
}
