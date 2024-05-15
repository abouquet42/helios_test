import 'package:helios_test/core/model/user.dart';
import 'package:helios_test/data/repository/users_repository.dart';

class GetUsersUseCase {
  final UsersRepository usersRepository;

  GetUsersUseCase({required this.usersRepository});

  Future<List<User>> execute() async {
    return await usersRepository.getUsers();
  }
}