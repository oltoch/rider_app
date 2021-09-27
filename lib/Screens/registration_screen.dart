import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rider_app/FirebaseActions/registration_class.dart';
import 'package:rider_app/Screens/login_screen.dart';
import 'package:rider_app/Widgets/login_register_button_widget.dart';
import 'package:rider_app/Widgets/text_field_widget.dart';

import '../main.dart';
import 'main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreenId';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _phoneTextEditingController.dispose();
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
                height: 20,
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
                "Register as a Rider",
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
                      controller: _nameTextEditingController,
                      label: "Name",
                      prefixIcon: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextFieldWidget(
                      controller: _emailTextEditingController,
                      label: "Email",
                      prefixIcon: Icons.email_sharp,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextFieldWidget(
                      controller: _phoneTextEditingController,
                      label: "Phone",
                      prefixIcon: Icons.phone_android_sharp,
                      textInputType: TextInputType.phone,
                    ),
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
                      height: 20,
                    ),
                    LoginOrRegisterButton(
                      onPress: () async {
                        RegisterWithEmailAndPassword register =
                            RegisterWithEmailAndPassword(
                                context: context,
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text,
                                phone: _phoneTextEditingController.text,
                                name: _nameTextEditingController.text);
                        bool verify = register.verifyEntry();
                        User? user;
                        if (verify) {
                          user = await register.registerNewUser();

                          if (user != null) {
                            try {
                              await userRef
                                  .child(user.uid)
                                  .set(register.userDataMap());
                              print('Account Created Successfully');
                              EasyLoading.showSuccess(
                                  'Account created successfully');
                              Navigator.pushNamedAndRemoveUntil(
                                  context, MainScreen.id, (route) => false);
                            } catch (e) {
                              Navigator.pop(context);
                              print("Error occurred " + e.toString());
                              EasyLoading.showError(
                                  'Error occurred, check connection and try again');
                            }
                          }
                        }
                      },
                      text: 'Register',
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                },
                child: Text(
                  'Already have an account? Login here.',
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
}
