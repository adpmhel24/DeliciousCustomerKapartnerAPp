import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/data/repositories/repositories.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_bloc.dart';
import 'package:kapartner_app/global_bloc/auth_bloc/auth_event.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';

import '../../../../widget/custom_horizontal_sliver_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;
    return Scaffold(
      body: CustomScrollView(
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
                  _customerInfoRepo.customer.name.toUpperCase(),
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
                  CustomTextField(
                    enabled: false,
                    labelText: "Mobile Number",
                    initialValue: _customerInfoRepo.customer.contactNumber,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    enabled: false,
                    labelText: "Email Address",
                    initialValue: _customerInfoRepo.customer.email,
                  ),
                ],
              ),
            ),
          ),
          HorizontalSliverList(
            children: _customerInfoRepo.customer.details
                .map(
                  (e) => Badge(
                    badgeContent: const Icon(Icons.check),
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
                                initialValue: e!.streetAddress ?? "",
                                minLines: 1,
                                maxLines: 5,
                              ),
                              SizedBox(height: 7.h),
                              CustomTextField(
                                enabled: false,
                                labelText: "Baranggay",
                                initialValue: e.brgy ?? "",
                                minLines: 1,
                                maxLines: 5,
                              ),
                              SizedBox(height: 7.h),
                              CustomTextField(
                                enabled: false,
                                labelText: "City / Municipality",
                                initialValue: e.cityMunicipality ?? "",
                                minLines: 1,
                                maxLines: 5,
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
