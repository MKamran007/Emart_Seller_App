import 'package:emart_seller/const/const.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }
  var navIndex = 0.obs;
  var userName = '';

  getUsername() async{
    var n = await firestore.collection(vendorCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['vendor_name'];
      }
    });
    userName = n;
  }
}