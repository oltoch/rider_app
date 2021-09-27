import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/FirebaseActions/login_class.dart';
import 'package:rider_app/Screens/main_screen.dart';
import 'package:rider_app/Screens/registration_screen.dart';
import 'package:rider_app/Services/geocodingModel.dart';
import 'package:rider_app/Services/location_class.dart';
import 'package:rider_app/Widgets/login_register_button_widget.dart';
import 'package:rider_app/Widgets/text_field_widget.dart';
import 'package:rider_app/main.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreenId';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "Login as a Rider",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "bolt",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    TextFieldWidget(
                        controller: _emailTextEditingController,
                        label: "Email",
                        prefixIcon: Icons.email_sharp,
                        textInputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 1,
                    ),
                    TextFieldWidget(
                      controller: _passwordTextEditingController,
                      label: "Password",
                      prefixIcon: Icons.password,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    LoginOrRegisterButton(
                      onPress: () async {
                        LoginWithEmailAndPassword login =
                            LoginWithEmailAndPassword(
                                context: context,
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text);
                        bool verify = login.verifyEntry();
                        if (verify) {
                          User? user = await login.loginUser();
                          if (user != null) {
                            userRef
                                .child(user.uid)
                                .once()
                                .then((DataSnapshot snapshot) async {
                              if (snapshot.value != null) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, MainScreen.id, (route) => false);
                                EasyLoading.showSuccess('Logged in');
                              } else {
                                //Navigator.pop(context);
                                await login.logOut();
                                EasyLoading.showError(
                                    'No record found for this user. Please create a new account');
                              }
                            });
                          } else {
                            EasyLoading.showError(
                                'Check network and try again');
                          }
                        }
                      },
                      text: 'Login',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: Text(
                  'Don\'t have an account? Register here.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await GetLocation.getCurrentLocation();
    if (LatLng(37.42796133580664, -122.085749655962) != GetLocation.latLng) {
      await GeocodingModel.getAddressFromCoordinate(
          GetLocation.position, context);
    }
  }
}
