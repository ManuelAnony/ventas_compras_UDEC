import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras/view/comprador.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/vendedor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicioVendedor(),
    );
  }
}

class InicioVendedor extends StatefulWidget {
  @override
  HomeVendedor createState() => HomeVendedor();
}
class HomeVendedor extends State<InicioVendedor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ventas',
          style: TextStyle(fontSize: 22),
          ),
          backgroundColor: Color(0xFF007B3E),

        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    switchValue ? 'Ventas activas' : 'Ventas desactivadas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                    value: switchValue,
                    onChanged: (value) async {
                      setState(() {
                        switchValue = value;
                      });
                      try {
                        await _firestore
                            .collection('estado')
                            .doc('1cAxVIrUP6bdGpYKueyx')
                            .update({
                          'mensaje': switchValue,
                        });
                        print(switchValue);
                      } catch (e) {
                        print('Error al actualizar el documento: $e');
                      }
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inventario()),
                    );
                  },
                  child: Text('Ir a Inventarios',
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acciones del botón para ir a la base de pedidos
                  },
                  child: Text('Ir a Base de Pedidos',
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
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}