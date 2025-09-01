import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';
import 'package:travel_app/core/widgets/common_app_bar_widget.dart';
import 'package:travel_app/core/widgets/common_title_text.dart';
import 'package:travel_app/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class AgentHomePage extends StatelessWidget {
  const AgentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return AppScaffoldPage(
            appBar: AppBarWithBottomWidget(
              isBackArrow: false,
              actions: InkWell(
                onTap: () {
                  cubit.logout();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Center(
                    child: CommonTitleText(
                      textKey: 'Logout',
                      textStyle: TextStyle(
                        color: context.appColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: Column(
                children: [CommonTitleText(textKey: 'Agent Home Page')],
              ),
            ),
          );
        },
      ),
    );
  }
}
