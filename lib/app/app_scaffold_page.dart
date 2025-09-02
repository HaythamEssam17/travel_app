import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';

import '../core/features/connectivity_feature/presentation/logic/connectivity_cubit.dart';
import '../core/features/connectivity_feature/presentation/screens/no_connection_screen.dart';
import '../core/helpers/helper_methods.dart';
import '../core/helpers/shared_texts.dart';

class AppScaffoldPage extends StatefulWidget {
  final Widget body;
  final Widget? appBar;
  final Color? backgroundColor;

  const AppScaffoldPage({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
  });

  @override
  State<AppScaffoldPage> createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends State<AppScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectivityCubit>(
      create: (_) => getIt<ConnectivityCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.backgroundColor ?? context.appColors.bgWhite,
        body: SafeArea(
          // top: false,
          child: Column(
            children: [
              if (widget.appBar != null) ...[
                widget.appBar!,
                getSpaceHeight(16),
              ] else ...[
                // getSpaceHeight(kToolbarHeight),
              ],
              Expanded(
                child: GestureDetector(
                  onTap: () => context.hideKeyboard(),
                  child: BlocConsumer<ConnectivityCubit, ConnectivityStates>(
                    listener: (connectivityCxt, connectivityState) {
                      devLog(
                        'connectivityState: from state $connectivityState',
                      );
                    },
                    builder: (context, connectivityState) {
                      if (connectivityState is ConnectivityDisconnected) {
                        return NoConnectionScreen();
                      }
                      return SizedBox(
                        height: SharedText.screenHeight,
                        width: SharedText.screenWidth,
                        child: widget.body,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
