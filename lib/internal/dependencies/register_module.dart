import 'package:optovik/data/api/service/register_service.dart';
import 'package:optovik/domain/bloc/register/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterModule {
  static RegisterBloc _registerBloc;

  static Future<RegisterBloc> getRegisterBloc() async {
    if (_registerBloc == null) {
      final _prefs = await SharedPreferences.getInstance();
      _registerBloc = RegisterBloc(RegisterService(), _prefs);
    }

    return _registerBloc;
  }
}
