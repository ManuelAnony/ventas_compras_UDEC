import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas en pausa',
            style: TextStyle(fontSize: 22),
      ),
      backgroundColor: Color(0xFF007B3E),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Ventas deshabilitadas por el vendedor.\nMuy pronto volveremos con más producto.\n\nGracias por su espera.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}