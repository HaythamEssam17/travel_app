import 'package:flutter/material.dart';

import '../../helpers/icon_paths.dart';
import '../../helpers/validators.dart';
import '../common_text_form_field_widget.dart';
import '../image_widgets/common_asset_svg_image_widget.dart';

class NameFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final String? Function(String?)? nameOnChanged;

  const NameFormWidget({
    super.key,
    required this.nameController,
    required this.nameOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: nameController,
      hintKey: "Name",
      keyboardType: TextInputType.text,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPaths.personIconSVG,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Empty field';
        } else if (nameValidator(value)) {
          return 'Bad format name!';
        } else {
          return null;
        }
      },
      onChanged: nameOnChanged,
    );
  }
}
