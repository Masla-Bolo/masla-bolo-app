class NotificationState {
  NotificationState();

  copyWith() => NotificationState();

  final notifications = [
    {
      "title": "Pothole Report Resolved",
      "description": "The pothole you reported has been fixed.",
      "time": "2h ago"
    },
    {
      "title": "New Update on Sewerage Issue",
      "description": "The sewerage issue is being reviewed.",
      "time": "5h ago"
    },
    {
      "title": "Waste Collection Delayed",
      "description": "Waste collection in your area will be delayed.",
      "time": "1d ago"
    },
    {
      "title": "Water Supply Issue Logged",
      "description": "Your water supply issue has been logged.",
      "time": "2d ago"
    },
    {
      "title": "Street Light Repair Scheduled",
      "description": "Repair of broken street lights will start tomorrow.",
      "time": "3d ago"
    },
  ];

  factory NotificationState.empty() => NotificationState();
}
