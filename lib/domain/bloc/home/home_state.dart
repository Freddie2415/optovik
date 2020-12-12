part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeReady extends HomeState {
  final List<Banner> banners;
  final List<Product> hotDeals;
  final List<Product> hotProducts;
  final List<Product> lastProducts;
  final List<Category> categories;

  const HomeReady({
    this.banners,
    this.hotDeals,
    this.hotProducts,
    this.lastProducts,
    this.categories,
  }) : assert(banners != null);

  @override
  List<Object> get props => [banners];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({this.message});

  @override
  List<Object> get props => [message];
}
