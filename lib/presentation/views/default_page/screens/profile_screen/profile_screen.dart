import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_bloc.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_event.dart';
import 'package:kapartner_app/presentation/views/default_page/screens/profile_screen/components/update_email_form.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../global_bloc/blocs.dart';
import '../../../../widget/custom_horizontal_sliver_list.dart';
import 'components/address_form.dart';
import 'components/update_mobile_form.dart';
import 'components/update_password_form.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CustomerInfoBloc, CustomerInfoState>(
        listener: (context, state) {
          if (state is CustomerInfoLoading) {
            CustomDialog.loading(context);
          } else if (state is CustomerInfoLoaded) {
            Navigator.of(context).pop();
          } else if (state is CustomerInfoError) {
            CustomDialog.error(context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is CustomerInfoLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF76E11),
                  expandedHeight: 150,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: FittedBox(
                      child: Text(
                        state.customerInfo.name.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                              child: CustomTextField(
                                readOnly: true,
                                labelText: "Contact Number",
                                initialValue: state.customerInfo.contactNumber,
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(Icons.edit),
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
                                          state.customerInfo.contactNumber,
                                      bloc: context.read<CustomerInfoBloc>(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                enabled: false,
                                labelText: "Email Address",
                                initialValue: state.customerInfo.email,
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(Icons.edit),
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
                                      contactNumber: state.customerInfo.email,
                                      bloc: context.read<CustomerInfoBloc>(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            const Flexible(
                              child: CustomTextField(
                                enabled: false,
                                obsecureText: true,
                                labelText: "Password",
                                initialValue: "************",
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              splashRadius: Constant.splashRadius,
                              icon: const Icon(Icons.edit),
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
                      ],
                    ),
                  ),
                ),
                HorizontalSliverList(
                  children: state.customerInfo.details
                      .map(
                        (e) => Badge(
                          badgeColor:
                              (e!.isDefault == null || e.isDefault != true)
                                  ? Colors.transparent
                                  : Colors.lightGreen,
                          padding: EdgeInsets.zero,
                          badgeContent: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.check),
                            onPressed: () {},
                            splashRadius: Constant.splashRadius,
                          ),
                          child: Card(
                            child: SizedBox(
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      enabled: false,
                                      labelText: "Street Address",
                                      initialValue: e.streetAddress ?? "",
                                      minLines: 1,
                                      maxLines: 5,
                                    ),
                                    SizedBox(height: 7.h),
                                    CustomTextField(
                                      enabled: false,
                                      labelText: "Baranggay",
                                      initialValue: e.brgy ?? "",
                                    ),
                                    SizedBox(height: 7.h),
                                    CustomTextField(
                                      enabled: false,
                                      labelText: "City / Municipality",
                                      initialValue: e.cityMunicipality ?? "",
                                    ),
                                    SizedBox(height: 7.h),
                                    TextButton(
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
                                            return AddressForm(
                                              bloc: context
                                                  .read<CustomerInfoBloc>(),
                                              addressModel: e,
                                            );
                                          },
                                        );
                                      },
                                      child: const Text("Edit"),
                                    ),
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
          }
          return Container();
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
    );
  }
}
