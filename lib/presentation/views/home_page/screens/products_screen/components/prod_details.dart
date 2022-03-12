import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/data/models/models.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/presentation/views/home_page/screens/products_screen/components/bloc/addtocart_bloc.dart';
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
  final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddtocartBloc>(
      create: (context) => AddtocartBloc()
        ..add(
          QuantityChanged(
            quantity: double.parse(_quantityController.text),
            price: widget.loadedProduct.price ?? 0.00,
            discprcnt: _customerInfoRepo.customer.allowedDisc ?? 0.00,
          ),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.red, //change your color here
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
                  padding:
                      EdgeInsets.only(right: 10.w, left: 10.w, bottom: 20.h),
                  sliver: BlocBuilder<AddtocartBloc, AddtocartState>(
                    builder: (_, state) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 50),
                            Text(
                              widget.loadedProduct.itemName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.h),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                IconButton(
                                  splashRadius: Constant.splashRadius,
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    int quantity = int.tryParse(
                                            _quantityController.text) ??
                                        0;
                                    if (quantity > 0) {
                                      quantity -= 1;
                                      setState(() {
                                        _quantityController.value =
                                            TextEditingValue(
                                          text: quantity.toString(),
                                          selection: TextSelection.collapsed(
                                              offset:
                                                  quantity.toString().length),
                                        );
                                        context.read<AddtocartBloc>().add(
                                              QuantityChanged(
                                                quantity: double.parse(
                                                    _quantityController.text),
                                                price: widget
                                                        .loadedProduct.price ??
                                                    0.00,
                                                discprcnt: _customerInfoRepo
                                                        .customer.allowedDisc ??
                                                    0.00,
                                              ),
                                            );
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
                                      double quantity = 0;

                                      quantity = double.tryParse(value) ?? 0.00;

                                      context.read<AddtocartBloc>().add(
                                            QuantityChanged(
                                              quantity: quantity,
                                              price:
                                                  widget.loadedProduct.price ??
                                                      0.00,
                                              discprcnt: _customerInfoRepo
                                                      .customer.allowedDisc ??
                                                  0.00,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                                IconButton(
                                  splashRadius: Constant.splashRadius,
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    int quantity = int.tryParse(
                                            _quantityController.text) ??
                                        0;
                                    quantity += 1;
                                    setState(() {
                                      _quantityController.value =
                                          TextEditingValue(
                                        text: quantity.toString(),
                                        selection: TextSelection.collapsed(
                                            offset: quantity.toString().length),
                                      );

                                      context.read<AddtocartBloc>().add(
                                            QuantityChanged(
                                              quantity: double.parse(
                                                  _quantityController.text),
                                              price:
                                                  widget.loadedProduct.price ??
                                                      0.00,
                                              discprcnt: _customerInfoRepo
                                                      .customer.allowedDisc ??
                                                  0.00,
                                            ),
                                          );
                                    });
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 10.h),
                            price(context),
                            SizedBox(height: 10.h),
                            discount(state),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Total: ${formatStringToDecimal(
                                state.netTotal.toString(),
                                hasCurrency: true,
                              )}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.only(
                left: 10.h,
                right: 10.h,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ElevatedButton(
              onPressed: context.watch<AddtocartBloc>().state.status ==
                      AddtocartblocStatus.valid
                  ? () {
                      var addToCartBloc = context.read<AddtocartBloc>();
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
                          product["discprcnt"] = addToCartBloc.state.discprcnt;
                          product["disc_amount"] = double.parse(addToCartBloc
                              .state.discAmount
                              .toStringAsFixed(2));
                          product["total"] = double.parse(
                              addToCartBloc.state.netTotal.toStringAsFixed(2));
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
                    }
                  : null,
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
      }),
    );
  }

  Wrap discount(AddtocartState state) {
    return Wrap(
      spacing: 5,
      children: [
        const Text(
          "Discount:",
          style: TextStyle(color: Constant.inlineLabelColor),
        ),
        Text(
          formatStringToDecimal(
            state.discAmount.toString(),
            hasCurrency: true,
          ),
        ),
        Text(
          "(${formatStringToDecimal(state.discprcnt.toString())}%)",
        ),
      ],
    );
  }

  Wrap price(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        const Text(
          "Price:",
          style: TextStyle(color: Constant.inlineLabelColor),
        ),
        Text(
          formatStringToDecimal(
            '${widget.loadedProduct.price}',
            hasCurrency: true,
          ),
        ),
      ],
    );
  }
}
