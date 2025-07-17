class EmergencyContactItemModel {
  String type;
  String phone;
  String email;

  EmergencyContactItemModel({
    required this.type,
    required this.phone,
    required this.email,
  });

  factory EmergencyContactItemModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactItemModel(
      type: json['type'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phone': phone,
      'email': email,
    };
  }
}
