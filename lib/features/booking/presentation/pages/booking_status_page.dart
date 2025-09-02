import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_router.dart';
import '../../../../core/enums/booking_enum.dart';
import '../blocs/booking_cubit.dart';
import '../blocs/booking_states.dart';

class BookingStatusPage extends StatelessWidget {
  const BookingStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>(
      create: (_) => getIt<BookingCubit>(),
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (ctx, state) {
          final cubit = ctx.read<BookingCubit>();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Booking Status'),
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () => router.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cubit.label(), style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 16),
                  if (state.liveStatus == BookingStatus.processing)
                    const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  if (state.liveStatus == BookingStatus.processing ||
                      state.liveStatus == BookingStatus.initiated)
                    ElevatedButton(
                      onPressed: () => context.read<BookingCubit>().cancel(),
                      child: const Text('Cancel'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
