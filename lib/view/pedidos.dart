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
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: snapshot.data!.docs.map((DocumentSnapshot document) {
    final Map<String, dynamic> pedido = document.data() as Map<String, dynamic>;
    final List<dynamic> items = pedido['items'] ?? [];
    return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 3,
    blurRadius: 7,
    offset: Offset(0, 3),
    ),
    ],
    ),
    child: Card(
    child: Column(
    children: [
    ListTile(
    title: Text(pedido['nombreComprador'] ?? ''),
    subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(pedido['direccion'] ?? ''),
    Text('Total: ${pedido['valorTotal']}'),
    ElevatedButton(
    onPressed: () {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
    return ListView(
    shrinkWrap: true,
    children: items.where((item) => item['cantidad'] > 0).map((item) {
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
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Eliminar pedido'),
                    content: Text('¿Está seguro de que desea eliminar este pedido?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('pedidos')
                              .doc(document.id)
                              .delete();
                          Navigator.of(context).pop();
                        },
                        child: Text('Sí, eliminar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
    ),

    ),

    );
    }).toList(),
    ),
    );
    },
        ),
    );
  }
}