import 'package:ezytransact/constants.dart';
import 'package:ezytransact/screens/login_screen.dart';
import 'package:ezytransact/services/authentication_service.dart';
import 'package:ezytransact/size_config.dart';
import 'package:ezytransact/widgets/custom_password_field.dart';
import 'package:ezytransact/widgets/custom_submit_button.dart';
import 'package:ezytransact/widgets/custom_text_field.dart';
import 'package:ezytransact/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Register to the system',
                        style: TextStyle(
                          color: kDarkSecondaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Image.asset(
                      kRegisterImage,
                      width: SizeConfig.blockSizeHorizontal * 60,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Text(
                      'Enter your details to register to the app ',
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
                            controller: nameController,
                            labelText: 'Name',
                          ),
                          const SizedBox(height: 10),
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
                          CustomPasswordField(
                            controller: confirmPasswordController,
                            labelText: 'Confirm Password',
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member? ',
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: kDarkAccentColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomSubmitButton(
                      title: 'Register',
                      color: kPrimaryColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (validateEmail(emailController.text)) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              Provider.of<AuthenticationService>(context,
                                      listen: false)
                                  .registerUser(
                                context,
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                errorSnackBar('Passwords does not match!'),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              errorSnackBar(
                                  'Please enter a valid email to continue'),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
