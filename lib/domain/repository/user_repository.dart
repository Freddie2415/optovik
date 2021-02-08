import 'package:optovik/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUser();

  Future<void> createUser();

  Future<User> updateUser();

  Future<bool> hasToken();

  Future<void> saveToken({String jwt});

  Future<void> deleteToken();

  Future<String> authenticate({String login, String password});
}
