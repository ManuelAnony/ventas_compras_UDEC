import 'package:cloud_firestore/cloud_firestore.dart';

class CompradorItem {
  final String id;
  final String name;
  late int quantity;
  late int selecQuantity; // <- agregando "late" aquí
  final double price;

  CompradorItem(DocumentSnapshot document)
      : id = document.id,
        name = document['name'],

        price = document['price'] {
    // inicializar la variable "selecQuantity" después de la creación del objeto
        this.selecQuantity = document['selecQuantity'];
        this.quantity = document['quantity'];
  }
}