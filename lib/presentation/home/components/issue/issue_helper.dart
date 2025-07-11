// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';

import '../../../../helpers/styles/app_colors.dart';

class IssueHelper extends Equatable {
  bool isSelected;
  String item;
  String? key;

  IssueHelper({
    this.isSelected = false,
    required this.item,
    this.key,
  });

  copyWith({
    bool? isSelected,
    String? key,
    String? category,
  }) =>
      IssueHelper(
        item: category ?? item,
        key: key ?? this.key,
        isSelected: isSelected ?? this.isSelected,
      );

  static final categories = [
    IssueHelper(item: "Electric", key: "electric"),
    IssueHelper(item: "Gas", key: "gas"),
    IssueHelper(item: "Water", key: "water"),
    IssueHelper(item: "Waste", key: "waste"),
    IssueHelper(item: "Sewerage", key: "sewerage"),
    IssueHelper(item: "Stormwater", key: "stormwater"),
    IssueHelper(item: "Roads & Potholes", key: "roads_potholes"),
    IssueHelper(item: "Street Lighting", key: "street_lighting"),
    IssueHelper(item: "Public Transportation", key: "public_transportation"),
    IssueHelper(item: "Parks & Recreation", key: "parks_recreation"),
    IssueHelper(item: "Illegal Dumping", key: "illegal_dumping"),
    IssueHelper(item: "Noise Pollution", key: "noise_pollution"),
    IssueHelper(item: "Traffic Signals", key: "traffic_signals"),
    IssueHelper(item: "Vandalism & Graffiti", key: "vandalism_graffiti"),
    IssueHelper(
        item: "Tree & Vegetation Issues", key: "tree_vegetation_issues"),
    IssueHelper(item: "Animal Control", key: "animal_control"),
    IssueHelper(item: "Building Safety", key: "building_safety"),
    IssueHelper(item: "Fire Safety", key: "fire_safety"),
    IssueHelper(item: "Environmental Hazards", key: "environmental_hazards"),
    IssueHelper(item: "Parking Violations", key: "parking_violations"),
    IssueHelper(item: "Public Health", key: "public_health"),
    IssueHelper(item: "Air Quality", key: "air_quality"),
    IssueHelper(item: "Zoning & Planning", key: "zoning_planning"),
    IssueHelper(item: "Sidewalk Maintenance", key: "sidewalk_maintenance"),
    IssueHelper(item: "Public Toilets", key: "public_toilets"),
    IssueHelper(item: "Other", key: "other"),
  ];

  static final sortBy = [
    IssueHelper(item: "latest", key: "-created_at"),
    IssueHelper(item: "oldest", key: "created_at"),
    IssueHelper(item: "Most Liked", key: "-likes_count"),
    IssueHelper(item: "Most Commented", key: "-comments_count"),
    IssueHelper(item: "A-Z", key: "title"),
    IssueHelper(item: "Z-A", key: "-title"),
  ];

  static List<IssueHelper> cloneInitialCategories() {
    final categories = IssueHelper.categories
        .map((category) => category.copyWith(isSelected: false))
        .toList()
        .cast<IssueHelper>();
    return categories;
  }

  static String getIssueStatus(IssueStatus status) {
    switch (status) {
      case IssueStatus.notApproved:
        return "not_approved";
      case IssueStatus.approved:
        return "approved";
      case IssueStatus.solving:
        return "solving";
      case IssueStatus.officialSolved:
        return "official_solved";
      case IssueStatus.solved:
        return "solved";
      // default:
      //   return "not_approved";
    }
  }

  static IssueStatus mapStatus(String jsonStatus) {
    switch (jsonStatus) {
      case 'not_approved':
        return IssueStatus.notApproved;
      case 'approved':
        return IssueStatus.approved;
      case 'solving':
        return IssueStatus.solving;
      case 'official_solved':
        return IssueStatus.officialSolved;
      case 'solved':
        return IssueStatus.solved;
      default:
        return IssueStatus.notApproved;
    }
  }

  static Color getIssueStatusColor(IssueStatus status) {
    final color = status == IssueStatus.approved
        ? AppColor.green
        : status == IssueStatus.notApproved
            ? AppColor.red
            : AppColor.skyBlue;
    return color;
  }

  static String getLikesCount(int likesCount) {
    if (likesCount < 1000) {
      return likesCount.toString();
    } else if (likesCount >= 1000 && likesCount < 1000000) {
      return "${(likesCount / 1000).toStringAsFixed(1)}K";
    } else if (likesCount >= 1000000 && likesCount < 1000000000) {
      return "${(likesCount / 1000000).toStringAsFixed(1)}M";
    } else {
      return "${(likesCount / 1000000000).toStringAsFixed(1)}B";
    }
  }

  static int getValue(
    IssueStatus status,
    List<IssueStatus> totalStatuses,
  ) {
    Map<int, IssueStatus> map = {
      for (int i = 0; i < totalStatuses.length; i++) i: totalStatuses[i]
    };
    if (map.containsValue(status)) {
      return map.entries.firstWhere((entry) => entry.value == status).key;
    }
    return 0;
  }

  @override
  List<Object?> get props => [isSelected, item];
}
