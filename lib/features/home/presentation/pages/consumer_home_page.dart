import 'package:flutter/material.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';
import 'package:travel_app/core/widgets/common_title_text.dart';

import '../../../../core/widgets/common_app_bar_widget.dart';
import '../../../search/presentation/pages/flight_search_page.dart';

class ConsumerHomePage extends StatelessWidget {
  const ConsumerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      appBar: AppBarWithBottomWidget(
        isBackArrow: false,
        actions: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return FlightSearchPage();
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Center(
              child: CommonTitleText(
                textKey: 'Flight Search',
                textStyle: TextStyle(color: context.appColors.primaryColor),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: Column(
          children: [CommonTitleText(textKey: 'Consumer Home Page')],
        ),
      ),
    );
  }
}
