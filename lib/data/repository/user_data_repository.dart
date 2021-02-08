import 'package:optovik/domain/model/user.dart';
import 'package:optovik/domain/repository/user_repository.dart';

class UserDataRepository extends UserRepository {
  User _user;

  @override
  Future<void> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser() async {
    if (_user != null) {
      return _user;
    }
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        id: 1,
        firstName: "Test",
        lastName: "TestLastName",
        email: "test@test.com",
        username: "test",
        phone: "+998933532415",
      ),
    );
  }

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<bool> hasToken() {
    // TODO: implement hasToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveToken({String jwt}) {
    // TODO: implement saveToken
    throw UnimplementedError();
  }

  @override
  Future<String> authenticate({String login, String password}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
