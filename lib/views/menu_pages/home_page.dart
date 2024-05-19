import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/core/extensions/l10n_exntesions.dart';
import 'package:efishfarmapp/models/news_model.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/widgets/web_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          child: AppAssets.appLogo,
          height: 50,
        ),
        actions: [
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Color(0xff074173),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            child: Center(
              child: Text(
                context.translate.news,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 25)
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/app_bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: ref.read(appRiverpod).isDarkMode == true
                  ? AppColors.black
                  : AppColors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<NewsModel>(
                        future: ref
                            .read(newsRiverpod)
                            .getNews(), // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<NewsModel> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Column(
                                children: [
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0,
                                            left: 15.0,
                                            top: 15.0,
                                            bottom: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebViewContainer()));
                                          },
                                          child: Container(
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: ref
                                                          .read(appRiverpod)
                                                          .isDarkMode ==
                                                      true
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color.fromARGB(
                                                      54, 150, 150, 155),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 180,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${snapshot.data?.data[index].imageUrl}",
                                                    imageBuilder: (context,
                                                        imageProvider) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                          bottom: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0),
                                                        child: Text(
                                                          "${snapshot.data?.data[index].title}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          8.0),
                                                              child: Text(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                "${snapshot.data?.data[index].description}",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: Icon(
                                                              Icons.read_more,
                                                              color: AppColors
                                                                  .grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ];
                          } else if (snapshot.hasError) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewContainer()));
                                    },
                                    child: Text("Tıkla"),
                                  ),
                                  Icon(
                                    Icons.error_outline,
                                    color:
                                        ref.read(appRiverpod).isDarkMode == true
                                            ? AppColors.white
                                            : AppColors.black,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, right: 16, left: 16),
                                    child: Text(
                                      'Güncel bir haber verisi bulunmamaktadır, daha sonra tekrar deneyiniz.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            ref.read(appRiverpod).isDarkMode ==
                                                    true
                                                ? AppColors.white
                                                : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            children = <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Aqua gündem araştırılıyor...'),
                              ),
                            ];
                          }
                          return Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: children,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
