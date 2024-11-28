import 'package:flutter/material.dart';
import 'package:masla_bolo_app/initializer.dart';

import 'helpers/event_bus.dart';
import 'presentation/masla_bolo.dart';

void main() {
  Initializer.initializeApp().then((_) {
    runApp(const MaslaBolo());
  });
}

final eventBus = EventBus();
