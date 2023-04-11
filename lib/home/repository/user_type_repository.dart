import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserTypeRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserType(String uid);
  Future<void> changeUserType(String uid, String type);
  Future<void> addVendor(String uid, String vendorEmail);
  Query<Map<String, dynamic>> getUserList();
  Query<Map<String, dynamic>> getUserListByType(String type);
}
