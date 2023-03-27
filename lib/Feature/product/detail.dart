import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mspr/models/product.dart';
import 'package:mspr/provider/product_provider.dart';
import 'package:mspr/widget/background.dart';
import 'package:mspr/widget/product_bloc.dart';
import 'package:mspr/widget/product_detail_widget.dart';

class ProductDetailPage extends StatelessWidget {
  // ignore: unnecessary_new
  Widget productScaffold(Stream<List<Product>> products) => new Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: StreamBuilder<List<Product>>(
          stream: products,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoginBackground(
                        showIcon: false,
                      ),
                      ProductDetailWidgets(product: snapshot.data![0]),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }));
  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
    return ProductProvider(productBloc: productBloc, child: productScaffold(productBloc.productItems));
  }
}
