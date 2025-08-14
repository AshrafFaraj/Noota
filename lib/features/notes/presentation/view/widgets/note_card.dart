import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import 'note_image.dart';
import '/core/services/image_picker_services.dart';
import 'custom_note_bottom_sheet.dart';
import '/features/notes/data/models/note_mode.dart';
import '/features/notes/presentation/manager/notes_cubit/notes_cubit.dart';
import 'note_description.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.picker,
    required this.docId,
    required this.controller,
  });
  final NoteModel note;
  final TextEditingController controller;
  final String docId;
  final ImagePickerService picker;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotesCubit, NotesState, NoteModel?>(
      selector: (state) {
        if (state is NotesLoaded) {
          return state.notes.firstWhere((n) => n.id == note.id);
        }
        return null; // في حالة أخرى، مثل اللودينج
      },
      builder: (context, note) {
        if (note == null) return SizedBox.shrink();

        final notesCubit = BlocProvider.of<NotesCubit>(context);

        return GestureDetector(
            onLongPress: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide,
                btnOkText: 'تعديل',
                btnOkColor: AppColor.primary,
                btnOkOnPress: () {
                  controller.text = note.note;
                  customNoteBottomSheet(
                    context: context,
                    bottonTitel: 'تعديل الملاحظة',
                    controller: controller,
                    docId: docId,
                    subDocId: note.id,
                    notesCubit: notesCubit,
                  );
                },
                btnCancelText: 'حذف',
                btnCancelOnPress: () {
                  notesCubit.deleteNote(
                      docId: docId, subDocId: note.id, imageUrl: note.imageUrl);
                },
              ).show();
            },
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (note.imageUrl != 'none')
                    InkWell(
                      child: NoteImage(
                        imageUrl: note.imageUrl,
                      ),
                      onTap: () {
                        AwesomeDialog(
                          customHeader: SizedBox(),
                          context: context,
                          body: NoteImage(imageUrl: note.imageUrl),
                          btnOkColor: AppColor.primary,
                          btnOkText: 'تغيير الصورة',
                          btnCancelText: 'ازالة الصورة',
                          btnOkOnPress: () async {
                            var newFile = await picker.pickImage();
                            notesCubit.editNoteImage(
                              docId: docId,
                              subDocId: note.id,
                              imageUrl: note.imageUrl,
                              newFile: newFile!,
                            );
                          },
                          btnCancelOnPress: () {
                            notesCubit.deletNoteImage(
                                docId: docId,
                                subDocId: note.id,
                                imageUrl: note.imageUrl);
                          },
                        ).show();
                      },
                    ),
                  SizedBox(height: 15),
                  NoteDescreption(
                    desc: note.note,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
