import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/di/injection.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../bloc/flight_search/flight_search_cubit.dart';
import '../bloc/flight_search/flight_search_states.dart';
import '../widgets/flight_card_widget.dart';

class FlightSearchPage extends StatelessWidget {
  const FlightSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlightSearchCubit>(
      create: (_) => getIt<FlightSearchCubit>()..getFlights(),
      child: BlocConsumer<FlightSearchCubit, FlightSearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.items.isEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.items.isEmpty) {
            return const Center(child: Text('No flights'));
          }

          final cubit = context.read<FlightSearchCubit>();

          return RefreshIndicator(
            onRefresh: () async => cubit.refreshHotels(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!state.loading &&
                    state.hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  cubit.getFlights();
                }
                return false;
              },
              child: ListView.separated(
                controller: cubit.scrollController,
                itemCount: state.items.length + (state.loading ? 1 : 0),
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, __) => getSpaceHeight(8),
                itemBuilder: (context, index) {
                  if (index < state.items.length) {
                    return RepaintBoundary(
                      child: FlightCardWidget(
                        flightEntity: state.items[index],
                        onTap: () {
                          router.pushNamed(
                            RouteNames.bookingDetailsPage,
                            extra: {
                              'itemId': state.items[index].id,
                              'itemType': 'flight',
                              'item': state.items[index],
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
