import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/screen/community/create_community/ctrl_create_community.dart';
import 'package:socialearn/src/widgets/custom_elevated_button.dart';
import 'package:socialearn/src/widgets/custom_textfiled.dart';

class CreateCommunityScreen extends StatelessWidget {
  final CommunityController communityController =
      Get.put(CommunityController());
  CreateCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Community'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            labelText: 'Community Name',
            hintText: 'Flutter Community',
            textEditingController: communityController.nameTextController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            labelText: 'Community Description',
            hintText: 'Flutter Community Description',
            textEditingController:
                communityController.descriptionTextController,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: () async {
              await communityController.createCommunity();
            },
            buttonText: 'Submit',
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 20),
    );
  }
}
