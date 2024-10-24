import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masla_bolo_app/service/permission_service.dart';
import '../../domain/entities/issue_entity.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../service/location_service.dart';
import '../bottom_bar/bottom_bar_cubit.dart';
import '../home/components/issue/issue_helper.dart';
import 'create_issue_navigator.dart';
import 'create_issue_state.dart';
import '../../helpers/helpers.dart';
import '../../service/image_service.dart';

import '../../di/service_locator.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  final CreateIssueNavigator navigator;
  final ImageService imageHelper;
  final IssueRepository issueRepository;
  final LocationService locationService;
  final PermissionService permissionService;
  CreateIssueCubit(
    this.navigator,
    this.imageHelper,
    this.issueRepository,
    this.locationService,
    this.permissionService,
  ) : super(CreateIssueState.empty());

  Future<void> getImages() async {
    final images = await imageHelper.getImages();
    if (images.isNotEmpty) {
      state.issue.fileImages.addAll(images);
      emit(state.copyWith(issue: state.issue));
    }
  }

  Future<void> uploadImages() async {
    final images = await imageHelper.uploadImages(state.issue.fileImages);
    state.issue.images = images;
  }

  Future<void> createIssue() async {
    if (state.issue.images.isEmpty) {
      showToast("Provide an image or a video as a proof");
      return;
    }
    final isValid = (state.key.currentState?.validate() ?? false);
    if (isValid && state.categories.any((value) => value.isSelected)) {
      await permissionService.permissionServiceCall();
      return locationService.getLocation().then((enabled) {
        if (enabled) {
          uploadImages().then((_) {
            state.issue.latitude = locationService.position.latitude;
            state.issue.longitude = locationService.position.longitude;
            final categories = state.categories
                .where((val) => val.isSelected)
                .map((value) => value.item)
                .toList();
            state.issue.categories = categories;

            return issueRepository.createIssue(state.issue).then(
              (result) {
                getIt<BottomBarCubit>().updateIndex(0);
                emit(state.copyWith(
                  issue: IssueEntity.empty(),
                  categories: IssueHelper.cloneInitialCategories(),
                ));
              },
            );
          });
        } else {
          showToast(
            "Location services are disabled, turn on your locations to create an issue",
          );
        }
      });
    }
  }

  void updateSelection(IssueHelper value) {
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
    final categories = state.categories;
    categories.map((category) {
      category.isSelected = false;
    });
    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void changeAnonymous(bool val) {
    state.issue.isAnonymous = val;
    emit(state.copyWith(issue: state.issue));
  }

  void removeMedia(XFile image) {
    state.issue.fileImages.remove(image);
    emit(state.copyWith(issue: state.issue));
  }
}
