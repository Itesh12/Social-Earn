import 'package:flutter/material.dart';
import 'package:socialearn/src/core/models/community_model.dart';
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/screen/home/ctrl_home.dart';
import 'package:socialearn/src/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/widgets/custom_textfiled.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await homeController.signout();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () async {
          // Get.toNamed(Routes.CREATECOMMUNITY);
          await homeController.getAllCommunities();
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          return homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CommunityModel data =
                        homeController.getAllCommunitiesList[index];
                    final currentUserId = prefs.getUser()?.id ?? "";
                    final subscribedCommunities =
                        prefs.getUser()?.subscribedCommunities ?? [];

                    final isSubscribed = subscribedCommunities
                        .map((community) =>
                            community is String ? community : (community.id))
                        .contains(data.id);

                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.name),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  data.bannedUsers
                                          .map((user) => user is String
                                              ? user
                                              : (currentUserId ?? ""))
                                          .contains(currentUserId)
                                      ? Icons.close_outlined
                                      : Icons.check_outlined,
                                  color: data.bannedUsers
                                          .map((user) => user is String
                                              ? user
                                              : (currentUserId ?? ""))
                                          .contains(currentUserId)
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  isSubscribed
                                      ? await homeController
                                          .unsubscribeCommunity(
                                              communityId: data.id)
                                      : await homeController.subscribeCommunity(
                                          communityId: data.id);
                                },
                                icon: Icon(
                                  isSubscribed
                                      ? Icons.check_circle
                                      : Icons.circle,
                                  color:
                                      isSubscribed ? Colors.green : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemCount: homeController.getAllCommunitiesList.length);
        },
      ).paddingSymmetric(horizontal: 20, vertical: 20),
    );
  }
}
