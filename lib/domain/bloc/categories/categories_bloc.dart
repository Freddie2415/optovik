import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/domain/model/category.dart';
import 'package:optovik/domain/repository/category_repository.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoryRepository) : super(CategoriesInitial()) {
    this.add(LoadCategories());
  }

  final CategoryRepository _categoryRepository;

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield CategoriesLoading();

      try {
        final categories = await _categoryRepository.getCategories();

        yield CategoriesReady(categories);
      } catch (e) {
        print(e);
        yield CategoriesError(message: e.toString());
      }
    }
  }
}
