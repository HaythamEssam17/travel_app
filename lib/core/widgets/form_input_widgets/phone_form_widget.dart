import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/icon_paths.dart';
import '../common_text_form_field_widget.dart';
import '../image_widgets/common_asset_svg_image_widget.dart';

class PhoneFormWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final String? Function(String?)? phoneOnChanged;
  final String? hintKey;
  final bool? checkCurrentPhone;
  const PhoneFormWidget({
    super.key,
    required this.phoneController,
    required this.phoneOnChanged,
    this.hintKey,
    this.checkCurrentPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: phoneController,
      hintKey: hintKey ?? 'Phone Number',
      keyboardType: TextInputType.phone,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPaths.phoneIconSVG,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Empty field';
        } else if (value.length != 11) {
          return 'Phone number length error';
        }
        return null;
      },
      onChanged: phoneOnChanged,
    );
  }
}
