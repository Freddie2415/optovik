part of 'tree_cubit.dart';

abstract class TreeState extends Equatable {
  const TreeState();
}

class TreeInitial extends TreeState {
  @override
  List<Object> get props => [];
}
