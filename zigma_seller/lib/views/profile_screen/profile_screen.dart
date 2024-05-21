import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/auth_controller.dart';
import 'package:zigma_seller/controllers/profile_controller.dart';
import 'package:zigma_seller/services/store_services.dart';
import 'package:zigma_seller/views/auth_screen/logIn_screen.dart';
import 'package:zigma_seller/views/messages_screen/messages_screen.dart';
import 'package:zigma_seller/views/profile_screen/edit_profileScreen.dart';
import 'package:zigma_seller/views/shope_screen/shope_settings.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: settings, color: whiteColor, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                      username: controller.snapshotData['vendor_name'],
                    ));
              },
              icon: const Icon(
                Icons.edit,
                color: whiteColor,
              )),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signOutMethod(context);
                Get.offAll(() => const LoginScreen());
                VxToast.show(context, msg: "Logged out");
              },
              child: normalText(text: logout))
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circleColor: whiteColor);
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ""
                        ? Image.asset(
                            imgProduct,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(controller.snapshotData['imageUrl'],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileButtonIcons.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopeSettings());
                                      break;
                                    case 1:
                                      Get.to(() => const MessageScreen());
                                      break;
                                    default:
                                  }
                                },
                                leading: Icon(
                                  profileButtonIcons[index],
                                  color: whiteColor,
                                ),
                                title: normalText(
                                    text: profileButtonTitles[index]),
                              )),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
