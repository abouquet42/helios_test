import 'package:helios_test/core/model/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
}
