import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/hotel_search/hotel_search_cubit.dart';
import '../bloc/hotel_search/hotel_search_states.dart';

class HotelSearchPage extends StatefulWidget {
  const HotelSearchPage({super.key});

  @override
  State<HotelSearchPage> createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {
  final ScrollController _scrollCtl = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HotelSearchCubit>().search();
    _scrollCtl.addListener(() {
      if (_scrollCtl.position.pixels >=
          _scrollCtl.position.maxScrollExtent - 200) {
        context.read<HotelSearchCubit>().loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async => await showModalBottomSheet(
              context: context,
              builder: (_) => const HotelFilterSheet(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HotelSearchCubit, HotelSearchState>(
        builder: (context, state) {
          if (state.loading && state.items.isEmpty)
            return const Center(child: CircularProgressIndicator());
          if (state.error != null && state.items.isEmpty)
            return Center(child: Text('Error: ${state.error}'));
          if (state.items.isEmpty)
            return const Center(child: Text('No hotels'));

          return RefreshIndicator(
            onRefresh: () async => context.read<HotelSearchCubit>().search(),
            child: ListView.separated(
              controller: _scrollCtl,
              itemCount: state.items.length + (state.hasMore ? 1 : 0),
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final h = state.items[index];
                return ListTile(
                  leading: Image.network(
                    h.imageUrl,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    '${h.name} • \$${h.pricePerNight.toStringAsFixed(0)}',
                  ),
                  subtitle: Text('${h.city} • ${h.rating}★'),
                  onTap: () {},
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HotelFilterSheet extends StatefulWidget {
  const HotelFilterSheet({Key? key}) : super(key: key);

  @override
  State<HotelFilterSheet> createState() => _HotelFilterSheetState();
}

class _HotelFilterSheetState extends State<HotelFilterSheet> {
  double? _minPrice;
  double? _maxPrice;
  double? _minRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Min price'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _minPrice = double.tryParse(v),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Max price'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _maxPrice = double.tryParse(v),
                ),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Min rating (e.g. 4)'),
            keyboardType: TextInputType.number,
            onChanged: (v) => _minRating = double.tryParse(v),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<HotelSearchCubit>().applyFilters(
                minPrice: _minPrice,
                maxPrice: _maxPrice,
                minRating: _minRating,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
