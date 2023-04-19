import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario',
      home: Inventario(),
    );
  }
}
class Inventario extends StatefulWidget {
  @override
  _InventarioState createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007B3E),
        title: Text('Inventario'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: items.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrió un error al cargar los datos.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<Item> itemList = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Item(
              document.id,
              data['name'],
              data['quantity'],
              data['price'],
            );
          }).toList();

          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _showEditDialog(itemList[index]),
                child: ItemCard(item: itemList[index]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        backgroundColor: Color(0xFFABDB7F),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _nameController = TextEditingController();
        final TextEditingController _quantityController = TextEditingController();
        final TextEditingController _priceController = TextEditingController();

        return AlertDialog(
          title: Text('Agregar Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Precio',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar',
                style: TextStyle(
                  color: Color(0xFFABDB7F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar',
                style: TextStyle(
                  color: Color(0xFFABDB7F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                String name = _nameController.text;
                int quantity = int.parse(_quantityController.text);
                double price = double.parse(_priceController.text);

                await items.add({
                  'name': name,
                  'quantity': quantity,
                  'price': price,
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Item item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      final TextEditingController _nameController = TextEditingController(text: item.name);
      final TextEditingController _quantityController =
      TextEditingController(text: item.quantity.toString());
      final TextEditingController _priceController =
      TextEditingController(text: item.price.toString());

      return AlertDialog(
        title: Text('Editar Item'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Precio: ',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar',
              style: TextStyle(
                color: Color(0xFFABDB7F),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Eliminar',
              style: TextStyle(
                color: Color(0xFFABDB7F),
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              //primary: Colors.red,
            ),
            onPressed: () async {
              await items.doc(item.id).delete();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Guardar',
              style: TextStyle(
                color: Color(0xFFABDB7F),
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              String name = _nameController.text;
              int quantity = int.parse(_quantityController.text);
              double price = double.parse(_priceController.text);

              await items.doc(item.id).update({
                'name': name,
                'quantity': quantity,
                'price': price,
              });

              Navigator.of(context).pop();
            },
          ),
        ],
      );
        },
    );
  }
}

class Item {
  final String id;
  final String name;
  final int quantity;
  final double price;

  Item(this.id, this.name, this.quantity, this.price);
}

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('Cantidad: ${item.quantity}\nPrecio: ${item.price}'),

      ),
      );

  }

}