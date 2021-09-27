import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/Screens/login_screen.dart';
import 'package:rider_app/Screens/main_screen.dart';
import 'package:rider_app/Screens/registration_screen.dart';
import 'package:rider_app/Screens/ride_request_screen.dart';
import 'package:rider_app/Screens/search_screen.dart';

import 'Services/location_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetLocation.getCurrentLocation();
  runApp(MyApp());
}

const String path = 'users';
DatabaseReference userRef = FirebaseDatabase.instance.reference().child(path);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Rider App',
        theme: ThemeData(
          fontFamily: 'bolt semibold',
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.id
            : MainScreen.id,
        routes: {
          RideRequestScreen.id: (context) => RideRequestScreen(),
          SearchScreen.id: (context) => SearchScreen(),
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
        },
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      ),
    );
  }
}
