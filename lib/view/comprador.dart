import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras/DTO/CompradorItem.dart';
import 'package:compras/DTO/CompradorItemCard.dart';
import 'package:compras/DTO/Pedido.dart';
import 'package:firebase_core/firebase_core.dart';
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
              onPressed: () async{
                if (nombreUsuario.isNotEmpty && direccion.isNotEmpty && itemList.isNotEmpty) {
                  Pedido pedido = Pedido(
                    nombreComprador: nombreUsuario,
                    direccionEnvio: direccion,
                    items: itemList.where((item) => item.quantity > 0).toList(),
                  );

                  // Inicializar Firebase
                  await Firebase.initializeApp();

                  // Obtener la referencia a la colección de pedidos en Firebase
                  final pedidoRef = FirebaseFirestore.instance.collection('pedidos');

                  // Guardar el pedido en Firebase
                  await pedidoRef.add({
                    'nombreComprador': pedido.nombreComprador,
                    'direccionEnvio': pedido.direccionEnvio,
                    'items': pedido.items.map((item) => {
                      'nombre': item.name,
                      'precio': item.price,
                      'cantidad': item.quantity,
                    }).toList(),
                    'fecha': DateTime.now(),
                  });

                  // Actualizar la cantidad de elementos en Firebase
                  final itemsRef = FirebaseFirestore.instance.collection('items');
                  pedido.items.forEach((item) async {
                    final itemDoc = itemsRef.doc(item.name);
                    final itemSnapshot = await itemDoc.get();
                    final itemData = itemSnapshot.data();
                    final itemQuantity = itemData!['quantity'];
                    await itemDoc.update({'quantity': itemQuantity - item.quantity});
                  });

                  // Mostrar una alerta indicando que el pedido fue realizado con éxito
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Pedido realizado con éxito'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                }
              },
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



