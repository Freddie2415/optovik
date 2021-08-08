import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optovik/data/api/service/category_service.dart';
import 'package:optovik/data/mapper/category_mapper.dart';
import 'package:optovik/domain/model/category.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoryService) : super(CategoriesInitial()) {
    this.add(LoadCategories());
  }

  final CategoryService _categoryService;

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield CategoriesLoading();

      try {
        final result = await _categoryService.getCategories();
        final categories = CategoryMapper.fromApiList(result);

        yield CategoriesReady(categories);
      } catch (e) {
        print(e);
        yield CategoriesError(message: e.toString());
      }
    }

    if (event is RefreshCategories) {
      try {
        final result = await _categoryService.getCategories();
        final categories = CategoryMapper.fromApiList(result);

        yield CategoriesReady(categories);
      } catch (e) {
        print(e);
        yield CategoriesError(message: e.toString());
      }
    }
  }
}
