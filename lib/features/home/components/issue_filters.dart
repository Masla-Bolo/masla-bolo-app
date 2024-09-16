class IssueFilters {
  bool isSelected;
  String item;

  IssueFilters({
    this.isSelected = false,
    required this.item,
  });

  copyWith({
    bool? isSelected,
    String? category,
  }) =>
      IssueFilters(
        item: category ?? item,
        isSelected: isSelected ?? this.isSelected,
      );

  static final categories = [
    IssueFilters(item: "Electric"),
    IssueFilters(item: "Gas"),
    IssueFilters(item: "Water"),
    IssueFilters(item: "Waste"),
    IssueFilters(item: "Sewerage"),
    IssueFilters(item: "Stormwater"),
    IssueFilters(item: "Roads & Potholes"),
    IssueFilters(item: "Street Lighting"),
    IssueFilters(item: "Public Transportation"),
    IssueFilters(item: "Parks & Recreation"),
    IssueFilters(item: "Illegal Dumping"),
    IssueFilters(item: "Noise Pollution"),
    IssueFilters(item: "Traffic Signals"),
    IssueFilters(item: "Vandalism & Graffiti"),
    IssueFilters(item: "Tree & Vegetation Issues"),
    IssueFilters(item: "Animal Control"),
    IssueFilters(item: "Building Safety"),
    IssueFilters(item: "Fire Safety"),
    IssueFilters(item: "Environmental Hazards"),
    IssueFilters(item: "Parking Violations"),
    IssueFilters(item: "Public Health"),
    IssueFilters(item: "Air Quality"),
    IssueFilters(item: "Zoning & Planning"),
    IssueFilters(item: "Sidewalk Maintenance"),
    IssueFilters(item: "Public Toilets"),
    IssueFilters(item: "Other"),
  ];

  static final sortBy = [
    IssueFilters(item: "latest"),
    IssueFilters(item: "oldest"),
    IssueFilters(item: "Most Liked"),
    IssueFilters(item: "Most Commented"),
    IssueFilters(item: "A-Z"),
    IssueFilters(item: "Z-A"),
    IssueFilters(item: "All"),
  ];
}
