import 'package:optovik/data/api/service/auth_service.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/login/login_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';
import 'package:optovik/internal/dependencies/storage_module.dart';

class AuthModule {
  static AuthBloc _authBloc;

  static AuthBloc authBloc() {
    if (_authBloc == null) {
      _authBloc = AuthBloc(AuthService(
        RepositoryModule.userRepository(),
        StorageModule.sharedPrefsInstance(),
      ));
    }
    return _authBloc;
  }

  static LoginBloc loginBloc() => LoginBloc(authBloc());
}
