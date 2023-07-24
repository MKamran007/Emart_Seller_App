import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../models/category_model.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController extends GetxController{
  var isLoader = false.obs;
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquentityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImageList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async{
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoriesList(){
    categoryList.clear();
    for(var item in category){
      categoryList.add(item.name);
    }
  }

  populateSubCategories(cat){
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for(var i = 0; i< data.first.subcategory.length; i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if(img == null){
        return;
    }else{
        pImageList[index] = File(img.path);
    }
    }catch (e){
    VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async{
    pImagesLinks.clear();
    for(var item in pImageList){
    if(item != null){
      var filename = basename(item.path);
      var destination = 'images/vendors/${currentUser!.uid}/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(item);
      var n = await ref.getDownloadURL();
      pImagesLinks.add(n);
    }
    }
  }

  uploadProduct(context) async{
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured' : false,
      'p_category' : categoryvalue.value,
      'p_subcategory' : subcategoryvalue.value,
      'p_colors' : FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_image' : FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist' : FieldValue.arrayUnion([]),
      'p_desc' : pdescController.text,
      'p_name' : pnameController.text,
      'p_price' : ppriceController.text,
      'p_quentity' : pquentityController.text,
      'p_seller' : Get.find<HomeController>().userName,
      'p_rating' : "5.0",
      'vendor_id' : currentUser!.uid,
      'featured_id' : '',
    });
    isLoader(false);
    VxToast.show(context, msg: "Product upload");
  }
  
  addFeatured(docID) async{
   await firestore.collection(productsCollection).doc(docID).set({
      'featured_id' : currentUser!.uid,
      'is_featured' : true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docID) async{
    await firestore.collection(productsCollection).doc(docID).set({
      'featured_id' : '',
      'is_featured' : false,
    }, SetOptions(merge: true));
  }

  deleteProduct(docID) async {
    await firestore.collection(productsCollection).doc(docID).delete();
  }
}