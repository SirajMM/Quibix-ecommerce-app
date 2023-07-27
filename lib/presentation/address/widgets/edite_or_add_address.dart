import 'package:e_commerce_store/presentation/login/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import '../../../model/address_model.dart';
import '../../../application/address/address_provider.dart';

class EditOrAddAddress extends StatelessWidget {
  const EditOrAddAddress({super.key, required this.editOrAdd, this.data});
  final bool editOrAdd;
  final data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 225, 225),
      body: Container(
        padding: const EdgeInsets.only(left: 90, right: 90, top: 90).r,
        child: ListView(
          children: [
            Form(
              key: _formKey1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        phoneNumberController.clear();
                        cityController.clear();
                        nameController.clear();
                        addressController.clear();
                        stateController.clear();
                        pincodeController.clear();
                        countryCodeController.clear();
                      },
                      icon: const Icon(
                        CupertinoIcons.chevron_compact_down,
                        size: 40,
                      )),
                  Text(
                    editOrAdd ? 'Add New Address' : 'Edite Address',
                    style:
                        TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
                  ),
                  constSizedBox20,
                  CustomTextField(
                    labelText: 'Name',
                    comtroller: nameController,
                    validator: _nameValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['name'] : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'City',
                    comtroller: cityController,
                    validator: _cityValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['city'] : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'Address',
                    maxLines: 3,
                    keyBoardType: TextInputType.multiline,
                    comtroller: addressController,
                    validator: _addressValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['permanent adress'] : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'State',
                    comtroller: stateController,
                    validator: _stateValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['state'] : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'Phone number',
                    keyBoardType: TextInputType.phone,
                    comtroller: phoneNumberController,
                    validator: _phoneNumberValidator,
                    editeOrAdd: editOrAdd,
                    textString:
                        data != null ? data['phoneNumber'].toString() : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'Pin Code',
                    keyBoardType: TextInputType.number,
                    comtroller: pincodeController,
                    validator: _pincodeValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['pin code'].toString() : '',
                  ),
                  constSizedBox10,
                  CustomTextField(
                    labelText: 'Country code',
                    keyBoardType: TextInputType.phone,
                    comtroller: countryCodeController,
                    validator: _countryCodeValidator,
                    editeOrAdd: editOrAdd,
                    textString: data != null ? data['country code'] : '',
                  ),
                  constSizedBox20,
                  SaveAdressButten(
                    editeOrAdd: editOrAdd,
                    data: data,
                  ),
                  constSizedBox20,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _nameValidator(String? value) {
    if (nameController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _addressValidator(String? value) {
    if (addressController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _pincodeValidator(String? value) {
    if (pincodeController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _stateValidator(String? value) {
    if (stateController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _cityValidator(String? value) {
    if (cityController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _phoneNumberValidator(String? value) {
    if (phoneNumberController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    if (phoneNumberController.text.trim().length < 10) {
      return 'Number should have 10 numbers';
    }
    return null;
  }

  String? _countryCodeValidator(String? value) {
    if (countryCodeController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }
}

class SaveAdressButten extends StatelessWidget {
  const SaveAdressButten({
    super.key,
    required this.editeOrAdd,
    this.data,
  });
  final bool editeOrAdd;
  final data;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey1.currentState!.validate()) {
            editeOrAdd
                ? await Provider.of<AddressProvider>(context, listen: false)
                    .addAddress(
                    Address(
                      name: nameController.text.trim(),
                      pinCode: int.parse(pincodeController.text.trim()),
                      permanentAddress: addressController.text.trim(),
                      countyCode: countryCodeController.text.trim(),
                      phoneNumber: int.parse(phoneNumberController.text.trim()),
                      isDefaultAddress: false,
                      state: stateController.text.trim(),
                      city: cityController.text.trim(),
                    ),
                  )
                    .then((value) {
                    clear();
                    Navigator.pop(context);
                  })
                : Provider.of<AddressProvider>(context, listen: false)
                    .editeAddress(
                        Address(
                          name: nameController.text.trim(),
                          pinCode: int.parse(pincodeController.text.trim()),
                          permanentAddress: addressController.text.trim(),
                          countyCode: countryCodeController.text.trim(),
                          phoneNumber:
                              int.parse(phoneNumberController.text.trim()),
                          state: stateController.text.trim(),
                          city: cityController.text.trim(),
                        ),
                        data['id'])
                    .then((value) {
                    clear();
                    Navigator.pop(context);
                  });
          }
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppConstantsColor.lightTextColor;
              }
              return null;
            },
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              AppConstantsColor.materialThemeColor),
          foregroundColor: MaterialStateProperty.all<Color>(
              AppConstantsColor.lightTextColor),
          fixedSize: MaterialStateProperty.all(const Size(100, 30)),
        ),
        child: const Text('Save'));
  }
}

clear() {
  phoneNumberController.clear();
  cityController.clear();
  nameController.clear();
  addressController.clear();
  stateController.clear();
  pincodeController.clear();
  countryCodeController.clear();
}

GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController pincodeController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController countryCodeController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
