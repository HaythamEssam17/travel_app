import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/app/router/app_router.dart';
import 'package:travel_app/app/router/route_names.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/shared_texts.dart';
import 'package:travel_app/features/booking/presentation/widgets/booking_hotem_item.dart';
import 'package:travel_app/features/search/presentation/widgets/flight_card_widget.dart';

import '../blocs/booking_cubit.dart';
import '../blocs/booking_states.dart';

class BookingDetailsPage extends StatefulWidget {
  final String itemId;
  final String itemType;
  final dynamic item;

  const BookingDetailsPage({
    super.key,
    required this.itemId,
    required this.itemType,
    required this.item,
  });

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  final nameCtl = TextEditingController();
  final emailCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingCubit>(
      create: (_) => getIt<BookingCubit>()
        ..selectItem(
          itemId: widget.itemId,
          itemType: widget.itemType,
          userId: SharedText.user!.id!,
        ),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (ctx, state) {
          if (state.booking != null) {
            router.pushNamed(RouteNames.bookingStatusPage);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (ctx, state) {
          final cubit = ctx.read<BookingCubit>();

          return AppScaffoldPage(
            appBar: AppBar(
              backgroundColor: context.appColors.bgWhite,
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () => router.pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),

            body: SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (widget.itemType == 'flight') ...[
                        FlightCardWidget(
                          flightEntity: widget.item,
                          onTap: () {},
                        ),
                      ] else ...[
                        BookingHotelItem(item: widget.item),
                      ],
                      TextField(
                        controller: nameCtl,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: emailCtl,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (widget.itemType == 'flight') {
                                cubit.addPassenger({
                                  'name': nameCtl.text,
                                  'email': emailCtl.text,
                                });
                              } else {
                                cubit.addGuest({
                                  'name': nameCtl.text,
                                  'email': emailCtl.text,
                                });
                              }
                            },
                            child: const Text('Add'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: state.loading
                                ? null
                                : () => cubit.confirm(),
                            child: state.loading
                                ? const CircularProgressIndicator()
                                : const Text('Confirm Booking'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
