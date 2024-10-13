import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/screen/auth/login/sr_login.dart';
import 'package:socialearn/src/screen/auth/register/ctrl_register.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController c = Get.put(RegisterController());
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            FlutterLogo(
              size: 150.0,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: c.usernameTextController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('Username'),
                hintText: 'John Doe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'johndoe@gmail.com',
              labelText: 'Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: c.emailTextController,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: c.passwordTextController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: '******',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility_outlined),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await c.registerUser();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Already have an account? Please login here'),
            )
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 20),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final bool obscure;
  const CustomTextField({
    super.key,
    this.hintText = '',
    this.labelText = '',
    this.textInputType,
    this.textEditingController,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      obscureText: obscure,
      decoration: InputDecoration(
        label: Text(labelText ?? ''),
        hintText: hintText ?? '',
        border: OutlineInputBorder(),
      ),
    );
  }
}
