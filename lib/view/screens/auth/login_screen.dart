import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/viewModels/auth_view_model.dart';

import '../../../common/colors.dart';
import '../../../common/images.dart';
import '../../commonWidgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/beneficiaries-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? beneficiaryEmail;
  TextEditingController? beneficiaryPassword;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    beneficiaryEmail = TextEditingController(text: "");
    beneficiaryPassword = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    AppImages.appLogo2,
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    "Login to start your session",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomTextField(
                    hint: "Enter the email",
                    charLength: 40,
                    textController: beneficiaryEmail!,
                    icon: Icons.email,
                    validation: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter the email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: "Enter the password",
                    charLength: 40,
                    isNumber: true,
                    isPassword: true,
                    textController: beneficiaryPassword!,
                    icon: Icons.password,
                    validation: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter the password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthViewModel>()
                            .navigateToTheDashboard(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.activeColor,
                        foregroundColor: MyColors.whiteColor,
                        elevation: 5,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
