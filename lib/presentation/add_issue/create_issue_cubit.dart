import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/service/permission_service.dart';
import '../../domain/entities/issue_entity.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../helpers/styles/app_images.dart';
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
    final images = await imageHelper.showOptionsWithMulti();
    if (images.isNotEmpty) {
      state.issue.fileImages.addAll(images);
      emit(state.copyWith(issue: state.issue));
    }
  }

  Future<void> createIssue() async {
    if (state.issue.fileImages.isEmpty) {
      showToast("Provide an image or a video as a proof");
      return;
    }

    final isValid = (state.key.currentState?.validate() ?? false);
    if (!isValid) {
      showToast("Fill in the required fields!");
      return;
    }
    if (!state.categories.any((value) => value.isSelected)) {
      showToast("Select categories that apply");
      return;
    }

    await permissionService.permissionServiceCall();
    final enabled = await locationService.getLocation();

    if (!enabled) {
      showToast(
          "Location services are disabled, turn on your locations to create an issue");
      return;
    }

    final images = await imageHelper.uploadImages(state.issue.fileImages);

    if (images.isEmpty) {
      showToast("Provide an image or a video as a proof");
      return;
    }

    state.issue.images = images;
    state.issue.location.latitude = locationService.position.latitude;
    state.issue.location.longitude = locationService.position.longitude;

    final categories = state.categories
        .where((val) => val.isSelected)
        .map((value) => value.item)
        .toList();

    state.issue.categories = categories;

    final response = await issueRepository.createIssue(state.issue);

    response.fold(
      (error) {
        showToast(error.error);
      },
      (success) {
        showToast("Issue created successfully",
            params: ToastParam(
              backgroundColor: AppColor.green,
              image: AppImages.successful,
              textColor: AppColor.white,
            ));
        getIt<BottomBarCubit>().updateIndex(0);
        emit(
          state.copyWith(
            issue: IssueEntity.empty(),
            categories: IssueHelper.cloneInitialCategories(),
          ),
        );
      },
    );
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
