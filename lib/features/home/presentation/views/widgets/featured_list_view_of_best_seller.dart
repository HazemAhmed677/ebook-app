import 'package:bookly_app/features/home/presentation/views/widgets/best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeaturedListViewOfBestSeller extends StatelessWidget {
  const FeaturedListViewOfBestSeller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 10,
      ),
      sliver: SliverList.builder(
        itemCount: 8,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: GestureDetector(onTap: () {}, child: const BestSellerItem()),
        ),
      ),
    );
  }
}
