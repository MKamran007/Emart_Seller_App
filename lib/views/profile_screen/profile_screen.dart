import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/auth_countroller.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/shop_settings/shop_settings.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import '../messages_screen/messages_screen.dart';
import 'edit_profilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
       title: boldText(text: setting, size: 16.0),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> EditProfileScreen(
              username: controller.snapshotData['vendor_name'],
            ));
          }, icon: const Icon(Icons.edit)),
          TextButton(onPressed: () async{
            Get.find<AuthController>().signoutMethod(context);
            Get.offAll(()=>const LoginScreen());
          }, child: normalText(text: logout)),
        ],
      ),
    body: FutureBuilder(
      future: StoreServices.getProfile(currentUser!.uid),
        builder:(context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(white),
              ),
            );
          }else{
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''?
              Image
                .asset(
            imgProduct, width: 90, fit: BoxFit.cover,)
                .box
                .roundedFull
                .clip(Clip.antiAlias)
                .make():Image
              .network(
                    controller.snapshotData['imageUrl'], width: 80, height: 80, fit: BoxFit.cover,)
              .box
              .roundedFull
              .clip(Clip.antiAlias)
              .make(),
                  // leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                  subtitle: normalText(text: "${controller.snapshotData['email']}"),
                ),
                10.heightBox,
                const Divider(color: white,),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(profileButtonTitles.length, (index) => ListTile(
                      onTap: (){
                        switch (index) {
                          case 0:
                            Get.to(()=> ShopSettings());
                            break;
                          case 1:
                            Get.to(()=> MessagesScreen());
                            break;
                        }
                      },
                      leading: Icon(profileButtonIcons[index], color: white,),
                      title: normalText(text: profileButtonTitles[index]),
                    )),
                  ),
                )
              ],
            );
          }
        }
    ),
    );
  }
}
