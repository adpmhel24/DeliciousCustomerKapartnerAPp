import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';

import '../../../../../../global_bloc/blocs.dart';
import '../../../../../utils/currency_formater.dart';
import '../../../../../widget/constant.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartItemsLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.cartItems.length,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFFF7F7F7),
                        child: (state.cartItems[index].imageUrl == null)
                            ? ClipOval(
                                child: Image.asset(
                                  "assets/images/placeholder.png",
                                  fit: BoxFit.fill,
                                ),
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: state.cartItems[index].imageUrl!,
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
                      title: Text(
                        state.cartItems[index].itemName,
                        style: const TextStyle(letterSpacing: 1),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  "Quantity:",
                                  style: TextStyle(
                                      color: Constant.inlineLabelColor),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  formatStringToDecimal(state
                                      .cartItems[index].quantity
                                      .toString()),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  "Price:",
                                  style: TextStyle(
                                      color: Constant.inlineLabelColor),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  formatStringToDecimal(
                                      state.cartItems[index].price.toString(),
                                      hasCurrency: true),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Wrap(
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                      color: Constant.inlineLabelColor),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  formatStringToDecimal(
                                      state.cartItems[index].total.toString(),
                                      hasCurrency: true),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ]),
                      trailing: IconButton(
                        splashRadius: Constant.splashRadius,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          CustomDialog.warning(context,
                              message:
                                  "Are you sure you want to remove ${state.cartItems[index].itemName}?",
                              onPositiveClick: () {
                            context.read<CartBloc>().add(
                                  RemoveItemFromCart(state.cartItems[index]),
                                );
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
