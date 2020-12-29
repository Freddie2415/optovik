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
}
