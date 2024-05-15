import 'package:flutter/material.dart';
import 'package:helios_test/data/repository/users_repository.dart';
import 'package:helios_test/data/source/user_api_source.dart';
import 'package:helios_test/presentation/home_page.dart';
import 'package:helios_test/presentation/router.dart' as router;

void main() {
  final UsersApiSource userApiSource = UsersApiSource();
  final UsersRepository usersRepository = UsersRepositoryImpl(usersApiSource: userApiSource);

  runApp( MyApp(usersRepository: usersRepository));
}

class MyApp extends StatelessWidget {
  final UsersRepository usersRepository;

  const MyApp({super.key, required this.usersRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: router.Router.generateRoute,
      home: MyHomePage(title: 'Flutter Demo List', usersRepository: usersRepository,),
    );
  }
}
