
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr/Feature/Login%20Screen/Login_Screen.dart';

import 'package:mspr/main.dart';
import 'package:mspr/widget/background.dart';
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

  test('ArcClipper should return a path with correct shape', () {
    final clipper = ArcClipper();
    final path = clipper.getClip(Size(200, 200));
    expect(path.contains(Offset(100, 190)), isTrue); // check if the curve is centered
    expect(path.contains(Offset(0, 170)), isTrue); // check if the left edge is correct
    expect(path.contains(Offset(200, 170)), isTrue); // check if the right edge is correct
  });
  
}
