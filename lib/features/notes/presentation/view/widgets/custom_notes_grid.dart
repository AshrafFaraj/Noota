import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/core/services/image_picker_services.dart';
import '../../manager/notes_cubit/notes_cubit.dart';
import 'note_card.dart';

class CustomNotesGrid extends StatelessWidget {
  CustomNotesGrid({
    super.key,
    required this.controller,
    required this.docId,
  });
  final TextEditingController controller;
  final String docId;
  final picker = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        print('++++++++++++++++++++++++++++++$state');
        if (state is NotesAddSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم اضافة الملاحظة بنجاح')
              .show();
        } else if (state is NotesDeleteSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم الحذف بنجاح')
              .show();
        } else if (state is NotesEditSuccess) {
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم التعديل بنجاح')
              .show();
        }
      },
      builder: (context, state) {
        if (state is NotesLoaded) {
          var notes = state.notes;
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
        } else if (state is NotesFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
