import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/screen/auth/login/ctrl_login.dart';
import 'package:socialearn/src/screen/auth/register/sr_register.dart';
import 'package:socialearn/src/screen/home/sr_home.dart';
import 'package:socialearn/src/widgets/custom_elevated_button.dart';
import 'package:socialearn/src/widgets/custom_text_button.dart';
import 'package:socialearn/src/widgets/custom_textfiled.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const FlutterLogo(
              size: 150.0,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              textEditingController: loginController.emailTextController,
              textInputType: TextInputType.name,
              hintText: 'johndoe@gmail.com',
              labelText: 'Email',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              textEditingController: loginController.passwordTextController,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: '******',
              labelText: 'Password',
              obscure: loginController.isObscureText.value,
              suffixIcon: IconButton(
                onPressed: () {
                  loginController.toggleObscureText();
                },
                icon: Icon(!loginController.isObscureText.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                onPressed: () {},
                buttonText: "Forgot Password?",
              ),
            ),
            const SizedBox(height: 5),
            CustomElevatedButton(
              buttonText: 'Login',
              onPressed: () async {
                await loginController.loginUser();
              },
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              buttonText: "Don't have an account?\nPlease register here",
              onPressed: () {
                Get.offAll(() => RegisterScreen());
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}
