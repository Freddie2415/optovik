import 'package:optovik/domain/model/user.dart';

abstract class UserRepository {
  Future<User> getUser();

  Future<void> createUser();
}
