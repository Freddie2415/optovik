part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final List<String> banners;

  BannerSuccess(this.banners);
}

class BannerFailure extends BannerState {}
