part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStart extends HomeEvent{
  @override
  List<Object> get props => [];
}

class HomeEventRefresh extends HomeEvent {
  @override
  List<Object> get props => [];
}
