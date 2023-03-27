import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import 'package:mspr/models/product.dart';
import 'package:mspr/widget/background.dart';

class ProductDetailWidgets extends StatelessWidget {
  final Product product;

  const ProductDetailWidgets({Key? key, required this.product}) : super(key: key);

  Widget appBarColumn(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  defaultTargetPlatform == TargetPlatform.android ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
              ),
              const Text(
                "Détail du produit",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Opacity(
                opacity: 0.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          ProductCard(product: product)
        ],
      );

  Widget quantityCard(Size deviceSize, CartBloc cartBloc) => Positioned(
        top: (deviceSize.height - deviceSize.height * 0.1),
        left: deviceSize.width / 2 - deviceSize.width / 5,
        width: deviceSize.width / 2 - 30,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: const StadiumBorder(),
          shadowColor: Colors.black,
          elevation: 2.0,
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: UIData.kitGradients),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: () => cartBloc.subtractionController.add(true),
                ),
                StreamBuilder<int>(
                  stream: cartBloc.getCount,
                  initialData: 0,
                  builder: (context, snapshot) => Text(
                    snapshot.data.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => cartBloc.additionalController.add(true),
                )
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    CartBloc cartBloc = CartBloc(product);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        appBarColumn(context),
        quantityCard(deviceSize, cartBloc),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with SingleTickerProviderStateMixin {
  var deviceSize;
  AnimationController? controller;
  Animation<double>? animation;

  Widget productCard() {
    var cardHeight = deviceSize.height * 0.8;
    var cardWidth = deviceSize.width * 0.85;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
      child: Ink(
        height: cardHeight,
        width: cardWidth,
        child: Stack(
          children: <Widget>[
            Container(
              height: cardHeight - cardHeight / 2 * 1.2,
              width: double.infinity,
              child: ModelViewer(
                backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src: widget.product.image ?? "assets/products/Astronaut.glb", // a bundled asset file
                alt: widget.product.name,
                loading: Loading.lazy,
                ar: true,
                arModes: ['scene-viewer', 'webxr', 'quick-look'],
                autoRotate: true,
                cameraControls: true,
                disableZoom: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: cardHeight / 2 * 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: UIData.kitGradients),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: ProductDesc(product: widget.product),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller!, curve: Curves.fastOutSlowIn));
    animation!.addListener(() => this.setState(() {}));
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return productCard();
  }
}

class ProductDesc extends StatelessWidget {
  final Product product;

  const ProductDesc({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                product.name,
                style: const TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
              ),
              trailing: Text(product.details["price"] + " €", style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.yellow)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              product.details["description"],
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  (product.details["sizes"] != null)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "Taille",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            RawChip(
                                label: Text(
                                  product.details["sizes"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.cyan)
                          ],
                        )
                      : Container(),
                  (product.details["color"] != null)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Couleur", style: TextStyle(fontWeight: FontWeight.w700)),
                            RawChip(
                              label: Text(
                                product.details["color"],
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.amber,
                            )
                          ],
                        )
                      : Container(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Text("Code", style: TextStyle(fontWeight: FontWeight.w700)),
                      RawChip(
                        label: Text(
                          "PQ1001",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CartViewModel {
  final Product product;
  int get totalQuantity => product.quantity!;
  void addQuantity() => product.quantity = product.quantity! < product.stock ? (product.quantity! + 1) : product.quantity!;
  void deleteQuantity() => product.quantity = product.quantity! > 0 ? (product.quantity! - 1) : product.quantity!;

  CartViewModel({required this.product});
}

class CartBloc {
  late CartViewModel _cartViewModel;
  final additionalController = StreamController<bool>();
  final subtractionController = StreamController<bool>();
  final countController = StreamController<int>();
  Sink<bool> get addItem => additionalController.sink;
  Sink<bool> get subtractItem => subtractionController.sink;
  Stream<int> get getCount => countController.stream;

  CartBloc(Product p) {
    _cartViewModel = CartViewModel(product: p);
    additionalController.stream.listen(onAdd);
    subtractionController.stream.listen(onDelete);
  }

  void onAdd(bool done) {
    _cartViewModel.addQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void onDelete(bool done) {
    _cartViewModel.deleteQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void dispose() {
    additionalController.close();
    subtractionController.close();
    countController.close();
  }
}
