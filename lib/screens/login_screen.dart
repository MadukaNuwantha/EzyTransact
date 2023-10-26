import 'package:ezytransact/constants.dart';
import 'package:ezytransact/screens/registration_screen.dart';
import 'package:ezytransact/services/authentication_service.dart';
import 'package:ezytransact/size_config.dart';
import 'package:ezytransact/widgets/custom_password_field.dart';
import 'package:ezytransact/widgets/custom_submit_button.dart';
import 'package:ezytransact/widgets/custom_text_field.dart';
import 'package:ezytransact/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Log into the system',
                  style: TextStyle(
                    color: kDarkSecondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                CircleAvatar(
                  radius: SizeConfig.blockSizeHorizontal * 42,
                  backgroundColor: kPrimaryColor,
                  child: Image.asset(
                    kLoginImage,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Text(
                  'Enter your credentials to access the app',
                  style: TextStyle(
                    color: kDarkSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 10),
                      CustomPasswordField(
                        controller: passwordController,
                        labelText: 'Password',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: kDarkSecondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: kDarkAccentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 15),
                CustomSubmitButton(
                  title: 'Login',
                  color: kPrimaryColor,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (validateEmail(emailController.text)) {
                        Provider.of<AuthenticationService>(context,
                                listen: false)
                            .signInWithEmailAndPassword(
                          context,
                          emailController.text,
                          passwordController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar(
                              'Please enter a valid email to continue'),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
