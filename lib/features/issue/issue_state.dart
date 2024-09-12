import 'package:flutter/material.dart';

class IssueState {
  final GlobalKey<FormState> key;
  IssueState({required this.key});

  copyWith({GlobalKey<FormState>? key}) => IssueState(key: key ?? this.key);

  factory IssueState.empty() => IssueState(key: GlobalKey<FormState>());
}
