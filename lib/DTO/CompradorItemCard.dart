import 'package:compras/DTO/CompradorItem.dart';
import 'package:flutter/material.dart';

class CompradorItemCard extends StatefulWidget {
  final CompradorItem compradorItem;

  CompradorItemCard({required this.compradorItem});

  @override
  _CompradorItemCardState createState() => _CompradorItemCardState();
}

class _CompradorItemCardState extends State<CompradorItemCard> {
  int cantidadSeleccionada = 0;
  List<int> cantidadSeleccionadaArray = [];

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
                  cantidadSeleccionadaArray.add(cantidadSeleccionada);
                  print(cantidadSeleccionadaArray);
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