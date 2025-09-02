import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/widgets/common_title_text.dart';

import '../../domain/entites/flight_entity.dart';

class FlightCardWidget extends StatelessWidget {
  const FlightCardWidget({
    super.key,
    required this.flightEntity,
    required this.onTap,
  });

  final FlightEntity flightEntity;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'flight-${flightEntity.id}',

        child: Material(
          color: Colors.transparent,
          child: Card(
            color: context.appColors.bgWhite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTitleText(
                        textKey: flightEntity.airline,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.textColors.ohersBlue,
                        ),
                      ),
                      CommonTitleText(
                        textKey: 'Stops: ${flightEntity.stops.toString()}',
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CommonTitleText(
                    textKey:
                        'Price: \$${flightEntity.price.toStringAsFixed(2)}',
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: context.textColors.main,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonTitleText(
                    textKey: 'Departure: ${flightEntity.departAt}',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonTitleText(
                    textKey: 'Arrival: ${flightEntity.arriveAt}',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
