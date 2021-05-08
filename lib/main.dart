import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/person.dart';
import 'profile_page_sample.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox('settingBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePageSample(),
    );
  }
}