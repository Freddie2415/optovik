import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/data/api/service/category_service.dart';
import 'package:optovik/data/api/service/feedback_service.dart';
import 'package:optovik/data/api/service/home_service.dart';
import 'package:optovik/data/api/service/info_service.dart';
import 'package:optovik/domain/bloc/categories/categories_bloc.dart';
import 'package:optovik/domain/bloc/feedback/feedback_bloc.dart';
import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/domain/bloc/info/info_cubit.dart';
import 'package:optovik/domain/bloc/localalization/localization_cubit.dart';
import 'package:optovik/domain/bloc/simple_bloc_observer.dart';
import 'package:get_it/get_it.dart';

import 'internal/application.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  setup();
  runApp(Application());
}

setup() async {
  GetIt getIt = GetIt.instance;
  final String languageCode = 'ru';
  final Locale appLocale = Locale(languageCode);
  final HomeService homeService = HomeService();
  CategoryService categoryService = CategoryService();
  final infoService = InfoService();
  final FeedbackService feedbackService = FeedbackService();

  getIt.registerSingleton<LocalizationCubit>(LocalizationCubit(appLocale));
  getIt.registerSingleton<HomeBloc>(HomeBloc(homeService));
  getIt.registerSingleton<CategoriesBloc>(CategoriesBloc(categoryService));
  getIt.registerSingleton<InfoCubit>(InfoCubit(infoService));
  getIt.registerSingleton<FeedbackBloc>(FeedbackBloc(feedbackService));
}
