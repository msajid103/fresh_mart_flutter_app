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

  Future addProduct(
      Map<String, dynamic> userInfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProducts(String catergory) async {
    return await FirebaseFirestore.instance.collection(catergory).snapshots();
  }
}
