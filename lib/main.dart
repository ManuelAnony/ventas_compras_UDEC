import 'package:compras/view/comprador.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/vendedor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false , home: InicioVendedor());
  }
}
class InicioVendedor extends StatefulWidget {
  @override
  HomeVendedor createState() => HomeVendedor();
}

class HomeVendedor extends State<InicioVendedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón de interruptor (Switch)
            Switch(
              value: true,
              onChanged: (value) {},
            ),

            // Botón para ir a inventarios
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Inventario()));

              },
              child: const Text('Ir a Inventarios'),
            ),

            // Botón para ir a la base de pedidos
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Ir a Base de Pedidos'),
            ),
          ],
        ),
      ),
    );
  }
}
