import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Compradores extends StatefulWidget {


  @override
  _CompradoresState createState() => _CompradoresState();
}

class _CompradoresState extends State<Compradores> {
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  List<CompradorItem> itemList = [];

  String nombreUsuario = '';
  String direccion = 'Universidad';


  @override
  void initState() {
    super.initState();
    getItems();
  }

  void getItems() async {
    QuerySnapshot querySnapshot = await items.get();
    setState(() {
      itemList = querySnapshot.docs.map((doc) => CompradorItem(doc)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artículos disponibles'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                  decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                   ),
                 ),

                  onChanged: (value) {
                    setState(() {
                      nombreUsuario = value;
                    });
                  },
                  ),
                ),

                  Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                  decoration: InputDecoration(
                  labelText: 'Direccion',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)
                  ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      direccion = value;
                      });
                    },
                    ),
                  ),

              ],
            ),
          ),
          itemList.isEmpty
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return CompradorItemCard(compradorItem: itemList[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text('Hacer Pedido'),
            ),
          ),
        ],
      ),
    );
  }

}
class CompradorItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CompradorItem(DocumentSnapshot document)
      : id = document.id,
        name = document['name'],
        quantity = document['quantity'],
        price = document['price'];
}

class CompradorItemCard extends StatefulWidget {
  final CompradorItem compradorItem;

  CompradorItemCard({required this.compradorItem});

  @override
  _CompradorItemCardState createState() => _CompradorItemCardState();
}

class _CompradorItemCardState extends State<CompradorItemCard> {
  int cantidadSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: Text(widget.compradorItem.name),
        subtitle: Text('Cantidad disponible: ${widget.compradorItem.quantity}\nPrecio: ${widget.compradorItem.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  cantidadSeleccionada = cantidadSeleccionada > 0 ? cantidadSeleccionada - 1 : 0;
                });
              },
            ),
            Text(
              cantidadSeleccionada.toString(),
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  cantidadSeleccionada = cantidadSeleccionada < widget.compradorItem.quantity ? cantidadSeleccionada + 1 : widget.compradorItem.quantity;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}