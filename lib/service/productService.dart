import 'dart:convert' show json, jsonEncode;
import 'dart:io' show Platform;

import 'package:http/http.dart';
import 'package:mspr/Core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/models/product.dart';

class ProductService {
  /// Function to get all the cars of a specific Product.
  static Future<List<Product>> getAllProduct() async {
    Response response;
    String url = "${Constant.iosHost}/products";
    late List<dynamic> datas;
    List<Product> products = List<Product>.empty(growable: true);

    if (Platform.isAndroid) {
      url = "${Constant.androidHost}/products";
    }
    response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      datas = json.decode(response.body);
    }

    for (var element in datas) {
      products.add(Product.fromMap(element));
    }

    return products;
  }

  static Future<Product?> getOneProduct(int id) async {
    Response response;
    String url = "${Constant.iosHost}/products/$id";
    late Map<String, dynamic> datas;

    if (Platform.isAndroid) {
      url = "${Constant.androidHost}/products/$id";
    }
    response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      datas = json.decode(response.body);
      Product product = Product.fromMap(datas);

      return product;
    }

    return null;
  }
}
