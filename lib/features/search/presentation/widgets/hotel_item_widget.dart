import 'package:flutter/material.dart';
import 'package:travel_app/app/router/app_router.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/core/helpers/helper_methods.dart';
import 'package:travel_app/core/widgets/common_title_text.dart';
import 'package:travel_app/core/widgets/image_widgets/common_cached_image_widget.dart';

import '../../../../app/router/route_names.dart';
import '../../domain/entites/hotel_entity.dart';

class HotelItem extends StatefulWidget {
  final HotelEntity hotel;

  const HotelItem({super.key, required this.hotel});

  @override
  State<HotelItem> createState() => _HotelItemState();
}

class _HotelItemState extends State<HotelItem> with TickerProviderStateMixin {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: CommonCachedImageWidget(
              imageUrl: widget.hotel.imageUrl,
              width: 80,
              height: 60,
              fit: BoxFit.cover,
              radius: 5,
            ),
            title: CommonTitleText(textKey: widget.hotel.name),
            subtitle: CommonTitleText(
              textKey: '${widget.hotel.city} • ${widget.hotel.rating}★',
            ),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => expanded = !expanded),
            ),
            onTap: () => setState(() => expanded = !expanded),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: expanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    CommonTitleText(
                      textKey:
                          'Amenities: Free Wi-Fi • Pool • Breakfast included',
                    ),
                    getSpaceHeight(16),
                    CommonTitleText(
                      textKey:
                          'Night: \$${widget.hotel.pricePerNight.toStringAsFixed(2)}',
                      textStyle: TextStyle(
                        color: context.textColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            router.pushNamed(
                              RouteNames.bookingDetailsPage,
                              extra: {
                                'itemId': widget.hotel.id,
                                'itemType': 'hotel',
                                'item': widget.hotel,
                              },
                            );
                          },
                          child: const Text('Book'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
