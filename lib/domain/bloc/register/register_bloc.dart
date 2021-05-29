import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/service/register_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterService _registerService;
  final SharedPreferences _prefs;
  static const String REGISTERED_USER_ID = 'registeredUserId';

  RegisterBloc(this._registerService, this._prefs)
      : super(RegisterInitialState()) {
    // print("RegisterBloc initializing!");
    // this.add(CheckLastRegisterEvent());
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // if (event is CheckLastRegisterEvent &&
    //     (_prefs.getString(REGISTERED_USER_ID) != null)) {
    //   yield RegisterSMSVerifyState();
    // }

    if (event is TryRegisterEvent) {
      yield* _tryRegister(event);
    }

    if (event is VerifySMSRegisterEvent) {
      yield* _tryVerify(event);
    }
  }

  Stream<RegisterState> _tryRegister(TryRegisterEvent event) async* {
    yield TryingRegisterState();

    try {
      final String userId = await _registerService.register(
        username: event.username,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      await _prefs.setString(REGISTERED_USER_ID, userId);

      yield RegisterSMSVerifyState(event.username);
    } catch (e) {
      print(e);
      yield RegisterFailureState(e.toString());
    }
  }

  Stream<RegisterState> _tryVerify(VerifySMSRegisterEvent event) async* {
    yield TryingRegisterState();

    try {
      String userId = _prefs.getString(REGISTERED_USER_ID);
      bool successfullyVerified =
          await _registerService.verify(event.smsCode, userId);
      if (successfullyVerified) {
        _prefs.remove(REGISTERED_USER_ID);
        yield RegisteredSuccessfullyState();
      } else {
        yield RegisterFailureState('Ваш код не подходит');
      }
    } catch (e) {
      print(e);
      yield RegisterFailureState(e.toString());
    }
  }
}
