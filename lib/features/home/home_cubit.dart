import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';
import 'package:masla_bolo_app/features/home/home_navigator.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_initial_params.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigation;
  final IssueRepository issueRepository;
  HomeCubit(this.navigation, this.issueRepository) : super(HomeState.empty());

  getIssues() {
    emit(state.copyWith(isLoaded: false));
    issueRepository.getIssues(queryParams: state.queryParams).then(
          (issues) => emit(
            state.copyWith(
              issues: issues,
              isLoaded: true,
            ),
          ),
        );
  }

  debounce(String value) {
    if (value.isEmpty) {
      return;
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        state.queryParams.addAll({"search": value});
        getIssues();
      });
    }
  }

  pop() {
    navigation.pop();
  }

  goToIssueDetail({bool showComment = false, required IssueEntity issue}) {
    navigation.goToIssueDetail(
        IssueDetailInitialParams(showComment: showComment, issue: issue));
  }

  void updateCategorySelection(IssueHelper value) {
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
    final addFilters = state.categories
        .where((value) => value.isSelected == true)
        .map((value) => value.key)
        .toList();

    if (addFilters.isNotEmpty) {
      state.queryParams.addAll({
        'categories': addFilters.join(','),
      });
      getIssues();
    }
  }

  void updateSortBySelection(IssueHelper value) {
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

  goToNotification() {
    navigation.goToNotification();
  }
}
