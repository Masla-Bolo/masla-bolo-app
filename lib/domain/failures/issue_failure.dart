import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';

class IssueFailure {
  String error;
  IssueEntity? issue;
  Paginate<IssueEntity>? issues;
  IssueFailure({required this.error, this.issue, this.issues});
}
