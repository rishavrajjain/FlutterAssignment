//import 'package:assignment/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'pages/first_page.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      home:FirstPage(cameras),
    );
  }
}