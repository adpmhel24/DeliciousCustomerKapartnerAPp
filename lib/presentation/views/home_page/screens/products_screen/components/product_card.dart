import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../router/router.gr.dart';
import '../../../../../utils/currency_formater.dart';
import '/data/models/models.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          ProductDetailsRoute(
            loadedProduct: product,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (product.imageUrl == null)
                    ? CircleAvatar(
                        radius: 35.r,
                        child: Hero(
                          tag: product.id,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        backgroundColor: const Color(0xFFF7F7F7),
                      )
                    : CircleAvatar(
                        radius: 30.r,
                        child: Hero(
                          tag: product.id,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        backgroundColor: const Color(0xFFF7F7F7),
                      ),
                Text(
                  product.itemName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  "${formatStringToDecimal(
                    '${product.price}',
                    hasCurrency: true,
                  )} / pc",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
