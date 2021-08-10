part of 'info_cubit.dart';

abstract class InfoState extends Equatable {
  const InfoState();

  @override
  List<Object> get props => [];
}

class InfoInitial extends InfoState {}

class InfoSuccess extends InfoState {
  final List<Page> pages;

  InfoSuccess({this.pages = const []});

  @override
  List<Object> get props => [pages];
}

class InfoFailure extends InfoState {
  final String message;

  InfoFailure(this.message);
}
