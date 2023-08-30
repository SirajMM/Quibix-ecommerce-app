import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'item_card.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({
    super.key,
    required this.products,
  });
  final Stream<QuerySnapshot<Map<String, dynamic>>> products;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: products,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                  child: CupertinoActivityIndicator(
                radius: 40,
              ));
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  childAspectRatio: (.3 / .4),
                ),
                itemBuilder: (context, index) {
                  final DocumentSnapshot details = snapshot.data!.docs[index];
                  return ItemCard(
                    allDetails: details,
                  );
                });
          }
          return const Center(child: Text('No products found'));
        });
  }
}
