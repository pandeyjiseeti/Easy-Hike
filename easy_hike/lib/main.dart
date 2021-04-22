import 'package:easy_hike/service_locator.dart';
import 'package:flutter/material.dart';
import 'app.dart';

// Branch check
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(App());
}
