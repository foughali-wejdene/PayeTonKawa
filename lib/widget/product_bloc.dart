import 'dart:async';

import 'package:mspr/models/product.dart';
import 'package:mspr/service/productService.dart';

class ProductBloc {
  final productController = StreamController<List<Product>>();
  Stream<List<Product>> get productItems => productController.stream;

  ProductBloc() {
    runZonedGuarded<Future<void>>(() async {
      List<Product> list = await ProductService.getAllProduct();
      productController.add(list);
    }, (error, stack) {});
  }
}
