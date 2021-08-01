import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit(Locale initialLocale) : super(initialLocale);

  setLocale(Locale locale) {
    emit(locale);
  }

  Locale get currentLocale => state;

  String getCurrentLocaleTitle(Locale locale) {
    String langTitle = 'Русский';
    switch (locale.toLanguageTag()) {
      case 'ru':
        langTitle = 'Русский';
        break;
      case 'uz':
        langTitle = "O'zbek";
        break;
      case 'en':
        langTitle = 'English';
        break;
    }

    return langTitle;
  }
}
