import 'package:emart_seller/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OrdersController extends GetxController{
var orders=[];
var confirmed = false.obs;
var ondelivery = false.obs;
var delivered = false.obs;

 getOrders(data){
   orders.clear();
   for(var item in data['order']){
     if(item['vendor_id'] == currentUser!.uid){
       orders.add(item);
     }
   }
 }

 changeStatus({title, status, docId}) async{
  var store = firestore.collection(ordersCollection).doc(docId);
  await store.set({title: status}, SetOptions(merge: true));
 }
}