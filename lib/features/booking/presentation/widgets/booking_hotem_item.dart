import 'package:flutter/material.dart';
import 'package:travel_app/core/helpers/extensions/context_extensions.dart';
import 'package:travel_app/features/search/domain/entites/hotel_entity.dart';

import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/widgets/common_title_text.dart';
import '../../../../core/widgets/image_widgets/common_cached_image_widget.dart';

class BookingHotelItem extends StatelessWidget {
  const BookingHotelItem({super.key, required this.item});

  final HotelEntity item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.appColors.bgWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonCachedImageWidget(
              imageUrl: item.imageUrl,
              width: SharedText.screenWidth,
              height: 120,
              fit: BoxFit.cover,
              radius: 5,
            ),
            getSpaceHeight(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTitleText(
                  textKey: item.name,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.textColors.ohersBlue,
                  ),
                ),
                CommonTitleText(
                  textKey: '${item.city} • ${item.rating}★',
                  textStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CommonTitleText(
              textKey: 'Price: \$${item.pricePerNight.toStringAsFixed(2)}',
              textStyle: TextStyle(
                fontSize: 16,
                color: context.textColors.main,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
