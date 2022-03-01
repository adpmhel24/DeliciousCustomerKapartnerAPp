import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/data/models/models.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../../global_bloc/blocs.dart';
import '../../../../../utils/currency_formater.dart';
import '../../../../../widget/constant.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.loadedProduct})
      : super(key: key);
  final ProductModel loadedProduct;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _quantityController = TextEditingController();
  double totalAmount = 0;

  @override
  void initState() {
    _quantityController.text = '1';
    totalAmount = widget.loadedProduct.price ?? 0 * 1;
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
            ),
            backgroundColor: const Color(0xFFECECEC),
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.loadedProduct.id,
                child: (widget.loadedProduct.imageUrl == null)
                    ? Image.asset(
                        "assets/images/placeholder.png",
                        fit: BoxFit.fitHeight,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.loadedProduct.imageUrl!,
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
          ),
          SliverPadding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 20.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 50),
                  Text(
                    widget.loadedProduct.itemName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price: ${formatStringToDecimal(
                          '${widget.loadedProduct.price}',
                          hasCurrency: true,
                        )}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Flexible(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                int quantity =
                                    int.tryParse(_quantityController.text) ?? 0;
                                if (quantity > 0) {
                                  quantity -= 1;
                                  setState(() {
                                    _quantityController.value =
                                        TextEditingValue(
                                      text: quantity.toString(),
                                      selection: TextSelection.collapsed(
                                          offset: quantity.toString().length),
                                    );

                                    totalAmount = quantity *
                                        (widget.loadedProduct.price ?? 0);
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              width: 100.w,
                              child: CustomTextField(
                                controller: _quantityController,
                                labelText: "",
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  int quantity = int.tryParse(value) ?? 0;
                                  setState(() {
                                    totalAmount = quantity *
                                        (widget.loadedProduct.price ?? 0);
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                int quantity =
                                    int.tryParse(_quantityController.text) ?? 0;
                                quantity += 1;
                                setState(() {
                                  _quantityController.value = TextEditingValue(
                                    text: quantity.toString(),
                                    selection: TextSelection.collapsed(
                                        offset: quantity.toString().length),
                                  );

                                  totalAmount = quantity *
                                      (widget.loadedProduct.price ?? 0);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Total: ${formatStringToDecimal(
                      '$totalAmount',
                      hasCurrency: true,
                    )}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.only(
            left: 10.h,
            right: 10.h,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ElevatedButton(
          onPressed: (totalAmount <= 0)
              ? null
              : () {
                  CustomDialog.warning(
                    context,
                    message: "Are you sure you want to proceed?",
                    onNegativeClick: () {
                      Navigator.of(context).pop();
                    },
                    onPositiveClick: () {
                      Map<String, dynamic> product =
                          widget.loadedProduct.toJson();
                      product["quantity"] =
                          double.parse(_quantityController.text);
                      product["total"] = totalAmount;
                      CartItemModel cartItemModel =
                          CartItemModel.fromJson(product);

                      context
                          .read<CartBloc>()
                          .add(CartItemAdded(cartItemModel));
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                  );
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LineIcons.shoppingCart,
                size: 25,
              ),
              SizedBox(
                width: 5.w,
              ),
              const Text("Add to cart"),
            ],
          ),
        ),
      ),
    );
  }
}
