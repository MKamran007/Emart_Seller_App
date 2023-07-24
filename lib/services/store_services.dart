import 'package:emart_seller/const/const.dart';

class StoreServices{
  static getProfile(uid){
    return firestore.collection(vendorCollection).where('id', isEqualTo: uid).get();
  }
  
 static getMessages(uid){
    return firestore.collection(chatCollection).where('toId', isEqualTo: uid).snapshots();
  }
  //  get the Chat message
  static getChatMessages(docId){
    return firestore.collection(chatCollection).doc(docId).collection(messageCollection).orderBy('created_on', descending: false).snapshots();
  }

  static getOrders(uid){
    return firestore.collection(ordersCollection).where('vendors', arrayContains: uid).snapshots();
  }

  static getProduct(uid){
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
  }
}