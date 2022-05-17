import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../global_bloc/blocs.dart';
import '../../../../widget/custom_horizontal_sliver_list.dart';
import '../../../../widget/custom_label_info.dart';
import 'components/update_address_form.dart';
import 'components/update_mobile_form.dart';
import 'components/update_password_form.dart';
import '/data/models/customer_address/customer_address_model.dart';

import '/presentation/views/home_page/screens/profile_screen/components/update_email_form.dart';
import '/presentation/widget/constant.dart';
import '/presentation/widget/custom_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerInfoBloc>.value(
      value: context.read<CustomerInfoBloc>()..add(GetCustomerInfo()),
      child: Scaffold(
        body: BlocConsumer<CustomerInfoBloc, CustomerInfoState>(
          listener: (context, state) {
            if (state.status == CustomerInfoStateStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == CustomerInfoStateStatus.fetched) {
              context.loaderOverlay.hide();
            } else if (state.status == CustomerInfoStateStatus.error) {
              CustomDialog.error(context, message: state.message ?? "");
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  backgroundColor: Colors.red,
                  expandedHeight: 150,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      (state.customerInfo?.name ?? "").toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    titlePadding: EdgeInsets.only(
                        top: 8.h, right: 8.h, bottom: 10.h, left: 8.h),
                    background: SizedBox(
                      height: 50.h,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(10.h),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Flexible(
                              child: LabelInfo(
                                label: "Contact Number",
                                child: Text(
                                    state.customerInfo?.contactNumber ?? ""),
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  enableDrag: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      topRight: Radius.circular(10.r),
                                    ),
                                  ),
                                  builder: (_) {
                                    return UpdateMobileForm(
                                      contactNumber:
                                          state.customerInfo?.contactNumber ??
                                              "",
                                      bloc: context.read<CustomerInfoBloc>(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Flexible(
                              child: LabelInfo(
                                label: "Email Address",
                                child: Text(state.customerInfo?.email ?? ""),
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  enableDrag: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      topRight: Radius.circular(10.r),
                                    ),
                                  ),
                                  builder: (_) {
                                    return UpdateEmailForm(
                                      contactNumber:
                                          state.customerInfo?.email ?? "",
                                      bloc: context.read<CustomerInfoBloc>(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            const Flexible(
                              child: LabelInfo(
                                label: "Password",
                                child: Text("********"),
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  enableDrag: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      topRight: Radius.circular(10.r),
                                    ),
                                  ),
                                  builder: (_) {
                                    return UpdatePasswordForm(
                                      bloc: context.read<CustomerInfoBloc>(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        // TextButton(
                        //   onPressed: state.customerInfo == null
                        //       ? null
                        //       : () {
                        //           showMaterialModalBottomSheet(
                        //             context: context,
                        //             enableDrag: false,
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.only(
                        //                 topLeft: Radius.circular(10.r),
                        //                 topRight: Radius.circular(10.r),
                        //               ),
                        //             ),
                        //             builder: (_) {
                        //               return AddNewAddressForm(
                        //                 customerId: state.customerInfo!.id!,
                        //                 bloc: context.read<CustomerInfoBloc>(),
                        //               );
                        //             },
                        //           );
                        //         },
                        //   child: const Text("Add New Address"),
                        // )
                      ],
                    ),
                  ),
                ),
                HorizontalSliverList(
                  children: state.customerInfo == null
                      ? []
                      : state.customerInfo!.details
                          .map(
                            (e) => Badge(
                              badgeContent:
                                  (e!.isDefault == null || e.isDefault != true)
                                      ? null
                                      : const Icon(Icons.check),
                              child: Card(
                                child: SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LabelInfo(
                                          label: "Street Address",
                                          child: Text(e.streetAddress ?? ""),
                                        ),
                                        SizedBox(height: 7.h),
                                        LabelInfo(
                                          label: "Baranggay",
                                          child: Text(e.brgy ?? ""),
                                        ),
                                        SizedBox(height: 7.h),
                                        LabelInfo(
                                          label: "City / Municipality",
                                          child: Text(e.cityMunicipality ?? ""),
                                        ),
                                        SizedBox(height: 7.h),
                                        // bottomButton(context, e),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                )
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
            child: const Text(
              "LOGOUT",
              style: TextStyle(letterSpacing: 1),
            ),
          ),
        ),
      ),
    );
  }

  Row bottomButton(BuildContext context, CustomerAddressModel e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          children: [
            IconButton(
              onPressed: () {
                showMaterialModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  builder: (_) {
                    return UpdateAddressForm(
                      bloc: context.read<CustomerInfoBloc>(),
                      addressModel: e,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                CustomDialog.warning(
                  context,
                  message: "Are you sure you want to delete?",
                  onNegativeClick: () {
                    Navigator.of(context).pop();
                  },
                  onPositiveClick: () {
                    context.read<CustomerInfoBloc>().add(
                          DeleteCustomerAddressDetail(e.id!),
                        );
                    Navigator.of(context).pop();
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Flexible(
          flex: 3,
          child: TextButton(
            onPressed: (e.isDefault != null && e.isDefault!)
                ? null
                : () {
                    CustomDialog.warning(context,
                        message:
                            "You want to set this as default shipping address?",
                        onNegativeClick: () {
                      Navigator.of(context).pop();
                    }, onPositiveClick: () {
                      context.read<CustomerInfoBloc>().add(
                            UpdateToDefaultAddress(e.id!, true),
                          );
                      Navigator.of(context).pop();
                    });
                  },
            child: Text((e.isDefault != null && e.isDefault!)
                ? "Default Address"
                : "Set as Default"),
          ),
        )
      ],
    );
  }
}
