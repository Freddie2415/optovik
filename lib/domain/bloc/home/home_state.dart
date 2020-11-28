part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}


class HomeInitial extends HomeState{
  @override
  List<Object> get props => [];
}


class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeReady extends HomeState {
  final List<Banner> sliders;

  const HomeReady({this.sliders}) : assert(sliders != null);

  @override
  List<Object> get props => [sliders];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({this.message});

  @override
  List<Object> get props => [message];
}
