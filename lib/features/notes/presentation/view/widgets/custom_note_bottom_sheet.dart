import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../auth/presentation/view/widgets/custom_button.dart';
import '/core/services/image_picker_services.dart';
import '/features/notes/presentation/manager/notes_cubit/notes_cubit.dart';
import '../../../../auth/presentation/view/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/classes/app_validator.dart';

final _picker = ImagePickerService();
XFile? _xfile;
bool _isImage = false;
void customNoteBottomSheet({
  required BuildContext context,
  required String docId,
  String? subDocId,
  TextEditingController? controller,
  NotesCubit? notesCubit,
  void Function()? onPressed,
  bool isAddType = false,
  String? hint,
  String? bottonTitel,
  bool withImage = false,
}) {
  final formState = GlobalKey<FormState>();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
            padding: EdgeInsets.only(
                top: 30,
                right: 16.0,
                left: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        CustomTextField(
                          validator: AppValidator.requiredField,
                          keyboardType: TextInputType.multiline,
                          hint: hint,
                          controller: controller,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (isAddType)
                          CustomButton(
                              onPressed: () async {
                                _xfile = await _picker.pickImage();
                                if (_xfile != null) _isImage = true;
                              },
                              color: _isImage
                                  ? AppColors.primary
                                  : AppColors.secondary,
                              title: 'add image'),
                        if (_xfile != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.file(File(_xfile!.path)),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: CustomButton(
                              onPressed: () {
                                if (formState.currentState!.validate()) {
                                  isAddType
                                      ? notesCubit!.addNote(
                                          docId: docId,
                                          newNote: controller!.text,
                                          xfile: _xfile)
                                      : notesCubit!.editNote(
                                          docId: docId,
                                          subDocId: subDocId!,
                                          newData: {'note': controller!.text},
                                        );
                                  Navigator.pop(context);
                                }
                              },
                              color: AppColors.secondary,
                              title: bottonTitel ?? 'حسناً'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}
