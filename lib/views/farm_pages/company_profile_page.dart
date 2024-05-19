import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/farm_pages/add_product_page.dart';
import 'package:efishfarmapp/views/farm_pages/edit_company_page.dart';
import 'package:efishfarmapp/views/farm_pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

// ignore: must_be_immutable
class TabCompany extends ConsumerStatefulWidget {
  const TabCompany({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabCompanyState();
}

class _TabCompanyState extends ConsumerState<TabCompany> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<Company>(
            future: ref
                .read(farmRiverpod)
                .getCompany(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, snapshotCompany) {
              List<Widget> children;
              if (snapshotCompany.hasData) {
                children = <Widget>[
                  //data var
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        snapshotCompany.data?.companyLogo != ""
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image.network(
                                    '${snapshotCompany.data?.companyLogo}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Icon(
                                  Icons.broken_image,
                                  color: AppColors.lightGrey,
                                  size: 150,
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "${snapshotCompany.data?.name}"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: AppColors.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${snapshotCompany.data?.city}, ${snapshotCompany.data?.country}",
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.public,
                                          color: AppColors.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "http://${snapshotCompany.data?.website}",
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.mail, color: AppColors.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${snapshotCompany.data?.email}",
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, color: AppColors.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${snapshotCompany.data?.phone}",
                                        style: TextStyle(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Şirket Hakkında",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.public,
                                            color: AppColors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Faaliyet Alanı \n${snapshotCompany.data?.network}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: AppColors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Çalışanlar \n${snapshotCompany.data?.workerCount}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.flag,
                                            color: AppColors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Kurulduğu Yıl \n${snapshotCompany.data?.yearOfEstablishment}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: AppColors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Sektörü \n${snapshotCompany.data?.sector}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60,
                                            child: Center(
                                              //I added this widget to show that the width limiting widget doesn't need to be a direct parent.
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "${snapshotCompany.data?.description}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Şirket Sahibi/Sorumlu",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  title: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "${snapshotCompany.data?.owner?.name} ${snapshotCompany.data?.owner?.surname}")),
                                ),
                              ],
                            ),
                          ),
                        ),
                        snapshotCompany.data!.products!.isEmpty
                            ? Container()
                            : Container(),
                        FutureBuilder<List<Product>>(
                          future: ref
                              .read(farmRiverpod)
                              .getProduct(), // a previously-obtained Future<String> or null
                          builder: (BuildContext context, snapshotProduct) {
                            List<Widget> children;
                            if (snapshotProduct.hasData) {
                              children = <Widget>[
                                //data var
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Ürünler",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            // Align(
                                            //   alignment: Alignment.topRight,
                                            //   child: Text(
                                            //     "Tümünü görüntüle",
                                            //     style: TextStyle(
                                            //       color: AppColors.lightBlue,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 15,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshotProduct.data!.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    log(index.toString());
                                                    Grock.to(ProductPage(
                                                        snapshotProduct
                                                            .data![index],
                                                        index));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: Card(
                                                          color: Colors.blue,
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              child:
                                                                  Image.network(
                                                                '${snapshotProduct.data![index].photo}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshotProduct
                                                            .data![index].name
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ];
                            } else if (snapshotProduct.hasError) {
                              children = <Widget>[
                                Icon(
                                  Icons.error_outline,
                                  color: AppColors.blue,
                                  size: 60,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 20),
                                  child: Text(
                                      'Bilgiler getiriliyor. Lütfen bekleyiniz.'),
                                ),
                              ];
                            } else {
                              children = const <Widget>[
                                //yükleniyor
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 20),
                                  child: Text(
                                      'Bilgiler getiriliyor. Lütfen bekleyiniz.'),
                                ),
                              ];
                            }
                            //getir
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: children,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.grey,
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AddProductPage(),
                                    ));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.post_add),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Ürün Ekle"),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.lightBlue,
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditCompanyPage(),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Düzenle"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ];
              } else if (snapshotCompany.hasError) {
                children = <Widget>[
                  //data hatası
                  Icon(
                    Icons.error_outline,
                    color: AppColors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Text('Bilgiler getiriliyor. Lütfen bekleyiniz.'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  //yükleniyor
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              //getir
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
