import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';

import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controler = Get.find<ProfileController>();
    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: boldText(text: shopSetting, size: 16.0),
          actions: [
            controler.isLoading.value ? const Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(white),
            ),): TextButton(onPressed: () async{
              controler.isLoading(true);
             await controler.updateShopSetting(
               shopname: controler.shopNameController.text,
               shopaddress: controler.shopAddressController.text,
               shopmobile: controler.shopMobileController.text,
               shopwebsite: controler.shopDescController.text,
               shopdesc: controler.shopDescController.text,
              );
             VxToast.show(context, msg: "Shop Updated");
            }, child: normalText(text: save)),
          ],
        ),
        body: Column(
          children: [
            CustomTextField(
              label: shopName,
              hint: nameHint,
              controller: controler.shopNameController,
            ),
            10.heightBox,
            CustomTextField(
              label: address,
              hint: shopAddressHint,
              controller: controler.shopAddressController,
            ),
            10.heightBox,
            CustomTextField(
              label: mobile,
              hint: shopMobileHint,
              controller: controler.shopMobileController,
            ),
            10.heightBox,
            CustomTextField(
              label: website,
              hint: shopWebsiteHint,
              controller: controler.shopWebsiteController,
            ),
            10.heightBox,
            CustomTextField(
              isDesc: true,
              label: description,
              hint: shopDescHint,
              controller: controler.shopDescController,
            ),
          ],
        ),
      ),
    );
  }
}
