import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras/view/ventas_deshabilitadas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'DTO/CompradorItem.dart';
import 'DTO/espera.dart';
import 'firebase_options.dart';
import 'view/comprador.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference itemsCollection = FirebaseFirestore.instance.collection('items');

  List<CompradorItem> itemList = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore
          .collection('estado')
          .doc('1cAxVIrUP6bdGpYKueyx')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          bool valor = snapshot.data!.get('mensaje');
          if (valor) {
            print("Entrada correcta");
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Compras',
              home: Compradores(), // pantalla de inicio para valor verdadero
            );
          }else{
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'My App',
              home: ProductPage(),
            );

          }
        }
        // pantalla de inicio para valor falso o si el snapshot no tiene datos
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          home: EsperaPage(),
        );

      },
    );
  }
}