import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/global_bloc/blocs.dart';
import 'package:kapartner_app/presentation/widget/custom_text_field.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../widget/ph_location_modal_widgets/brgy_modal_selection.dart';
import '../../../../../widget/ph_location_modal_widgets/city_municipality_modal_selection.dart';

class AddNewAddressForm extends StatefulWidget {
  const AddNewAddressForm(
      {Key? key, required this.bloc, required this.customerId})
      : super(key: key);
  final CustomerInfoBloc bloc;
  final int customerId;

  @override
  _AddNewAddressFormState createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<AddNewAddressForm> {
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _brgyControllerController =
      TextEditingController();
  final TextEditingController _citymunicipalityController =
      TextEditingController();
  bool _isDefault = true;
  final _formKey = GlobalKey<FormState>();
  final PhLocationRepo _locRepo = AppRepo.phLocationRepository;

  @override
  void dispose() {
    _streetAddressController.dispose();
    _brgyControllerController.dispose();
    _citymunicipalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: (SizeConfig.screenHeight * .6).h,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 10.w,
              right: 10.w,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Add New Address",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.h),
                  CityMunicipalityModal(
                    controller: _citymunicipalityController,
                    phLocationRepo: _locRepo,
                  ),
                  SizedBox(height: 20.h),
                  SelectBaranggayModal(
                    controller: _brgyControllerController,
                    phLocationRepo: _locRepo,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    labelText: "Street Address*",
                    controller: _streetAddressController,
                    minLines: 2,
                    maxLines: 5,
                    validator: (value) {
                      return value == null ? "Required field!" : null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  FormBuilderCheckbox(
                    name: 'isDefault',
                    title: const Text("Default Address"),
                    initialValue: _isDefault,
                    onChanged: (isDefault) {
                      _isDefault = isDefault ?? false;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "street_address": _streetAddressController.text,
                            "city_municipality":
                                _citymunicipalityController.text,
                            "brgy": _brgyControllerController.text,
                            "is_default": _isDefault,
                          };
                          widget.bloc.add(AddNewCustomerDetail(
                              widget.customerId,
                              CustomerAddressModel.fromJson(data)));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
