import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  FirestoreService();

  Future<QuerySnapshot<Map<String, dynamic>>> getDocuments({
    required String collectionPath,
  }) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(collectionPath)
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    return snapshot;
  }

  Future<DocumentReference<Map<String, dynamic>>> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    DocumentReference<Map<String, dynamic>> response =
        await _firestore.collection(collectionPath).add(data);
    return response;
  }

  Future<void> editDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSubDocuments({
    required String collectionPath,
    required String docId,
    required String subCollectionPath,
  }) async {
    final snapshot = await _firestore
        .collection(collectionPath)
        .doc(docId)
        .collection(subCollectionPath)
        .get();

    return snapshot;
  }

  Future<DocumentReference<Map<String, dynamic>>> addSubDocument({
    required String collectionPath,
    required String docId,
    required String subCollectionPath,
    required Map<String, dynamic> data,
  }) async {
    final response = await _firestore
        .collection(collectionPath)
        .doc(docId)
        .collection(subCollectionPath)
        .add(data);

    return response;
  }

  Future<dynamic> editSubDocument({
    required String collectionPath,
    required String docId,
    required String subCollectionPath,
    required String subDocId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(collectionPath)
        .doc(docId)
        .collection(subCollectionPath)
        .doc(subDocId)
        .update(data);
  }

  Future<void> deleteSubDocument({
    required String collectionPath,
    required String docId,
    required String subCollectionPath,
    required String subDocId,
  }) async {
    await _firestore
        .collection(collectionPath)
        .doc(docId)
        .collection(subCollectionPath)
        .doc(subDocId)
        .delete();
  }
}
