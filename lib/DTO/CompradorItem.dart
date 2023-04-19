import 'package:cloud_firestore/cloud_firestore.dart';

class CompradorItem {
  final String id;
  final String name;
  late final int quantity;
  final double price;

  CompradorItem(DocumentSnapshot document)
      : id = document.id,
        name = document['name'],
        quantity = document['quantity'],
        price = document['price'];
}