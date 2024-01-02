import 'package:flutter_bloc/flutter_bloc.dart';

import 'Api_Service.dart';

// Events
abstract class CategoryEvent {}

class FetchCategoriesEvent extends CategoryEvent {}

// States
abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final dynamic categories;

  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}

// BLoC
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiService apiService;

  CategoryBloc(this.apiService) : super(CategoryInitialState());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategoriesEvent) {
      yield CategoryInitialState();
      try {
        final categories = await apiService.fetchData('categories');
        yield CategoryLoadedState(categories);
      } catch (e) {
        yield CategoryErrorState('Failed to load categories');
      }
    }
  }
}
