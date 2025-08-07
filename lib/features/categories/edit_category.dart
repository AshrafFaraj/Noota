import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../app_color.dart';
import '../auth/views/widgets/custom_button.dart';
import '../auth/views/widgets/custom_text_field.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<EditCategory> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> editCategory(String id) async {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    isLoading = true;
    setState(() {});
    await categories.doc(id).update({'name': controller.text}).then((val) {
      print('================ edit successfully');
      Navigator.of(context).pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );
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
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    controller.text = argument['oldName'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        controller: controller,
                        label: 'Edit',
                        hint: 'Edit the category'),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPressed: () {
                          editCategory(argument['id']);
                        },
                        color: AppColor.secondColor,
                        title: 'Edit'),
                  ],
                ),
              ),
      ),
    );
  }
}
