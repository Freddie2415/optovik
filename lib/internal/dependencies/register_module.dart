import 'package:optovik/data/api/service/auth_service.dart';
import 'package:optovik/domain/bloc/register/register_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';
import 'package:optovik/internal/dependencies/storage_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterModule {
  static RegisterBloc _registerBloc;

  static Future<RegisterBloc> getRegisterBloc() async {
    if (_registerBloc == null) {
      final _prefs = await SharedPreferences.getInstance();
      _registerBloc = RegisterBloc(
          AuthService(
            RepositoryModule.userRepository(),
            StorageModule.sharedPrefsInstance(),
          ),
          _prefs);
    }
    return _registerBloc;
  }
}
