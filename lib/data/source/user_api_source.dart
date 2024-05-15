import 'dart:convert';
import 'package:helios_test/core/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:helios_test/data/repository/users_repository.dart';

class UsersApiSource {
  Future<List<dynamic>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=20'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class UsersRepositoryImpl implements UsersRepository {
  final UsersApiSource usersApiSource;

  UsersRepositoryImpl({required this.usersApiSource});

  @override
  Future<List<User>> getUsers() async {
    final users = await usersApiSource.getUsers();
    return users.map((json) => User.fromJson(json)).toList();
  }
}
