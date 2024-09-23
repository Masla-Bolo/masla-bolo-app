class IssueHelper {
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
        key: key,
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
    IssueHelper(item: "latest"),
    IssueHelper(item: "oldest"),
    IssueHelper(item: "Most Liked"),
    IssueHelper(item: "Most Commented"),
    IssueHelper(item: "A-Z"),
    IssueHelper(item: "Z-A"),
    IssueHelper(item: "All"),
  ];

  static List<IssueHelper> cloneCategories() {
    final categories = IssueHelper.categories
        .map((category) => category.copyWith(isSelected: false))
        .toList()
        .cast<IssueHelper>();
    return categories;
  }

  static List<String> getCategoryFromJson(List<String> jsonCategories) {
    final matchedCategories = categories.map((category) {
      if (jsonCategories.contains(category.key)) {
        return category.item;
      }
      return "";
    }).toList();
    return matchedCategories.where((category) => category != "").toList();
  }

  static List<String> getKeysFromCategories(List<String> categoryValues) {
    final matchedCategories = categories.map((category) {
      if (categoryValues.contains(category.item)) {
        return category.key ?? "";
      }
      return "";
    }).toList();
    return matchedCategories.where((category) => category != "").toList();
  }
}
