class IssueDetailInitialParams {
  bool showComment;
  int issueId;

  IssueDetailInitialParams({
    this.showComment = false,
    required this.issueId,
  });
}
