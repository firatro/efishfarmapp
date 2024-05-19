import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/farm_pages/add_product_page.dart';
import 'package:efishfarmapp/views/farm_pages/edit_company_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class ProductPage extends ConsumerStatefulWidget {
  const ProductPage(this.product, this.index, {super.key});
  final Product product;
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  widget.product.photo != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              '${widget.product.photo}',
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Center(
                                    //I added this widget to show that the width limiting widget doesn't need to be a direct parent.
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.product.description,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              ref.read(farmRiverpod).deleteProduct(widget.index);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.post_add),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Ürünü Sil"),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 150,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor: AppColors.lightBlue,
                        //         foregroundColor: AppColors.white,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(10))),
                        //     onPressed: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => EditCompanyPage(),
                        //       ));
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Icon(Icons.edit),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         Text("Düzenle"),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
