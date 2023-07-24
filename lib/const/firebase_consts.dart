import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const vendorCollection = "vendors";
const productsCollection = "products";
const cartCollection = "cart";
const chatCollection = "chats";
const messageCollection = "message";
const ordersCollection = "orders";