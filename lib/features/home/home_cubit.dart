import 'package:masla_bolo_app/features/home/components/issue_filters.dart';
import 'package:masla_bolo_app/features/home/home_navigator.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_initial_params.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigation;
  HomeCubit(this.navigation) : super(HomeState.empty());

  pop() {
    navigation.pop();
  }

  goToIssueDetail({bool showComment = false}) {
    navigation
        .goToIssueDetail(IssueDetailInitialParams(showComment: showComment));
  }

  void updateCategorySelection(IssueFilters value) {
    final categories = state.categories.map((category) {
      if (category.item == value.item) {
        category.isSelected = !value.isSelected;
      }
      return category;
    }).toList();

    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void clearAllCategoryFilters() {
    final categories = state.categories.map((category) {
      category.isSelected = false;
      return category;
    }).toList();

    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void applyFilters() {
    state.categories.where((value) => value.isSelected == true).toList();
  }

  void updateSortBySelection(IssueFilters value) {
    final sortBy = state.sortBy.map((sortValue) {
      if (sortValue.item == value.item) {
        sortValue.isSelected = !value.isSelected;
      } else if (sortValue.item != value.item) {
        sortValue.isSelected = false;
      }
      return sortValue;
    }).toList();

    emit(
      state.copyWith(
        sortBy: sortBy,
      ),
    );
  }

  void clearSortByFilter() {
    final sortBy = state.sortBy.map((sortValue) {
      sortValue.isSelected = false;
      return sortValue;
    }).toList();

    emit(
      state.copyWith(
        sortBy: sortBy,
      ),
    );
  }
}
