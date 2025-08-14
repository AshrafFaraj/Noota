import 'package:cloud_firestore/cloud_firestore.dart';

// class NoteModel {
//   final String id;
//   final Map<String, dynamic> data; // أو خصائص محددة مثل final String name;

//   NoteModel({required this.id, required this.data});

//   String get note => data['note'] as String? ?? '';
//   set setNote(String newNote) => data['note'] = newNote;

//   String get imageUrl => data['imageUrl'] as String? ?? '';
//   set setImageUrl(String imageUrl) => data['imageUrl'] = imageUrl;

//   factory NoteModel.fromDocumentSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> snap) {
//     return NoteModel(id: snap.id, data: snap.data() ?? {});
//   }

//   factory NoteModel.fromQueryDocumentSnapshot(
//       QueryDocumentSnapshot<Map<String, dynamic>> snap) {
//     return NoteModel(id: snap.id, data: snap.data());
//   }
// }

class NoteModel {
  final String id;
  final String note;
  final String imageUrl;

  const NoteModel({
    required this.id,
    required this.note,
    required this.imageUrl,
  });

  factory NoteModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data() ?? {};
    return NoteModel(
      id: snap.id,
      note: data['note'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  factory NoteModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    return NoteModel(
      id: snap.id,
      note: data['note'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  NoteModel copyWith({
    String? note,
    String? imageUrl,
  }) {
    return NoteModel(
      id: id,
      note: note ?? this.note,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
