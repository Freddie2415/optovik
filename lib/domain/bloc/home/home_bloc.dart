import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/banner.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    this.add(HomeStart());
  }

  List<Banner> sliders = [
    Banner(0, "https://www.visir.is/i/07877132582BC871687A481B5CC9733CC79544B86D78F23EE8D35DF3D0A75671_1600x900.jpg"),
    Banner(1, "https://img3.goodfon.ru/original/1600x900/c/4b/kofe-zerna-chashka-korica-sahar-122.jpg"),
    Banner(2, "https://www.nastol.com.ua/pic/201812/1600x900/nastol.com.ua-312488.jpg"),
    Banner(3, "https://wallbox.ru/resize/1600x900/wallpapers/main2/201723/149690905959390503d2ece1.20361719.jpg"),
  ];

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeStart) {
      try {
        yield HomeLoading();

        await Future.delayed(Duration(seconds: 1));

        yield HomeReady(sliders: sliders);
      } catch (e) {
        print(e);
        yield HomeError(message: e.toString());
      }
    }
  }
}
