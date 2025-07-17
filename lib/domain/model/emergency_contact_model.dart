import 'package:masla_bolo_app/domain/model/emergency_contact_item_model.dart';

class EmergencyContactModel {
  EmergencyContactItemModel primaryContact;
  EmergencyContactItemModel secondaryContact;

  EmergencyContactModel({
    required this.primaryContact,
    required this.secondaryContact,
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      primaryContact:
          EmergencyContactItemModel.fromJson(json['primary_contact']),
      secondaryContact:
          EmergencyContactItemModel.fromJson(json['primary_contact']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primary_contact': primaryContact.toJson(),
      'secondary_contact': secondaryContact.toJson(),
    };
  }
}
