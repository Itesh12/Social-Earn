import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/screen/auth/login/sr_login.dart';
import 'package:socialearn/src/screen/auth/register/ctrl_register.dart';
import 'package:socialearn/src/widgets/custom_elevated_button.dart';
import 'package:socialearn/src/widgets/custom_text_button.dart';
import 'package:socialearn/src/widgets/custom_textfiled.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Obx(() {
          return Column(
            children: [
              const FlutterLogo(
                size: 150.0,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController:
                    registerController.usernameTextController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: 'John Doe',
                labelText: 'Username',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'johndoe@gmail.com',
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: registerController.emailTextController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController:
                    registerController.passwordTextController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                labelText: 'Password',
                hintText: '******',
                obscure: registerController.isObscureText.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    registerController.toggleObscureText();
                  },
                  icon: Icon(!registerController.isObscureText.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
              const SizedBox(height: 20),
              registerController.isLoading.value
                  ? const CircularProgressIndicator() // Show loading indicator when loading
                  : CustomElevatedButton(
                      buttonText: 'Register',
                      onPressed: () async {
                        await registerController.registerUser();
                      },
                    ),
              const SizedBox(height: 20),
              CustomTextButton(
                buttonText: 'Already have an account?\nPlease login here',
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
              )
            ],
          );
        }).paddingSymmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}
