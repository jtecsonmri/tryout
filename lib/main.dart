import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService().initPushNotifications();
  runApp(const HcApp());
}
