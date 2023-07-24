import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  String? username;
   EditProfileScreen({Key? key, this.username}) : super(key: key);
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
   controller.nameController.text = widget.username!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: boldText(text: editProfile, size: 16.0),
          actions: [
          controller.isLoading.value ? const Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(white),
          ),):  TextButton(onPressed: () async{
              controller.isLoading(true);

              ////////////////// if image is not selected/////////////

              if(controller.profileImgPath.value.isNotEmpty){
                await controller.uploadProfileImage();
              }else{
                controller.profileImageLink = controller.snapshotData['imageUrl'];
              }

              //////////// if old password matches database//////////

              if(controller.snapshotData['password']== controller.oldpasswordController.text){
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldpasswordController.text,
                  newPassword: controller.newpasswordController.text,
                );

                await controller.updateProfile(
                  name: controller.nameController.text,
                  password: controller.newpasswordController.text,
                  imgUrl: controller.profileImageLink,
                );
                VxToast.show(context, msg: "Updated");
              }else if(controller.oldpasswordController.text.isEmptyOrNull && controller.newpasswordController.text.isEmptyOrNull){
                await controller.updateProfile(
                  name: controller.nameController.text,
                  password: controller.snapshotData['password'],
                  imgUrl: controller.profileImageLink,
                );
              }else{
                VxToast.show(context, msg: "Some error ocured");
                controller.isLoading(false);
              }
            }, child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(
                  imgProduct,
                  width: 120,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(controller.snapshotData['imageUrl'],width: 100,height: 100,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                    :Image.file(
                  File(controller.profileImgPath.value),
                  width: 100,height: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                // Image.asset(imgProduct, width:150,).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),
                    onPressed: (){
                    controller.changeImage(context);

                    }, child: normalText(text: changeImage, color: fontGrey),
                ),
                10.heightBox,
                const Divider(color: white,),
                CustomTextField(label: name, hint: nameHint, controller: controller.nameController),
                30.heightBox,
                Align(alignment: Alignment.centerLeft, child: boldText(text: "Change your password")),
                10.heightBox,
                CustomTextField(label: password, hint: passwordHint, controller: controller.oldpasswordController),
                15.heightBox,
                CustomTextField(label: confirmPass, hint: passwordHint, controller: controller.newpasswordController),

              ],
            ),
        ),
      ),
    );
  }
}
