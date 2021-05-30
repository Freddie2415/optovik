import 'package:optovik/data/api/response/login_response.dart';
import 'package:optovik/data/api/service/service.dart';
import 'package:optovik/domain/model/user.dart';

abstract class AuthRepository extends Service {
  Future<User> getUser(String id);

  Future<void> createUser();

  Future<User> updateUser();

  Future<LoginResponse> authenticate({String username, String password});
}
