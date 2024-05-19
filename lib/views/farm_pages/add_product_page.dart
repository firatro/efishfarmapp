import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/menu_pages/farm_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  var image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColors.lightBlue,
            height: 4.0,
          ),
        ),
        title: const Text("Ürün Ekle"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Ürün Bilgilerinizi Giriniz",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ref.read(farmRiverpod).image != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.file(ref.read(farmRiverpod).image!),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColors.grey,
                                size: 100,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "btn1",
                        backgroundColor: AppColors.grey,
                        onPressed: () async {
                          ref.read(farmRiverpod).image =
                              await ref.read(farmRiverpod).pickImage();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.photo,
                          color: AppColors.white,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        backgroundColor: AppColors.grey,
                        onPressed: () async {
                          ref.read(farmRiverpod).image =
                              await ref.read(farmRiverpod).pickImageC();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.photo_camera,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ürün adı giriniz";
                      }
                      return null;
                    },
                    controller: productNameController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    onChanged: (String value) {},
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Ürün Adı",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ürün bilgisi giriniz";
                      }
                      return null;
                    },
                    controller: productDescriptionController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    maxLines: 3,
                    onChanged: (String value) {},
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Ürün detayı",
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        ref
                            .read(farmRiverpod)
                            .dbServices
                            .addProductCompanyUpdate();
                        if (_formKey.currentState!.validate()) {
                          ref.read(farmRiverpod).uploadFile();
                          ref.read(farmRiverpod).newProduct = Product(
                            name: productNameController.text,
                            description: productDescriptionController.text,
                            photo: await ref.read(farmRiverpod).uploadFile(),
                          );
                          ref.read(farmRiverpod).addProduct();
                          ref.read(farmRiverpod).image = null;
                          Navigator.of(context).pop();
                        } else {
                          Grock.toast(
                            text: "Bilgileri kontrol ediniz",
                            backgroundColor: AppColors.red,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        "ÜRÜN EKLE",
                        style: TextStyle(
                          fontSize: 21,
                          height: 1,
                          wordSpacing: 0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
