import 'package:compras/DTO/CompradorItem.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var _productos = {}.obs;

  void addProducto(CompradorItem producto){
    if (_productos.containsKey(producto)){
      _productos[producto] += 1;
    } else{
      _productos[producto] = 1;
    }

    Get.snackbar(
      "Producto agregado",
      "Has agregado ${producto.name} en el carrito",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeProducto (CompradorItem producto){
    if(_productos.containsKey(producto) && _productos[producto] == 1){
      _productos.removeWhere((key, value) => key == producto);
    }else {
      _productos[producto] -= 1;
    }
  }

  get productos => _productos;

  get productoSubtotal => _productos.entries
      .map((producto) => producto.key.price * producto.value)
      .toList();

  get total => _productos.entries
      .map((producto) => producto.key.price * producto.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}