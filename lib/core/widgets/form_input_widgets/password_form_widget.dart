import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/icon_paths.dart';

import '../../helpers/helper_methods.dart';
import '../common_text_form_field_widget.dart';
import '../image_widgets/common_asset_svg_image_widget.dart';

class PasswordFormWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final String? Function(String?)? passwordOnChanged;
  final String? Function(String?)? passwordValidator;
  final Function()? onSuffixTap;
  final bool? showPasswordText;
  final String? hintText;
  final Color? borderColor;
  final Color? showPasswordColor;

  const PasswordFormWidget({
    super.key,
    required this.passwordController,
    required this.passwordOnChanged,
    this.passwordValidator,
    this.onSuffixTap,
    this.hintText,
    this.showPasswordText = true,
    this.borderColor,
    this.showPasswordColor,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = this.borderColor ?? context.appColors.surfacesGray;

    return CommonTextFormField(
      controller: passwordController,
      suffixIcon: onSuffixTap == null
          ? null
          : GestureDetector(
              onTap: onSuffixTap,
              child: SizedBox(
                width: getWidgetWidth(30),
                height: getWidgetHeight(30),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: CommonAssetSvgImageWidget(
                      imageString: showPasswordText!
                          ? IconPaths.eyeCloseIconSVG
                          : IconPaths.eyeOpenIconSVG,
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
      keyboardType: TextInputType.text,
      minLines: 1,
      maxLines: 1,
      isObscureText: showPasswordText!,
      radius: 12,
      labelHintStyle: context.textColors.lightGrey,
      hintFontSize: 14,
      hintKey: hintText ?? 'Password',
      borderColor: borderColor,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPaths.lockIconIconSVG,
          imageColor: context.textColors.lightGrey,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator:
          passwordValidator ??
          (value) {
            if (value!.isEmpty) {
              return 'Empty field';
            } else if (value.length < 6) {
              return 'Password must be at least 6 chars';
            }
            return null;
          },
      onChanged: passwordOnChanged,
    );
  }
}
