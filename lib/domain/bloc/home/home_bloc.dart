import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/response/home_response.dart';
import 'package:optovik/data/api/service/home_service.dart';
import 'package:optovik/domain/model/banner.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/domain/model/product.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _homeService;

  HomeBloc(this._homeService) : super(HomeInitial()) {
    print("HOME BLOC INSTALLED");
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeStart) {
      try {
        yield HomeLoading();

        final HomeResponse result = await _homeService.get();

        yield HomeReady(
          banners: result.banners,
          hotDeals: result.hotDeals,
          hotProducts: result.hotProducts,
          lastProducts: result.lastProducts,
          categories: result.categories,
        );
      } catch (e) {
        print(e);
        yield HomeError(message: e.toString());
      }
    }

    if (event is HomeEventRefresh) {
      try {
        final HomeResponse result = await _homeService.get();

        yield HomeReady(
          banners: result.banners,
          hotDeals: result.hotDeals,
          hotProducts: result.hotProducts,
          lastProducts: result.lastProducts.reversed.toList(),
          categories: result.categories,
        );
      } catch (e) {
        print(e);
        yield HomeError(message: e.toString());
      }
    }
  }
}
