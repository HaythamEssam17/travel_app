import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_app/features/search/presentation/bloc/hotel_search/hotel_search_cubit.dart';
import 'package:travel_app/features/search/presentation/bloc/hotel_search/hotel_search_states.dart';
import 'package:travel_app/features/search/presentation/pages/hotel_search_page.dart';

class _MockCubit extends Mock implements HotelSearchCubit {}

void main() {
  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    final cubit = _MockCubit();
    when(() => cubit.state).thenReturn(
      HotelSearchState(loading: true, items: [], page: 1, hasMore: true),
    );
    whenListen(cubit, Stream.fromIterable([cubit.state]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HotelSearchCubit>.value(
          value: cubit,
          child: const HotelSearchPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
