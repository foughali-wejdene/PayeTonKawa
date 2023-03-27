import 'package:flutter/material.dart';
import 'package:mspr/widget/product_bloc.dart';

class ProductProvider extends InheritedWidget {
  final ProductBloc productBloc;
  final Widget child;

  ProductProvider({super.key, required this.productBloc, required this.child}) : super(child: child);

  static ProductProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ProductProvider>();

  @override
  bool updateShouldNotify(ProductProvider oldWidget) => productBloc != oldWidget.productBloc;
}
