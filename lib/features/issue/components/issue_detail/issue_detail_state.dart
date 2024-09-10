import 'package:flutter/material.dart';

class IssueDetailState {
  IssueDetailState();

  final key = GlobalKey<FormState>();

  copyWith() => IssueDetailState();

  factory IssueDetailState.empty() => IssueDetailState();
}
