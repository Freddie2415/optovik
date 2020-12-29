import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/login/login_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class AuthModule {
  static AuthBloc _authBloc;

  static AuthBloc authBloc() {
    if (_authBloc == null) {
      _authBloc = AuthBloc(
        authRepository: RepositoryModule.authRepository(),
        userRepository: RepositoryModule.userRepository(),
      );
    }
    return _authBloc;
  }

  static LoginBloc loginBloc() => LoginBloc(
        authRepository: RepositoryModule.authRepository(),
      );
}
