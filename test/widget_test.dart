
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr/Feature/Login%20Screen/Login_Screen.dart';

import 'package:mspr/main.dart';
import 'dart:core';

import 'package:mspr/widget/product_bloc.dart';

void main() {
test('productItems stream should emit list of products', () async {
    final bloc = ProductBloc();

    // Listen for the first emitted list of products
    final list = await bloc.productItems.first;

    // Expect that the list is not null
    expect(list, isNotNull);

    // Expect that the list contains at least one product
    expect(list.length, greaterThan(0));
  });
}
