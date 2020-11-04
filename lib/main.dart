import 'package:bus_reservation_systerm/Screens/admin_loading_screen.dart';

import 'Screens/user_loading_screen.dart';
import 'file:///C:/Users/Amr%20Emam/AndroidStudioProjects/bus_reservation_systerm/lib/Screens/login_screen.dart';

import 'package:bus_reservation_systerm/Provider/admin_data_provider.dart';
import 'package:bus_reservation_systerm/Provider/user_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
            create: (_) => UserDataProvider()),
        ChangeNotifierProvider<AdminDataProvider>(
          create: (_) => AdminDataProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Bus Reservation System',
        debugShowCheckedModeBanner: false,
        home: UserLoadingScreen(),
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            textTheme: TextTheme(
              headline1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  letterSpacing: 3.0),
              headline2: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  letterSpacing: 1.0),
              headline3: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 14.0,
              ),
            )),
      ),
    );
  }
}
