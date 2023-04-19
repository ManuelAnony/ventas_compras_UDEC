import 'package:compras/DTO/CompradorItem.dart';
import 'package:compras/view/comprador.dart';

class Pedido {
  final String nombreComprador;
  final String direccionEnvio;
  final List<CompradorItem> items;

  Pedido({
    required this.nombreComprador,
    required this.direccionEnvio,
    required this.items,
  });
}