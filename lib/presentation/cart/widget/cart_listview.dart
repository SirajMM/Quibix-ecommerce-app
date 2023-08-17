import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import '../functions/cartFunctions.dart';
import 'cart_item_card.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => constSizedBox10,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot data = snapshot.data!.docs[index];

        return Slidable(
          endActionPane: ActionPane(motion: const BehindMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              backgroundColor: AppConstantsColor.materialThemeColor,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (context) {
                CartFunctions.dialogBuilder(context, data['id']);
              },
            )
          ]),
          child: CartItemCard(
            data: data,
            index: index,
          ),
        );
      },
    );
  }
}
