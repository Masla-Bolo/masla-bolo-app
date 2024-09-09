import 'package:flutter/material.dart';

class IssueState {
  IssueState();

  final key = GlobalKey<FormState>();

  copyWith() => IssueState();

  factory IssueState.empty() => IssueState();
}
