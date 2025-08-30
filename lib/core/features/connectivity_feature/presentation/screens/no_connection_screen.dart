import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const CommonAssetSvgImageWidget(
              //   imageString: 'no_internet.svg',
              //   height: 185,
              //   width: 280,
              //   fit: BoxFit.fill,
              // ),
              // getSpaceHeight(16),
              // Center(
              //   child: CommonTitleText(
              //     textKey: SharedText.currentLocale == 'ar'
              //         ? 'لا يوجد أنترنت '
              //         : 'No Internet Connection',
              //     textStyle: context.textTheme.headlineMedium!.copyWith(
              //       color: context.appColors.black1A,
              //     ),
              //     maxLines: 2,
              //     textOverflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // getSpaceHeight(8),
              // CommonTitleText(
              //   textKey: SharedText.currentLocale == 'ar'
              //       ? 'اتاكد من الانترنت او جرب كمان شوية'
              //       : 'Check internet connection or try again later',
              //   textStyle: context.textTheme.headlineMedium!.copyWith(
              //     color: context.textColors.main,
              //   ),
              //   maxLines: 2,
              //   textOverflow: TextOverflow.ellipsis,
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
