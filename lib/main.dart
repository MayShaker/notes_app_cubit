import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/network/api_client.dart';
import 'core/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Hive.initFlutter();
  await SharedPrefsManager.init(); 


  ApiClient.initDio();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notes App'),
        ),
        body: Center(
          child: Text('Welcome to Notes App!'),
        ),
      ),
    );
  }
}
