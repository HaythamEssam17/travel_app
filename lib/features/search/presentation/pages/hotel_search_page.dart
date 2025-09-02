import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/di/injection.dart';
import 'package:travel_app/core/helpers/helper_methods.dart';
import 'package:travel_app/features/search/presentation/widgets/hotel_item_widget.dart';

import '../bloc/hotel_search/hotel_search_cubit.dart';
import '../bloc/hotel_search/hotel_search_states.dart';

class HotelSearchPage extends StatelessWidget {
  const HotelSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HotelSearchCubit>(
      create: (_) => getIt<HotelSearchCubit>()..getHotels(),
      child: BlocConsumer<HotelSearchCubit, HotelSearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.items.isEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.items.isEmpty) {
            return const Center(child: Text('No hotels'));
          }

          final cubit = context.read<HotelSearchCubit>();

          return RefreshIndicator(
            onRefresh: () async => cubit.refreshHotels(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!state.loading &&
                    state.hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  cubit.getHotels();
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
                    final hotel = state.items[index];
                    return HotelItem(hotel: hotel);

                    // return ListTile(
                    //   leading: Image.network(
                    //     hotel.imageUrl,
                    //     width: 80,
                    //     fit: BoxFit.cover,
                    //   ),
                    //   title: CommonTitleText(textKey: "Item ${hotel.name}"),
                    //   subtitle: Text('${hotel.city} • ${hotel.rating}★'),
                    // );
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
