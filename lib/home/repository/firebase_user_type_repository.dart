import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/home/repository/user_type_repository.dart';

class FirebaseUserTypeRepository extends UserTypeRepository {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<void> changeUserType(String uid, String type) async {
    await firebaseFirestore.collection('users').doc(uid).update({'type': type});
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserType(String uid) {
    return firebaseFirestore.collection('users').doc(uid).snapshots();
  }

  @override
  Query<Map<String, dynamic>> getUserList() {
    return firebaseFirestore.collection('users').orderBy(FieldPath.documentId);
  }

  @override
  Query<Map<String, dynamic>> getUserListByType(String type) {
    return firebaseFirestore
        .collection('users')
        .where('type', isEqualTo: type)
        .orderBy(FieldPath.documentId);
  }

  @override
  Future<void> addVendor(String uid, String vendorEmail) async {
    await firebaseFirestore.collection('users').doc(uid).update(
      {
        'vendorEmail': vendorEmail,
      },
    );
  }
}

final firebaseUserTypeProvider = Provider<UserTypeRepository>((ref) {
  return FirebaseUserTypeRepository();
});

final getUserTypeProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>, String>(
        (ref, uid) {
  return ref.watch(firebaseUserTypeProvider).getUserType(uid);
});
