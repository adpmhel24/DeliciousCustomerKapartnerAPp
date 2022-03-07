import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constant.dart';
import '../custom_choices_modal.dart';
import '../custom_text_field.dart';
import '/global_bloc/ph_location_bloc/city_municipality_bloc/bloc.dart';
import '/data/repositories/repositories.dart';

class CityMunicipalityModal extends StatelessWidget {
  const CityMunicipalityModal({
    Key? key,
    required this.phLocationRepo,
    required this.controller,
    this.labelText,
    this.suffixIcon,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final PhLocationRepo phLocationRepo;
  final TextEditingController controller;
  final String? labelText;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    var heightSized = MediaQuery.of(context).size.height;
    return CustomFieldModalChoices(
      controller: controller,
      labelText: labelText ?? 'City / Municipality',
      onChanged: onChanged,
      onTap: () {
        phLocationRepo.selectedCityMunicipalityCode = "";
        context
            .read<CityMunicipalityBloc>()
            .add(FetchCityMunicipalityFromLocal());
        showMaterialModalBottomSheet(
          enableDrag: false,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) =>
              BlocConsumer<CityMunicipalityBloc, CityMunicipalityState>(
            listener: (context, state) {
              if (state is CityMunicipalityErrorState) {
                CustomDialog.error(context, message: state.message);
              }
            },
            builder: (_, state) {
              if (state is CityMunicipalityLoadedState) {
                return SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          child: CustomTextField(
                            labelText: 'Search by keyword',
                            onChanged: (value) {
                              context.read<CityMunicipalityBloc>().add(
                                    SearchCityMunicipalityByKeyword(value),
                                  );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            context
                                .read<CityMunicipalityBloc>()
                                .add(FetchCityMunicipalityFromApi());
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.citiesMunicipalities.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(
                                    state.citiesMunicipalities[index].name),
                                selectedColor: Constant.onSelectedColor,
                                selected: controller.text ==
                                    state.citiesMunicipalities[index].name,
                                onTap: () {
                                  controller.text =
                                      state.citiesMunicipalities[index].name;

                                  phLocationRepo.selectedCityMunicipalityCode =
                                      state.citiesMunicipalities[index].code;

                                  if (onChanged != null) {
                                    onChanged!(controller.text);
                                  }

                                  Navigator.of(context).pop();
                                },
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                thickness: 1,
                                color: Color(0xFFBDBDBD),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CityMunicipalityLoadingState) {
                return SizedBox(
                  height: (heightSized * .75).h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return SizedBox(
                height: (heightSized * .75).h,
                child: const Center(
                  child: Text('No data!'),
                ),
              );
            },
          ),
        );
      },
      prefixIcon: const Icon(LineIcons.city),
      suffixIcon: suffixIcon,
      validator: validator,
    );
  }
}
