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
        backgroundColor: Color(0xFF007B3E),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30, left: 10,right: 10,bottom: 15),
                  child: TextField(
                  decoration: InputDecoration(
                  labelText: 'Nombre',
                    labelStyle: TextStyle( color: Colors.grey[600],fontSize: 25.0,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF349665),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Color(0xFF349665),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF349665),
                      ),
                    ),
                    hintText: 'Escribe aquí',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                    style: TextStyle(
                      color: Colors.black,

                 ),

                  onChanged: (value) {
                    setState(() {
                      nombreUsuario = value;
                    });
                  },
                  ),
                ),

                  Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10, bottom: 30),
                  child: TextField(
                  decoration: InputDecoration(
                  labelText: 'Direccion',
                    labelStyle: TextStyle( color: Colors.grey[600],fontSize: 25.0,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF349665),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF349665),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF349665),
                      ),
                    ),
                    hintText: 'Escribe aquí',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                    style: TextStyle(
                      color: Colors.black,

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
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
            child: ElevatedButton(
              onPressed: () {        },
              child: Text(
                'Hacer Pedido',
                style: TextStyle(
                  color: Colors.grey[600], // Establecer el color de letra del texto
                  fontSize: 22, // Establecer el tamaño de letra del texto
                  fontWeight: FontWeight.bold, // Establecer el grosor de letra del texto
                ),
              ),

              style: ElevatedButton.styleFrom(
                primary: Color(0xFFABDB7F),
                minimumSize: Size(150, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

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
      color: Color(0xFFABDB7F), // Establecemos el color del Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Establecemos la forma del Card
        side: BorderSide(
          color: Color(0xFF007B3E), // Establecemos el color del borde del Card
          width: 2.0, // Establecemos el ancho del borde del Card
        ),
      ),
      child: ListTile(

        title: Text( widget.compradorItem.name,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        color: Colors.black,),
        ),
        subtitle: Text('Cantidad disponible: ${widget.compradorItem.quantity}\nPrecio: ${widget.compradorItem.price}',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
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
             color: Colors.black,
            ),
            Text(
              cantidadSeleccionada.toString(),
              style: TextStyle(fontSize: 22),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                   setState(() {
                  cantidadSeleccionada = cantidadSeleccionada < widget.compradorItem.quantity ? cantidadSeleccionada + 1 : widget.compradorItem.quantity;
                });
              } ,
              color: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}

