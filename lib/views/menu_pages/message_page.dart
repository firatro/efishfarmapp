import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagePage extends StatefulWidget {
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  User user = FirebaseAuth.instance.currentUser!;

  List<Map<dynamic, dynamic>>? tumKullanicilar;

  bool isLoading = false;

  bool hasMore = true;

  int getirilecekElemanSayisi = 10;

  Map? _enSonGetirilenKullanici;

  Map? kullanici;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getUser(_enSonGetirilenKullanici);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position == 0) {
          debugPrint("En Tepedeyiz");
        } else {
          getUser(_enSonGetirilenKullanici);
        }
      }
    });
  }

  getUser(Map? enSonGetirilenKullanici) async {
    if (!hasMore) {
      debugPrint("Getirilecek eleman kalmadı");
      return;
    }

    if (isLoading) {
      return;
    }

    setState(() {
      isLoading == true;
    });

    QuerySnapshot<Map<dynamic, dynamic>> querySnapshot;
    if (enSonGetirilenKullanici == null) {
      debugPrint("İlk defa kullanıcılar getiriliyor");
      querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("username")
          .limit(getirilecekElemanSayisi)
          .get();

      tumKullanicilar = [];
    } else {
      debugPrint("Sonraki defa kullanıcılar getiriliyor");
      querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("username")
          .startAfter([enSonGetirilenKullanici])
          .limit(getirilecekElemanSayisi)
          .get();
    }

    if (querySnapshot.docs.length < getirilecekElemanSayisi) {
      hasMore = false;
    }

    for (DocumentSnapshot<Map<dynamic, dynamic>> snap in querySnapshot.docs) {
      debugPrint(snap["email"].toString());
      debugPrint(snap["profile_picture"].toString());
      debugPrint(snap["type"].toString());
      debugPrint(snap["ulke"].toString());
      debugPrint(snap["user_id"].toString());
      debugPrint(snap["username"].toString());
      kullanici = {
        "email": snap["email"],
        "profile_picture": snap["profile_picture"],
        "type": snap["type"],
        "ulke": snap["ulke"],
        "user_id": snap["user_id"],
        "username": snap["username"],
      };

      tumKullanicilar?.add(kullanici!);
      debugPrint(tumKullanicilar.toString());
    }

    _enSonGetirilenKullanici = tumKullanicilar?.last;
    debugPrint(
        "en son getirilen kullanıcı: ${_enSonGetirilenKullanici.toString()}");

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading == false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              centerTitle: true,
              title: Container(
                height: 40.0,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color(0xFF13139E),
                ),
                child: Center(
                  child: Text(
                    "Mesajlar",
                    // style: AppTextStyles.loginButtonTextStyle2,
                  ),
                ),
              ),
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Tedarikçiler')),
                  Tab(child: Text('Görüşmelerim')),
                ],
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: <Widget>[
              tumKullanicilar == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: tumKullanicilar?.length == 0
                              ? RefreshIndicator(
                                  onRefresh: _kullanicilarListesiniGuncelle,
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.supervised_user_circle,
                                                color: Colors.grey, size: 100),
                                            Text(
                                              "Kayıtlı Kullanıcı Yok",
                                              style: GoogleFonts.roboto(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: size.height * 0.6,
                                    ),
                                  ),
                                )
                              : kullaniciListesiniOlustur(),
                        ),
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(),
                      ],
                    ),
              // FutureBuilder<List<Konusma>>(
              //   future: tumKonusmalarimiGetir(user.uid),
              //   builder: (context, konusmaListesi) {
              //     if (!konusmaListesi.hasData) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else {
              //       var tumKonusmalar = konusmaListesi.data;

              //       if (tumKonusmalar!.length > 0) {
              //         return RefreshIndicator(
              //           onRefresh: _konusmalarimListesiniYenile,
              //           child: ListView.builder(
              //               itemBuilder: (context, index) {
              //                 var oAnkiKonusma = tumKonusmalar[index];
              //                 var oAnkiKullanici = tumKullanicilar?[index];
              //                 var aliciMap = {
              //                   "user_id": oAnkiKonusma.kimle_konusuyor,
              //                   "username": oAnkiKonusma.konusulanUsername,
              //                   "profile_picture":
              //                       oAnkiKonusma.konusulanUserProfilURL,
              //                 };
              //                 return Column(
              //                   children: [
              //                     GestureDetector(
              //                       onTap: () {
              //                         // Navigator.of(context, rootNavigator: true).push(
              //                         //   MaterialPageRoute(
              //                         //     builder: (context) =>
              //                         //         MessageRoom(user: user, alici: oAnkiKullanici),
              //                         //   ),
              //                         // );

              //                         Navigator.of(context, rootNavigator: true)
              //                             .push(
              //                           MaterialPageRoute(
              //                             builder: (context) => MessageRoom2(
              //                                 alici: aliciMap, gonderen: user),
              //                           ),
              //                         );
              //                       },
              //                       child: ListTile(
              //                         title: Text(
              //                             "${oAnkiKonusma.konusulanUsername}"),
              //                         subtitle: Text(
              //                           "${oAnkiKonusma.son_yollanan_mesaj} · ${oAnkiKonusma.aradakiFark} ${oAnkiKonusma.aradakiFark == "az önce" ? "" : "önce"}",
              //                           overflow: TextOverflow.ellipsis,
              //                           style: TextStyle(
              //                             color: Colors.grey,
              //                           ),
              //                         ),
              //                         leading: CircleAvatar(
              //                           backgroundImage: NetworkImage(
              //                               "${oAnkiKonusma.konusulanUserProfilURL}"),
              //                         ),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding:
              //                           EdgeInsets.only(left: 20.0, right: 20),
              //                       child: Divider(),
              //                     ),
              //                   ],
              //                 );
              //               },
              //               itemCount: tumKonusmalar.length),
              //         );
              //       } else {
              //         return RefreshIndicator(
              //           onRefresh: _konusmalarimListesiniYenile,
              //           child: SingleChildScrollView(
              //             physics: AlwaysScrollableScrollPhysics(),
              //             child: Container(
              //               child: Center(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     Icon(Icons.chat,
              //                         color: Colors.grey, size: 100),
              //                     Text(
              //                       "Henüz Görüşme Yapılmamış",
              //                       textAlign: TextAlign.center,
              //                       style: GoogleFonts.roboto(
              //                           textStyle: Theme.of(context)
              //                               .textTheme
              //                               .headlineMedium),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               height: size.height * 0.6,
              //             ),
              //           ),
              //         );
              //       }
              //     }
              //   },
              // ),
         
            ],
          ),
        ),
      )),
    );
  }

  kullaniciListesiniOlustur() {
    return RefreshIndicator(
      onRefresh: _kullanicilarListesiniGuncelle,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == tumKullanicilar?.length) {
            return yeniKullanicilarYukleniyor();
          }
          return yeniListeKullaniciOlustur(index);
        },
        itemCount: tumKullanicilar!.length + 1,
      ),
    );
  }

  yeniListeKullaniciOlustur(int index) {
    var oAnkiKullanici = tumKullanicilar?[index];
    if (oAnkiKullanici!["user_id"] == user.uid) {
      //debugPrint(widget.userID);
      return Container();
    }
    return GestureDetector(
      onTap: () {
        // Navigator.of(context, rootNavigator: true).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         MessageRoom(user: user, alici: oAnkiKullanici),
        //   ),
        // );

        // Navigator.of(context, rootNavigator: true).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         MessageRoom2(alici: oAnkiKullanici, gonderen: user),
        //   ),
        // );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(oAnkiKullanici!["username"].toString()),
            subtitle: Text(
              "${oAnkiKullanici["email"].toString()}",
              style: TextStyle(color: Colors.grey),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.withAlpha(40),
              backgroundImage: NetworkImage(oAnkiKullanici["profile_picture"]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Divider(),
          )
        ],
      ),
    );
  }

  yeniKullanicilarYukleniyor() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1 : 0,
          child: isLoading ? CircularProgressIndicator() : null,
        ),
      ),
    );
  }

  void konusmalarimiGetir() async {
    var konusmalarim = await FirebaseFirestore.instance
        .collection("konusmalarim")
        .where("konusma_sahibi", isEqualTo: user.uid)
        .orderBy("olusturulma_tarihi", descending: true)
        .get();

    for (var konusma in konusmalarim.docs) {
      debugPrint("konuşma: ${konusma.data.toString()}");
    }
  }

  // @override
  // Future<List<Konusma>> tumKonusmalarimiGetir(String userID) async {
  //   DateTime zaman = await saatiGoster(userID);
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection("konusmalar")
  //       .where("konusma_sahibi", isEqualTo: user.uid)
  //       .orderBy("olusturulma_tarihi", descending: true)
  //       .get();

  //   List<Konusma> tumKonusmalar = [];

  //   for (DocumentSnapshot<Map<String, dynamic>> tekKonusma
  //       in querySnapshot.docs) {
  //     Konusma _tekKonusma =
  //         Konusma.fromMap(tekKonusma.data() as Map<String, dynamic>);
  //     tumKonusmalar.add(_tekKonusma);
  //   }

  //   for (var oAnkiKonusma in tumKonusmalar) {
  //     var userListesindekiKullanici =
  //         listedeUserBul(oAnkiKonusma.kimle_konusuyor!);

  //     if (userListesindekiKullanici != null) {
  //       debugPrint("Veriler local cache' den getirildi.");
  //       oAnkiKonusma.konusulanUsername = userListesindekiKullanici["username"];
  //       oAnkiKonusma.konusulanUserProfilURL =
  //           userListesindekiKullanici["profile_picture"];
  //     } else {
  //       debugPrint(
  //           "Aranlılan kullanıcı daha önceden veri tabanından getirilmemiştir. O yüzden veritabanından bu değeri okumalıyız.");
  //     }

  //     timeagoHesapla(oAnkiKonusma, zaman);
  //   }
  //   return tumKonusmalar;
  // }

  Map? listedeUserBul(String userID) {
    for (var i = 0; i < tumKullanicilar!.length; i++) {
      if (tumKullanicilar![i]["user_id"] == userID) {
        return tumKullanicilar![i];
      }
    }
    return null;
  }

  Future<Null> _konusmalarimListesiniYenile() async {
    Future.delayed(Duration(seconds: 1));
    setState(() {});

    return null;
  }

  Future<Null> _kullanicilarListesiniGuncelle() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  Future<DateTime> saatiGoster(String userID) async {
    await FirebaseFirestore.instance.collection("server").doc(userID).set(
      {
        "saat": FieldValue.serverTimestamp(),
      },
    );

    var okunanMap =
        await FirebaseFirestore.instance.collection("server").doc(userID).get();
    Timestamp okunanTarih = okunanMap.data()!["saat"];

    return okunanTarih.toDate();
  }

  // void timeagoHesapla(Konusma oAnkiKonusma, DateTime zaman) {
  //   oAnkiKonusma.sonOkunmaZamani = zaman;
  //   timeago.setLocaleMessages("tr", timeago.TrShortMessages());

  //   var duration = zaman.difference(oAnkiKonusma.olusturulma_tarihi!.toDate());
  //   oAnkiKonusma.aradakiFark =
  //       timeago.format(zaman.subtract(duration), locale: "tr");
  // }
}
