import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserOrderDetail(
      Map<String, dynamic> userOrderMap,
      String id,
      String orderId,
      ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Orders")
        .doc(orderId)
        .set(userOrderMap);
  }

  Future addAdminOrderDetail(
      Map<String, dynamic> userOrderMap,
      String orderId,
      ) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId)
        .set(userOrderMap);
  }
  Future<Stream<QuerySnapshot>> getUserOrders(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Orders")
        .snapshots();
  }
  Future<QuerySnapshot> getUserWalletByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users").where("email", isEqualTo: email).get();
  }
  Future updateUserWallet(String amount, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"wallet": amount});
  }
  Future<Stream<QuerySnapshot>> getAdminOrders() async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .snapshots();
  }
  Future updateAdminOrders(String id) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .doc(id)
        .update({"Status" : "Delivered"});
  }
  Future updateUserOrders(String userId,String docId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(docId)
        .update({"Status" : "Delivered"});
  }
}
