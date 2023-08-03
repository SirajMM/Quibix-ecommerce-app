import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/address/address_provider.dart';
import 'package:e_commerce_store/presentation/address/widgets/edite_or_add_address.dart';
import 'package:e_commerce_store/presentation/address/functions/address_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../order_summery/widgets/custom_text.dart';

class AddAddressCard extends StatelessWidget {
  const AddAddressCard({super.key, required this.data});
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700.h,
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: .5,
            color: Colors.black,
          ),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 20, top: 30).r,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constSizedBox10,
                  CustomText(title: 'Name', subTitle: data['name']),
                  constSizedBox10,
                  CustomText(title: 'City', subTitle: data['city']),
                  constSizedBox10,
                  CustomText(title: 'State', subTitle: data['state']),
                  constSizedBox10,
                  CustomText(
                      title: 'Phone number',
                      subTitle: data['phoneNumber'].toString()),
                  constSizedBox10,
                  CustomText(
                      title: 'Zip code', subTitle: data['pin code'].toString()),
                  constSizedBox10,
                  CustomText(
                      title: 'Country code', subTitle: data['country code']),
                  constSizedBox10,
                  CustomText(
                      title: 'Permanent Address',
                      subTitle: data['permanent adress']),
                ],
              ),
              Positioned(
                top: 0,
                right: 30,
                width: 70,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              EditOrAddAddress(editOrAdd: false, data: data),
                        ));
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    AdressFunctions().detleteShowDialoge(context, data['id']);
                    Provider.of<AddressProvider>(context, listen: false)
                        .getDefaultAddress();
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
