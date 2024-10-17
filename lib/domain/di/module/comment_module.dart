import '../../repositories/comment_repository.dart';

import '../../../data/comment/api_comment_repository.dart';
import '../../../di/service_locator.dart';

class CommentModule {
  static Future<void> configureCommentModuleInjection() async {
    getIt.registerSingleton<CommentRepository>(
      ApiCommentRepository(
        getIt(),
        getIt(),
      ),
    );
  }
}
