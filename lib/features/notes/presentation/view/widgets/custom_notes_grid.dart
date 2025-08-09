import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '/features/notes/data/models/note_mode.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/custom_bottom_sheet.dart';
import '../../manager/notes_cubit/notes_cubit.dart';
import 'note_card.dart';

class CustomNotesGrid extends StatelessWidget {
  const CustomNotesGrid({
    super.key,
    required this.notes,
    required this.notesCubit,
    required this.controller,
    required this.docId,
  });
  final TextEditingController controller;
  final String docId;
  final NotesCubit notesCubit;
  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: notes.map((item) {
          return GestureDetector(
              onLongPress: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  btnOkText: 'تعديل',
                  btnOkColor: AppColor.primary,
                  btnOkOnPress: () {
                    controller.text = item.note;
                    customBottomSheet(
                        context: context,
                        bottonTitel: 'تعديل الملاحظة',
                        controller: controller,
                        onPressed: () {
                          Navigator.pop(context);
                          notesCubit.editNote(
                              docId: docId,
                              subDocId: item.id,
                              newNote: controller.text);
                        });
                  },
                  btnCancelText: 'حذف',
                  btnCancelOnPress: () {
                    notesCubit.deleteNote(
                      docId: docId,
                      subDocId: item.id,
                    );
                  },
                ).show();
              },
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2 - 12,
                  child: NoteCard(title: item.note)));
        }).toList(),
      ),
    );
  }
}
