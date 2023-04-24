import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras/DTO/CompradorItem.dart';
import 'package:compras/DTO/CompradorItemCard.dart';
import 'package:compras/DTO/Pedido.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:compras/view/CompradorItemCard.dart';

class Compradores extends StatefulWidget {
  @override
  _CompradoresState createState() => _CompradoresState();
}
class _CompradoresState extends State<Compradores> {

  CollectionReference items = FirebaseFirestore.instance.collection('items');

  List<CompradorItem> itemList = [];



  String nombreUsuario = '';
  String direccion = 'Universidad';


  Container pagoTotal(List<CompradorItem> itemList) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text("Total:  \$${valorTotal(itemList)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(itemList) {
    double total = 0.0;

    for (int i = 0; i < itemList.length; i++) {
      total = total + itemList[i].price * itemList[i].selecQuantity;
    }
    return total.toStringAsFixed(2);
  }




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
          Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
          child: Center(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    //final String imagen = _cart[index].image;
                    var item = itemList[index];
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                          color: Colors.black,),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Colors.blue,
                                                    offset: Offset(0.0, 1.0),
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0),
                                                ),
                                            ),
                                            margin: EdgeInsets.only(top: 20.0),
                                            padding: EdgeInsets.all(2.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (itemList[index].selecQuantity > 0) {
                                                        itemList[index].selecQuantity--;
                                                      }
                                                      valorTotal(itemList);
                                                    });
                                                  },
                                                  color: Colors.yellow,
                                                ),
                                                Text('${itemList[index].selecQuantity}',
                                                    style: new TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.white)),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (itemList[index].selecQuantity < itemList[index].quantity) {
                                                        itemList[index].selecQuantity++;
                                                      }
                                                      valorTotal(itemList);
                                                    });
                                                  },
                                                  color: Colors.yellow,
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 38.0,
                                  ),
                                  Text(item.price.toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0,
                                          color: Colors.black))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xFF349665),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                pagoTotal(itemList),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  height: 100,
                  width: 200,
                  padding: EdgeInsets.only(top: 50),
                  child:ElevatedButton(
                    onPressed: () async{
                      if (nombreUsuario.isNotEmpty && direccion.isNotEmpty && itemList.isNotEmpty) {
                        Pedido pedido = Pedido(
                          nombreComprador: nombreUsuario,
                          direccionEnvio: direccion,
                          items: itemList.where((item) => item.quantity > 0).toList(),
                          valorTotal: valorTotal(itemList), // <-- Agregar el valor total del pedido
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
                            'cantidad': item.selecQuantity,
                          }).toList(),
                          'fecha': DateTime.now(),
                          'valorTotal': pedido.valorTotal,
                        });

                        // Actualizar la cantidad de elementos en Firebase
                        final itemsRef = FirebaseFirestore.instance.collection('items');
                        pedido.items.forEach((item) async {
                          final itemDoc = itemsRef.doc(item.name);
                          final itemSnapshot = await itemDoc.get();
                          final itemData = itemSnapshot.data();
                          final itemQuantity = itemData!['quantity'];
                          await itemDoc.update({'quantity': item.quantity - item.selecQuantity});
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
              ]

            ),
          ),
          ),



        ],
      ),

    );
  }

}



