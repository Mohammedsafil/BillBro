import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  factory Item.fromFirestore(DocumentSnapshot doc) {
    return Item(
      id: doc.id,
      name: doc['name'],
      price: (doc['price'] as num).toDouble(),
    );
  }
}

Future<List<Item>> fetchItemsFromFirestore() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('items').get();
    return querySnapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
  } catch (e) {
    print("Firestore fetch error: $e");
    return [];
  }
}
