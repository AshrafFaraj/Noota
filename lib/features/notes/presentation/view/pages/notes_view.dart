import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_note_bottom_sheet.dart';
import '../widgets/notes_view_body.dart';
import '../widgets/ui_switcher_button.dart';
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
        centerTitle: true,
        title: Text(
          widget.name,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                bool isGrid = BlocProvider.of<NotesCubit>(context).isGrid;
                return UISwitcherButton(isGrid: isGrid);

                // return ;
              },
            ),
          )
        ],
      ),
      body: NotesViewBody(controller: controller, docId: widget.docId),
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
        child: Icon(
          Icons.add,
          // color: AppColors.white,
          size: 35,
        ),
      ),
    );
  }
}
