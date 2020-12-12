import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/internal/dependencies/repository_module.dart';

class HomeModule {
  static HomeBloc homeBloc() {
    return HomeBloc(RepositoryModule.homeRepository());
  }
}
