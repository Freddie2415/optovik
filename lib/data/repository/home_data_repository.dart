import 'package:optovik/data/api/api_utils.dart';
import 'package:optovik/data/api/response/home_response.dart';
import 'package:optovik/domain/repository/home_repository.dart';

class HomeDataRepository extends HomeRepository {
  final ApiUtil _apiUtil;

  HomeDataRepository(this._apiUtil);

  @override
  Future<HomeResponse> get() async {
    return await _apiUtil.getHomeData();
  }
}
