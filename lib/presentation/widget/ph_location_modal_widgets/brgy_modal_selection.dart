import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../utils/size_config.dart';
import '../constant.dart';
import '../custom_choices_modal.dart';
import '../custom_text_field.dart';
import '/global_bloc/ph_location_bloc/brgy_bloc/bloc.dart';
import '/data/repositories/repositories.dart';

class SelectBaranggayModal extends StatelessWidget {
  const SelectBaranggayModal({
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
      autovalidateMode: autovalidateMode,
      controller: controller,
      labelText: labelText ?? 'Barangay',
      onChanged: onChanged,
      onTap: () {
        context.read<BrgyBloc>().add(FetchBrgyFromApi());
        showMaterialModalBottomSheet(
          context: context,
          enableDrag: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) => BlocConsumer<BrgyBloc, BrgyState>(
            listener: (_, state) {
              if (state is BrgyErrorState) {
                CustomDialog.error(context, message: state.message);
              }
            },
            builder: (_, state) {
              if (state is BrgyLoadedState) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                context.read<BrgyBloc>().add(
                                      SearchBrgyByKeyword(value),
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
                              context.read<BrgyBloc>().add(FetchBrgyFromApi());
                            },
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.brgys.length,
                              itemBuilder: (_, index) {
                                return ListTile(
                                  title: Text(state.brgys[index].name),
                                  selectedColor: Constant.onSelectedColor,
                                  selected: controller.text ==
                                      state.brgys[index].name,
                                  onTap: () {
                                    controller.text = state.brgys[index].name;
                                    if (onChanged != null) {
                                      // onChanged(controller.text);
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
                  ),
                );
              } else if (state is BrgyLoadingState) {
                return SizedBox(
                  height: (SizeConfig.screenHeight * .75).h,
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
      prefixIcon: const Icon(LineIcons.building),
      suffixIcon: suffixIcon,
      validator: validator,
    );
  }
}

// brgyModalSelection({
//   required BuildContext context,
//   required PhLocationRepo phLocationRepo,
//   required TextEditingController controller,
//   String? labelText,
//   Widget? suffixIcon,
//   AutovalidateMode? autovalidateMode,
//   String? Function(String?)? validator,
//   Function(String)? onChanged,
// }) {}
