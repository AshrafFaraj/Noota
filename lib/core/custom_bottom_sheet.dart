import 'package:flutter/material.dart';
import '/features/auth/views/widgets/custom_text_field.dart';

import '../features/auth/views/widgets/custom_button.dart';
import 'utils/app_color.dart';

void customBottomSheet(
    {required BuildContext context,
    TextEditingController? controller,
    void Function()? onPressed,
    String? hint,
    String? bottonTitel}) {
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
            child: Wrap(
              children: [
                CustomTextField(
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
                      color: AppColor.secondColor,
                      title: bottonTitel ?? 'حسناً'),
                ),
              ],
            ),
          ));
}
