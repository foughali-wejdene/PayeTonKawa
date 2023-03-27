import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mspr/Feature/product/product_item.dart';
import 'package:mspr/models/product.dart';
import 'package:mspr/service/productService.dart';

import 'package:mspr/widget/background.dart';
import 'package:mspr/widget/product_bloc.dart';
import 'package:mspr/widget/product_detail_widget.dart';

class TabBarPart extends StatelessWidget {
  const TabBarPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = List.empty(growable: true);
    return FutureBuilder<List<Product>>(
        future: ProductService.getAllProduct(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //const SizedBox(height: 10.0),
                  DefaultTabController(
                      length: 1, // length of tabs
                      initialIndex: 0,
                      child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const TabBar(
                              labelColor: Color(0xFF3D538F),
                              unselectedLabelColor: Colors.black,
                              labelPadding: EdgeInsets.zero,
                              tabs: [
                                Tab(text: 'Liste de nos produits'),
                              ],
                            ),
                            Container(
                              height: 500, //height of TabBarView
                              decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: ProductItem(
                                      product: snapshot.data!.elementAt(index),
                                    ),
                                    onTap: () => {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        ProductBloc productBloc = ProductBloc();
                                        return productScaffold(productBloc.productItems, index);
                                      }))
                                    },
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            )
                          ])),
                ]);
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }

  productScaffold(Stream<List<Product>> products, int index) => Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: StreamBuilder<List<Product>>(
          stream: products,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoginBackground(
                        showIcon: true,
                      ),
                      ProductDetailWidgets(product: snapshot.data![index]),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }));
}
