import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/service/info_service.dart';
import 'package:optovik/domain/model/page.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  final InfoService infoService;

  InfoCubit(this.infoService) : super(InfoInitial());

  void load() async {
    try {
      String token = await AuthModule.authService().getToken();
      List<Page> pages = await infoService.getAll(token);

      emit(InfoSuccess(pages: pages));
    } catch (e) {
      print(e);
      emit(InfoFailure(e.toString()));
    }
  }
}
