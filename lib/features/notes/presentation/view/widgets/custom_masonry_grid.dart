import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/services/image_picker_services.dart';
import '../../../data/models/note_mode.dart';
import 'note_card.dart';

class CustomMasonryGrid extends StatelessWidget {
  const CustomMasonryGrid({
    super.key,
    required this.notes,
    required this.docId,
    required this.picker,
    required this.controller,
  });

  final List<NoteModel> notes;
  final String docId;
  final ImagePickerService picker;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2, // عدد الأعمدة
      mainAxisSpacing: 8, // المسافة العمودية
      crossAxisSpacing: 8, // المسافة الأفقية
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final item = notes[index];
        return NoteCard(
          key: ValueKey(item.id),
          docId: docId,
          note: item,
          picker: picker,
          controller: controller,
        );
      },
    );
  }
}
