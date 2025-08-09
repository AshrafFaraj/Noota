import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final Map<String, dynamic> data; // أو خصائص محددة مثل final String name;

  CategoryModel({required this.id, required this.data});

  String get name => data['name'] as String? ?? '';
  set setName(String newName) => data['name'] = newName;

  factory CategoryModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    return CategoryModel(id: snap.id, data: snap.data() ?? {});
  }

  factory CategoryModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    return CategoryModel(id: snap.id, data: snap.data());
  }
}
