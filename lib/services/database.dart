import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserDetailsByEmail(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();
    return querySnapshot.docs.first;
  }

  Future updateUserProfile(
      String email, Map<String, dynamic> updatedInfo) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update(updatedInfo);
    }
  }

  Future addProduct(
      Map<String, dynamic> userInfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProducts(String catergory) async {
    return await FirebaseFirestore.instance.collection(catergory).snapshots();
  }

  Future<void> placeOrder(String userId, String productId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .add({
      'productId': productId,
      'orderDate': DateTime.now(),
      'status': 'Pending', // Initial status
    });
  }

  Future<DocumentSnapshot> getProductDetails(
      String categoryId, String productId) async {
    return await FirebaseFirestore.instance
        .collection(categoryId)
        .doc(productId)
        .get();
  }
}
