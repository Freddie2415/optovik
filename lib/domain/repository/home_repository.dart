import 'package:optovik/data/api/response/home_response.dart';

abstract class HomeRepository {
  Future<HomeResponse> get();
}