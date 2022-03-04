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

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key, required this.bloc, this.addressModel})
      : super(key: key);
  final CustomerAddressModel? addressModel;
  final CustomerInfoBloc bloc;

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _brgyControllerController =
      TextEditingController();
  final TextEditingController _citymunicipalityController =
      TextEditingController();
  late bool? _isDefault;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _streetAddressController.text = widget.addressModel != null
        ? widget.addressModel!.streetAddress ?? ""
        : "";
    _brgyControllerController.text =
        widget.addressModel != null ? widget.addressModel!.brgy ?? "" : "";
    _citymunicipalityController.text = widget.addressModel != null
        ? widget.addressModel!.cityMunicipality ?? ""
        : "";

    _isDefault =
        widget.addressModel != null ? widget.addressModel!.isDefault : null;
    super.initState();
  }

  @override
  void dispose() {
    _streetAddressController.dispose();
    _brgyControllerController.dispose();
    _citymunicipalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhLocationRepo _locRepo = AppRepo.phLocationRepository;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: (SizeConfig.screenHeight * .7).h,
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
                    "Update Address",
                    style: Theme.of(context).textTheme.subtitle1,
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
                    labelText: "Street Address",
                    controller: _streetAddressController,
                    minLines: 2,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10.h),
                  FormBuilderCheckbox(
                    name: 'isDefault',
                    title: const Text("Default Address"),
                    onChanged: (isDefault) {
                      _isDefault = isDefault;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
