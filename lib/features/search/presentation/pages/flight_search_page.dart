import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/di/injection.dart';

import '../bloc/flight_search/flight_search_cubit.dart';
import '../bloc/flight_search/flight_search_states.dart';

class FlightSearchPage extends StatefulWidget {
  const FlightSearchPage({super.key});

  @override
  State<FlightSearchPage> createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  final ScrollController _scrollCtl = ScrollController();

  @override
  void initState() {
    super.initState();
    // context.read<FlightSearchCubit>().search();
    // _scrollCtl.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollCtl.position.pixels >=
        _scrollCtl.position.maxScrollExtent - 200) {
      // context.read<FlightSearchCubit>().loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollCtl.removeListener(_onScroll);
    _scrollCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlightSearchCubit>(
      create: (_) => getIt<FlightSearchCubit>()..search(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flights'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (_) => const FlightFilterSheet(),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<FlightSearchCubit, FlightSearchState>(
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
              onRefresh: () async => cubit.search(),
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
                  final f = state.items[index];
                  return ListTile(
                    title: Text(
                      '${f.airline} • \$${f.price.toStringAsFixed(2)}',
                    ),
                    subtitle: Text(
                      '${f.departAt} → ${f.arriveAt} • ${f.stops} stops',
                    ),
                    onTap: () {},
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlightFilterSheet extends StatefulWidget {
  const FlightFilterSheet({super.key});

  @override
  State<FlightFilterSheet> createState() => _FlightFilterSheetState();
}

class _FlightFilterSheetState extends State<FlightFilterSheet> {
  double? _minPrice;
  double? _maxPrice;
  final TextEditingController _airlinesCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _airlinesCtl,
            decoration: const InputDecoration(
              labelText: 'Airlines (comma separated)',
            ),
          ),
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
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final airlines = _airlinesCtl.text.trim().isEmpty
                  ? null
                  : _airlinesCtl.text.split(',').map((s) => s.trim()).toList();
              getIt<FlightSearchCubit>().applyFilters(
                minPrice: _minPrice,
                maxPrice: _maxPrice,
                airlines: airlines,
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
