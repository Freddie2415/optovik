import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/response/banner_response.dart';
import 'package:optovik/data/api/service/banner_service.dart';
import 'package:meta/meta.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerService bannerService;

  BannerCubit({@required this.bannerService}) : super(BannerInitial());

  void loadBanners() async {
    emit(BannerLoading());
    try {
      final List<BannerResponse> bannerList = await bannerService.getBanners();
      if (bannerList.isEmpty) {
        throw "Баннеров нет";
      }
      final List<String> banners = bannerList.map((e) => e.photo).toList();
      emit(BannerSuccess(banners));
    } catch (e) {
      print(e);
      emit(BannerFailure());
    }
  }
}
