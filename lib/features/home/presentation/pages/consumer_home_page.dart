import 'package:flutter/material.dart';
import 'package:travel_app/app/app_scaffold_page.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/features/search/presentation/pages/flight_search_page.dart';
import 'package:travel_app/features/search/presentation/pages/hotel_search_page.dart';

class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<ConsumerHomePage> createState() => _ConsumerHomePageState();
}

List<Widget> widgets = [FlightSearchPage(), HotelSearchPage()];

class _ConsumerHomePageState extends State<ConsumerHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() => _tabIndex = tabController.index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: Column(
        children: [
          Container(
            height: 48,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(width: 2),
            ),
            child: TabBar(
              indicatorWeight: 0,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              dividerHeight: 0,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: context.appColors.primaryColor,
              ),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: Colors.grey,
              splashBorderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.all(3),
              tabs: const [
                Tab(text: 'Flights'),
                Tab(text: 'Hotels'),
              ],
            ),
          ),
          Expanded(child: widgets[_tabIndex]),
        ],
      ),
    );
  }
}
