import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/address/address_provider.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/address/widgets/new_address_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'widgets/edite_or_add_address.dart';
import '../../core/colors/app_color.dart';

class ScreenAddAddress extends StatelessWidget {
  const ScreenAddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    final String email = FirebaseAuth.instance.currentUser!.email!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          'Address',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .collection('address')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CupertinoActivityIndicator(
                        radius: 40,
                      ));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No Address Found!',
                              style: TextStyle(fontSize: 20)));
                    }

                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Consumer<AddressProvider>(
                            builder: (context, value, child) => RadioListTile(
                              activeColor: AppConstantsColor.materialThemeColor,
                              contentPadding: const EdgeInsets.all(0),
                              value: index,
                              groupValue: value.selectedAddressIndex,
                              onChanged: (value) {
                                addressProvider.setSelectedAddressIndex(index);
                                addressProvider.updateSelectedAddress(
                                    snapshot.data!.docs[index].id);
                                addressProvider.getDefaultAddress();
                              },
                              title: AddAddressCard(
                                  data: snapshot.data!.docs[index]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => constSizedBox10,
                        itemCount: snapshot.data!.docs.length);
                  }),
            ),
            constSizedBox10,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: AppConstantsColor.materialThemeColor,
                foregroundColor: Colors.white,
                fixedSize: Size(270.w, 10.h),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const EditOrAddAddress(
                        editOrAdd: true,
                      ),
                    ));
              },
              child: const Text(
                'Add',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
