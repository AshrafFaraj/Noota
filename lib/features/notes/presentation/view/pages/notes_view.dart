import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_notes_grid.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/custom_bottom_sheet.dart';
import '/features/notes/presentation/manager/notes_cubit/notes_cubit.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key, required this.name, required this.docId});
  final String name;
  final String docId;

  @override
  State<NotesView> createState() => _HomeViewState();
}

class _HomeViewState extends State<NotesView> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
        ),
      ),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
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
          var cubit = BlocProvider.of<NotesCubit>(context);
          if (state is NotesLoaded) {
            var notes = state.notes;
            return CustomNotesGrid(
              docId: widget.docId,
              notesCubit: cubit,
              notes: notes,
              controller: controller,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clear();
          customBottomSheet(
              context: context,
              bottonTitel: 'اضافة الملاحظة',
              controller: controller,
              onPressed: () {
                context
                    .read<NotesCubit>()
                    .addNote(docId: widget.docId, newNote: controller.text);
                Navigator.pop(context);
              });
        },
        backgroundColor: AppColor.secondColor,
        child: Icon(
          Icons.add,
          color: AppColor.white,
          size: 35,
        ),
      ),
    );
  }
}
