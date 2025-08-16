import 'package:flutter/material.dart';

import '/core/utils/classes/app_validator.dart';
import '../../../../auth/presentation/view/widgets/custom_text_field.dart';
import '../../../../auth/presentation/view/widgets/custom_button.dart';
import '../../../../../core/utils/app_color.dart';

void customCategoryBottomSheet({
  required BuildContext context,
  TextEditingController? controller,
  void Function()? onPressed,
  String? hint,
  String? bottonTitel,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomButton(
                              onPressed: onPressed,
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
