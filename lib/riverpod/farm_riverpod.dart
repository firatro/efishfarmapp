import 'dart:io';

import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/services/app_services.dart';
import 'package:efishfarmapp/services/db_services.dart';
import 'package:flutter/material.dart';

class FarmRiverpod extends ChangeNotifier {
  final dbServices = DbServices();
  final appServices = AppServices();
  Company? company;
  File? image;
  Product? newProduct;

  getCompany() => dbServices.getCompany();
  getProduct() => dbServices.getProduct();
  deleteProduct(int index) => dbServices.deleteProduct(index);

  addProduct() => dbServices.addProduct(product: newProduct);

  Future<String> uploadFile() => dbServices.uploadFile(image: image).then(
        (value) {
          return value;
        },
      );

  Future<File?> pickImageC() => appServices.pickImageC().then(
        (value) {
          return value;
        },
      );

  Future<File?> pickImage() => appServices.pickImage().then(
        (value) {
          return value;
        },
      );
}
