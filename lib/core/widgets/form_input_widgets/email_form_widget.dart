import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../../helpers/icon_paths.dart';
import '../../helpers/validators.dart';
import '../common_text_form_field_widget.dart';
import '../image_widgets/common_asset_svg_image_widget.dart';

class EmailFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final String? Function(String?)? emailOnChanged;

  const EmailFormWidget({
    super.key,
    required this.emailController,
    required this.emailOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: emailController,
      hintKey: "Email",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPaths.emailIconSVG,
          fit: BoxFit.contain,
          imageColor: context.textColors.lightGrey,
          height: 16,
          width: 16,
        ),
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          if (!validateEmail(value)) {
            return 'Bad format email!';
          } else {
            return null;
          }
        }
        return null;
      },
      onChanged: emailOnChanged,
    );
  }
}
