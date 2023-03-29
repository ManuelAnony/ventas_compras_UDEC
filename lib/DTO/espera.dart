import 'package:flutter/material.dart';

class EsperaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esperando...',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Color(0xFF007B3E),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Página de carga completada'),
            );
          }
        },
      ),

    );
  }
}