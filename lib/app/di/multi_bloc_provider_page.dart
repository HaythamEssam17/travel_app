import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/features/connectivity_feature/presentation/logic/connectivity_cubit.dart';
import 'injection.dart';

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({super.key, required this.body});

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(
          lazy: false,
          create: (_) => getIt<ConnectivityCubit>(),
        ),
      ],
      child: widget.body,
    );
  }
}
