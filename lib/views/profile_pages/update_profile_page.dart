import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/views/auth_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
   TextEditingController? epostaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                right: 20.0, left: 20.0, top: size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                Container(
                  height: 50.0,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color(0xFF13139E),
                  ),
                  child: Center(
                    child: Text(
                      "Güncelle",
                      // style: AppTextStyles.loginButtonTextStyle2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0), color: Colors.white),
        child: SizedBox(
          height: size.height * 0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bilgilerinizi güncelleyin",
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 3,
                        controller: epostaController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(),
                          hintText: "E-posta",
                        ),
                        onChanged: (String? value) {
                          epostaController!.text = value!;
                          debugPrint(epostaController!.text);
                        },
                        validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                      SizedBox(height: 10),
                      // DropdownMenu<String>(
                      //   initialSelection: "Seçin",
                      //   width: size.width * 0.9,
                      //   leadingIcon: Icon(Icons.dashboard_customize_rounded),
                      //   onSelected: (String? value) {
                      //     // This is called when the user selects an item.
                      //     // setState(() {
                      //     //   dropdownValue = value!;
                      //     // });
                      //   },
                      //   dropdownMenuEntries:
                      //       list.map<DropdownMenuEntry<String>>((String value) {
                      //     return DropdownMenuEntry<String>(
                      //         value: value, label: value);
                      //   }).toList(),
                      // ),
                      SizedBox(height: 10),
                      DropdownMenu<String>(
                        initialSelection: "Türkiye",
                        width: size.width * 0.9,
                        menuHeight: size.height * 0.4,
                        leadingIcon: Icon(Icons.location_city),
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          // setState(() {
                          //   dropdownValueUlke = value!;
                          // });
                        },
                        dropdownMenuEntries: listUlke
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: size.width * 0.9,
          child: FloatingActionButton(
            backgroundColor: AppColors.blue,
            onPressed: () {
              if (epostaController!.text == "") {
                // epostaController!.text = widget.eposta;
                setState(() {});
              }
              // if (dropdownValueUlke == "Ülke Seçiniz") {
              //   // dropdownValueUlke = widget.ulke;
              //   setState(() {});
              // }
              profilGuncelle();

              _showMyDialog();
            },
            child: Text(
              "Kaydet",
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headlineSmall,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  cikisYap() async {
    debugPrint("Çıkış Yap Tıklandı");

    await FirebaseAuth.instance.signOut();
    setState(() {});
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uyarı'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bilgileriniz kayıt edilmiştir'),
                Text('Güncellenmesi için yeniden oturum açınız'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                cikisYap();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> mailExists(String email) async =>
      // ignore: prefer_is_empty
      (await FirebaseFirestore.instance
              .collection("users")
              .where("email", isEqualTo: email)
              .get())
          .docs
          .length >
      0;
  void profilGuncelle() async {
    debugPrint(epostaController!.text);


    // bool mailVarMi = await mailExists(epostaController!.text);
    // if (mailVarMi == true) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('E-posta adresi kullanılmaktadır'),
    //   ));
    // } else
    // if (!epostaController!.text.contains("@")) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Geçerli bir e-posta adresi giriniz'),
    //   ));
    // } else if (dropdownValue == "Profil Türü") {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Profil türü seçiniz'),
    //   ));
    // } else if (dropdownValueUlke == "Ülke Seçiniz") {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Ülke seçiniz'),
    //   ));
    // } else {
    //   DocumentReference users = FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(FirebaseAuth.instance.currentUser!.uid);
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Text('Bilgileriniz güncellenmiştir'),
    //   ));
    //   return users
    //       .update({
    //         'email': epostaController!.text,
    //         'type': dropdownValue,
    //         'ulke': dropdownValueUlke,
    //       })
    //       .then((value) => debugPrint("User updated"))
    //       .catchError((error) => debugPrint("Failed to add user: $error"));
    // }
  }
}

const List<String> listUlke = <String>[
  "Ülke Seçiniz",
  "Afganistan",
  "Almanya",
  "Amerika Birleşik Devletleri",
  "Amerikan Samoa",
  "Andorra",
  "Angola",
  "Anguilla, İngiltere",
  "Antigua ve Barbuda",
  "Arjantin",
  "Arnavutluk",
  "Aruba, Hollanda",
  "Avustralya",
  "Avusturya",
  "Azerbaycan",
  "Bahama Adaları",
  "Bahreyn",
  "Bangladeş",
  "Barbados",
  "Belçika",
  "Belize",
  "Benin",
  "Bermuda, İngiltere",
  "Beyaz Rusya",
  "Bhutan",
  "Birleşik Arap Emirlikleri",
  "Birmanya (Myanmar)",
  "Bolivya",
  "Bosna Hersek",
  "Botswana",
  "Brezilya",
  "Brunei",
  "Bulgaristan",
  "Burkina Faso",
  "Burundi",
  "Cape Verde",
  "Cayman Adaları, İngiltere",
  "Cezayir",
  "Christmas Adası , Avusturalya",
  "Cibuti",
  "Çad",
  "Çek Cumhuriyeti",
  "Çin",
  "Danimarka",
  "Doğu Timor",
  "Dominik Cumhuriyeti",
  "Dominika",
  "Ekvator",
  "Ekvator Ginesi",
  "El Salvador",
  "Endonezya",
  "Eritre",
  "Ermenistan",
  "Estonya",
  "Etiyopya",
  "Fas",
  "Fiji",
  "Fildişi Sahili",
  "Filipinler",
  "Filistin",
  "Finlandiya",
  "Folkland Adaları, İngiltere",
  "Fransa",
  "Fransız Guyanası",
  "Fransız Polinezyası",
  "Gabon",
  "Galler",
  "Gambiya",
  "Gana",
  "Gaza Strip",
  "Gibraltar, İngiltere",
  "Gine",
  "Gine-Bissau",
  "Grenada",
  "Grönland",
  "Guadalup, Fransa",
  "Guam, Amerika",
  "Guatemala",
  "Guyana",
  "Güney Afrika",
  "Güney Kıbrıs Rum Yönetimi",
  "Güney Kore",
  "Gürcistan",
  "Haiti",
  "Havai Adaları",
  "Hırvatistan",
  "Hindistan",
  "Hollanda",
  "Hollanda Antilleri",
  "Honduras",
  "Irak",
  "İngiltere",
  "İran",
  "İrlanda",
  "İskoçya",
  "İspanya",
  "İsrail",
  "İsveç",
  "İsviçre",
  "İtalya",
  "İzlanda",
  "Jamaika",
  "Japonya",
  "Johnston Atoll, Amerika",
  "K.K.T.C.",
  "Kamboçya",
  "Kamerun",
  "Kanada",
  "Kanarya Adaları",
  "Karadağ",
  "Katar",
  "Kazakistan",
  "Kenya",
  "Kırgızistan",
  "Kiribati",
  "Kolombiya",
  "Komorlar",
  "Kongo",
  "Kongo Demokratik Cumhuriyeti",
  "Kosova",
  "Kosta Rika",
  "Kuveyt",
  "Kuzey İrlanda",
  "Kuzey Kore",
  "Kuzey Maryana Adaları",
  "Küba",
  "Laos",
  "Lesotho",
  "Letonya",
  "Liberya",
  "Libya",
  "Liechtenstein",
  "Litvanya",
  "Lübnan",
  "Lüksemburg",
  "Macaristan",
  "Madagaskar",
  "Makau (Makao)",
  "Makedonya",
  "Malavi",
  "Maldiv Adaları",
  "Malezya",
  "Mali",
  "Malta",
  "Marşal Adaları",
  "Martinik, Fransa",
  "Mauritius",
  "Mayotte, Fransa",
  "Meksika",
  "Mısır",
  "Midway Adaları, Amerika",
  "Mikronezya",
  "Moğolistan",
  "Moldavya",
  "Monako",
  "Montserrat",
  "Moritanya",
  "Mozambik",
  "Namibia",
  "Nauru",
  "Nepal",
  "Nijer",
  "Nijerya",
  "Nikaragua",
  "Niue, Yeni Zelanda",
  "Norveç",
  "Orta Afrika Cumhuriyeti",
  "Özbekistan",
  "Pakistan",
  "Palau Adaları",
  "Palmyra Atoll, Amerika",
  "Panama",
  "Papua Yeni Gine",
  "Paraguay",
  "Peru",
  "Polonya",
  "Portekiz",
  "Porto Riko, Amerika",
  "Reunion, Fransa",
  "Romanya",
  "Ruanda",
  "Rusya Federasyonu",
  "Saint Helena, İngiltere",
  "Saint Martin, Fransa",
  "Saint Pierre ve Miquelon, Fransa",
  "Samoa",
  "San Marino",
  "Santa Kitts ve Nevis",
  "Santa Lucia",
  "Santa Vincent ve Grenadinler",
  "Sao Tome ve Principe",
  "Senegal",
  "Seyşeller",
  "Sırbistan",
  "Sierra Leone",
  "Singapur",
  "Slovakya",
  "Slovenya",
  "Solomon Adaları",
  "Somali",
  "Sri Lanka",
  "Sudan",
  "Surinam",
  "Suriye",
  "Suudi Arabistan",
  "Svalbard, Norveç",
  "Svaziland",
  "Şili",
  "Tacikistan",
  "Tanzanya",
  "Tayland",
  "Tayvan",
  "Togo",
  "Tonga",
  "Trinidad ve Tobago",
  "Tunus",
  "Turks ve Caicos Adaları, İngiltere",
  "Tuvalu",
  "Türkiye",
  "Türkmenistan",
  "Uganda",
  "Ukrayna",
  "Umman",
  "Uruguay",
  "Ürdün",
  "Vallis ve Futuna, Fransa",
  "Vanuatu",
  "Venezuela",
  "Vietnam",
  "Virgin Adaları, Amerika",
  "Virgin Adaları, İngiltere",
  "Wake Adaları, Amerika",
  "Yemen",
  "Yeni Kaledonya, Fransa",
  "Yeni Zelanda",
  "Yunanistan",
  "Zambiya",
  "Zimbabve",
];
