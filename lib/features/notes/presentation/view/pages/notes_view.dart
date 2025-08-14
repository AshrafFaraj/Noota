import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_note_bottom_sheet.dart';
import '../widgets/custom_notes_grid.dart';
import '../../../../../core/utils/app_color.dart';
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
      body: CustomNotesGrid(controller: controller, docId: widget.docId),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clear();
          customNoteBottomSheet(
              isAddType: true,
              context: context,
              bottonTitel: 'اضافة الملاحظة',
              controller: controller,
              docId: widget.docId,
              notesCubit: context.read<NotesCubit>());
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
