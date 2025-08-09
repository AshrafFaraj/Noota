import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final Map<String, dynamic> data; // أو خصائص محددة مثل final String name;

  NoteModel({required this.id, required this.data});

  String get note => data['desc'] as String? ?? '';
  set setNote(String newNote) => data['desc'] = newNote;

  factory NoteModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    return NoteModel(id: snap.id, data: snap.data() ?? {});
  }

  factory NoteModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    return NoteModel(id: snap.id, data: snap.data());
  }
}
