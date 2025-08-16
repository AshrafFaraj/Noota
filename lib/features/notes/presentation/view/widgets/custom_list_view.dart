import 'package:flutter/material.dart';

import '../../../../../core/services/image_picker_services.dart';
import '../../../data/models/note_mode.dart';
import 'note_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final item = notes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: NoteCard(
            key: ValueKey(item.id),
            docId: docId,
            note: item,
            picker: picker,
            controller: controller,
          ),
        );
      },
    );
  }
}
