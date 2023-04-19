import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007B3E),
        title: Text('Pedidos'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pedidos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Ocurrió un error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Cargando...');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> pedido = document.data() as Map<String, dynamic>;
              final List<dynamic> items = pedido['items'] ?? [];
              return ListTile(
                title: Text(pedido['nombreComprador'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pedido['direccion'] ?? ''),
                    Text('Total: ${pedido['total']}'),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView(
                              shrinkWrap: true,
                              children: items.map((item) {
                                return Card(
                                  color: Colors.grey[200],
                                  child: ListTile(
                                    title: Text(
                                      item['nombre'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Precio: ${item['precio']} - Cantidad: ${item['cantidad']}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                      child: Text('Ver detalles'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFABDB7F),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}