import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_color.dart';
import 'package:note_app/features/notes/widgets/note_card.dart';

import '../auth/views/widgets/custom_button.dart';
import '../auth/views/widgets/custom_text_field.dart';

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
  void initState() {
    super.initState();
    getDate(docId: widget.docId);
  }

  List<QueryDocumentSnapshot> data = [];
  Future<void> getDate({required String docId}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(docId)
        .collection('notes')
        .get();
    data.clear();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  Future<void> addNote({required docId}) async {
    CollectionReference notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(docId)
        .collection('notes');
    isLoading = true;
    setState(() {});
    if (controller.text.isNotEmpty) {
      Navigator.pop(context);
      await notes.add({
        'desc': controller.text,
      }).then((val) {
        print('================ Note added successfully');
        isLoading = false;
        controller.clear();
      }).catchError((e) {
        isLoading = false;
        setState(() {});
        print('======================= failed to add ${e.toString()}');
        AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                title: 'Error',
                dialogType: DialogType.error)
            .show();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('الرجاء كتابة ملاحظتك')));
    }
  }

  Future<void> editNote({required docId, required String noteId}) async {
    CollectionReference notes = FirebaseFirestore.instance
        .collection('categories')
        .doc(docId)
        .collection('notes');
    isLoading = true;
    setState(() {});
    if (controller.text.isNotEmpty) {
      await notes.doc(noteId).update({
        'desc': controller.text,
      }).then((val) {
        print('================ Note edited successfully');
        isLoading = false;
        controller.clear();
        Navigator.pop(context);
      }).catchError((e) {
        isLoading = false;
        setState(() {});
        print('======================= failed to edit ${e.toString()}');
        AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                title: 'Error',
                dialogType: DialogType.error)
            .show();
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('الرجاء كتابة ملاحظتك')));
    }
  }

  void _addNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 30, right: 16.0, left: 16),
              child: Column(
                children: [
                  CustomTextField(
                      controller: controller,
                      label: 'add',
                      hint: 'add new note'),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onPressed: () {
                        addNote(docId: widget.docId);
                      },
                      color: AppColor.secondColor,
                      title: 'Add'),
                ],
              ),
            ));
  }

  void _editNoteBottomSheet(
      BuildContext context, String noteId, String oldNote) {
    controller.text = oldNote;
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 60, right: 16.0, left: 16),
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    label: 'edit',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onPressed: () {
                        editNote(docId: widget.docId, noteId: noteId);
                      },
                      color: AppColor.secondColor,
                      title: 'حفظ'),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    getDate(docId: widget.docId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: data.map((item) {
                  return GestureDetector(
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          btnOkText: 'تعديل',
                          btnOkColor: AppColor.primary,
                          btnOkOnPress: () {
                            _editNoteBottomSheet(
                                context, item.id, item['desc']);
                          },
                          btnCancelText: 'حذف',
                          btnCancelOnPress: () {
                            FirebaseFirestore.instance
                                .collection('categories')
                                .doc(widget.docId)
                                .collection('notes')
                                .doc(item.id)
                                .delete();
                            setState(() {});
                          },
                        ).show();
                      },
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2 - 12,
                          child: NoteCard(title: item['desc'])));
                }).toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNoteBottomSheet(context);
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
