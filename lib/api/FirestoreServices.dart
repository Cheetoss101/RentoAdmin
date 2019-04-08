import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services.dart';

class FirestoreServices {
  //SEARCH QUERY
  static Future<QuerySnapshot> searchItem(String searchTerm) {
    return Firestore.instance
        .collection("Item")
        .where("name", isGreaterThanOrEqualTo: searchTerm ).getDocuments();
  }

  //GET USER'S ITEM LIST
  static Stream<QuerySnapshot> getItemList(){
    return Firestore.instance.collection('Item').where("sellerID", isEqualTo: UserAuth.getEmail()).snapshots();
  }

  //GET REQUESTS OF A USER
  static Stream<QuerySnapshot> getRequests(){
    return Firestore.instance.collection('Requests').where('SellerID', isEqualTo:UserAuth.getEmail()).snapshots();
  }
  static Stream<QuerySnapshot> getRequestsB(){
    return Firestore.instance.collection('Requests').where('BuyerID', isEqualTo:UserAuth.getEmail()).snapshots();
  }
  static Stream<QuerySnapshot> getUserRates(String userID){
    return Firestore.instance.collection('UserRates').where('UserID', isEqualTo:userID).snapshots();
  }
  static Stream<DocumentSnapshot> getUserRate(String userID){
    return Firestore.instance.collection('Users').document(userID).snapshots();
  }

  //AFTER SEARCH GET ITEM DETAILS
  static Future<DocumentSnapshot> getItemDetails(String itemID) {
   return Firestore.instance
        .collection("Item").document(itemID).get();
       
  }
  static Future <DocumentSnapshot> getRequestDetails(String RequestID){
    print(" the request id is $RequestID");
    return Firestore.instance
    .collection("Requests").document(RequestID).get();
    
  }

  //
  static Future<QuerySnapshot> getItemPhotos(String itemID) {
   return Firestore.instance
        .collection("Item").document(itemID).collection("photos").getDocuments();
        
        //.then((val){print("IMAGES RETURN BRRRRRRRRRRRRRR${val.documents.length}");}); 
  }

  //ITEM RATE OF
  static void getItemRates(String itemID) {
    Firestore.instance
        .collection("Item/$itemID/Rates")
        .getDocuments()
        .then((QuerySnapshot s) {
      DocumentSnapshot doc = s.documents[0];
      print("itemRate: ${doc.data.keys}");
    });
  }

  //NOT TESTED
  static void getItemRequestedDates(String itemID) {
    Firestore.instance
        .collection("Item/$itemID/Dates")
        .getDocuments()
        .then((QuerySnapshot s) {
      DocumentSnapshot doc = s.documents[0];
      print("itemReservedDates: ${doc.data.keys}");
    });
  }

  //GET CURRENT USER PROFILE
  static Future<DocumentSnapshot> getProfileDetails(String email){
    return Firestore.instance
        .collection("Users")
        .document(email)
        .get();
  }

  //GET WISHLIST
  static Stream <QuerySnapshot> getWishlist(){
    return Firestore.instance
    .collection("Wishlist")
    .where("wisherID", isEqualTo: UserAuth.getEmail())
    .snapshots();
  }

  //GET THE ITEM LAT LNG (LOCATION FOR THE MAP)
  static Future<DocumentSnapshot> getLatLng(String itemID){
    return Firestore.instance
        .collection("Item")
        .document(itemID)
        .get();
  }
 
}