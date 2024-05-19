import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/existing_company_page.dart';
import 'package:efishfarmapp/views/auth_pages/new_company_page.dart';
import 'package:efishfarmapp/views/other_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

const List<String> countryList = <String>[
  "ABD",
  "ABD Virjin Adaları (ABD)",
  "Abhazya",
  "Afganistan",
  "Åland (Finlandiya)",
  "Almanya",
  "Amerikan Samoası (ABD)",
  "Andorra",
  "Angola",
  "Anguilla (Birleşik Krallık)",
  "Antigua ve Barbuda",
  "Arjantin",
  "Arnavutluk",
  "Aruba (Hollanda)",
  "Avustralya",
  "Avusturya",
  "Azerbaycan",
  "Bahamalar",
  "Bahreyn",
  "Bangladeş",
  "Barbados",
  "Batı Sahra",
  "Belarus",
  "Belçika",
  "Belize",
  "Benin",
  "Bermuda (Birleşik Krallık)",
  "Bhutan",
  "Birleşik Arap Emirlikleri",
  "Birleşik Krallık",
  "Bolivya",
  "Bosna-Hersek",
  "Botsvana",
  "Brezilya",
  "Britanya Virjin Adaları (Birleşik Krallık)",
  "Brunei",
  "Bulgaristan",
  "Burkina Faso",
  "Burundi",
  "Cayman Adaları (Birleşik Krallık)",
  "Cebelitarık (Birleşik Krallık)",
  "Cezayir",
  "Christmas Adası (Avustralya)",
  "Cibuti",
  "Cocos Adaları (Avustralya)",
  "Cook Adaları",
  "Curaçao (Hollanda)",
  "Çad",
  "Çekya",
  "Çin",
  "Danimarka",
  "Doğu Timor",
  "Dominik Cumhuriyeti",
  "Dominika",
  "Ekvador",
  "Ekvator Ginesi",
  "El Salvador",
  "Endonezya",
  "Eritre",
  "Ermenistan",
  "Estonya",
  "Esvatini",
  "Etiyopya",
  "Falkland Adaları (Birleşik Krallık)",
  "Faroe Adaları (Danimarka)",
  "Fas",
  "Fiji",
  "Fildişi Sahili",
  "Filipinler",
  "Filistin",
  "Finlandiya",
  "Fransa",
  "Fransız Polinezyası (Fransa)",
  "Gabon",
  "Gambiya",
  "Gana",
  "Gine",
  "Gine-Bissau",
  "Grenada",
  "Grönland (Danimarka)",
  "Guam (ABD)",
  "Guatemala",
  "Guernsey (Birleşik Krallık)",
  "Guyana",
  "Güney Afrika",
  "Güney Kore",
  "Güney Osetya",
  "Güney Sudan",
  "Gürcistan",
  "Haiti",
  "Hırvatistan",
  "Hindistan",
  "Hollanda",
  "Honduras",
  "Hong Kong (Çin)",
  "Irak",
  "İran",
  "İrlanda",
  "İspanya",
  "İsrail",
  "İsveç",
  "İsviçre",
  "İtalya",
  "İzlanda",
  "Jamaika",
  "Japonya",
  "Jersey (Birleşik Krallık)",
  "Kamboçya",
  "Kamerun",
  "Kanada",
  "Karadağ",
  "Katar",
  "Kazakistan",
  "Kenya",
  "Kıbrıs Cumhuriyeti",
  "Kırgızistan",
  "Kiribati",
  "Kolombiya",
  "Komorlar",
  "Kongo Cumhuriyeti",
  "Kongo DC",
  "Kosova",
  "Kosta Rika",
  "Kuveyt",
  "Kuzey Kıbrıs",
  "Kuzey Kore",
  "Kuzey Makedonya",
  "Kuzey Mariana Adaları (ABD)",
  "Küba",
  "Laos",
  "Lesotho",
  "Letonya",
  "Liberya",
  "Libya",
  "Lihtenştayn",
  "Litvanya",
  "Lübnan",
  "Lüksemburg",
  "Macaristan",
  "Madagaskar",
  "Makao (Çin)",
  "Malavi",
  "Maldivler",
  "Malezya",
  "Mali",
  "Malta",
  "Man Adası (Birleşik Krallık)",
  "Marshall Adaları",
  "Mauritius",
  "Meksika",
  "Mısır",
  "Mikronezya Federal Devletleri",
  "Moğolistan",
  "Moldova",
  "Monako",
  "Montserrat (Birleşik Krallık)",
  "Moritanya",
  "Mozambik",
  "Myanmar",
  "Namibya",
  "Nauru",
  "Nepal",
  "Nijer",
  "Nijerya",
  "Nikaragua",
  "Niue",
  "Norfolk Adası (Avustralya)",
  "Norveç",
  "Orta Afrika Cumhuriyeti",
  "Özbekistan",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua Yeni Gine",
  "Paraguay",
  "Peru",
  "Pitcairn Adaları (Birleşik Krallık)",
  "Polonya",
  "Portekiz",
  "Porto Riko (ABD)",
  "Romanya",
  "Ruanda",
  "Rusya",
  "Saint Barthélemy (Fransa)",
  "Saint Helena, Ascension ve Tristan da Cunha (Birleşik Krallık)",
  "Saint Kitts ve Nevis",
  "Saint Lucia",
  "Saint Martin (Fransa) (Fransa)",
  "Saint Pierre ve Miquelon (Fransa)",
  "Saint Vincent ve Grenadinler",
  "Samoa",
  "San Marino",
  "São Tomé ve Príncipe",
  "Senegal",
  "Seyşeller",
  "Sırbistan",
  "Sierra Leone",
  "Singapur",
  "Sint Maarten (Hollanda)",
  "Slovakya",
  "Slovenya",
  "Solomon Adaları",
  "Somali",
  "Sri Lanka",
  "Sudan",
  "Surinam",
  "Suriye",
  "Suudi Arabistan",
  "Şili",
  "Tacikistan",
  "Tanzanya",
  "Tayland",
  "Tayvan",
  "Togo",
  "Tokelau (Yeni Zelanda)",
  "Tonga",
  "Transdinyester",
  "Trinidad ve Tobago",
  "Tunus",
  "Turks ve Caicos Adaları (Birleşik Krallık)",
  "Tuvalu",
  "Türkiye",
  "Türkmenistan",
  "Uganda",
  "Ukrayna",
  "Umman",
  "Uruguay",
  "Ürdün",
  "Vanuatu",
  "Vatikan",
  "Venezuela",
  "Vietnam",
  "Wallis ve Futuna (Fransa)",
  "Yemen",
  "Yeni Kaledonya (Fransa)",
  "Yeni Zelanda",
  "Yeşil Burun Adaları",
  "Yunanistan",
  "Zambiya",
  "Zimbabve"
];
const List<String> orgList = <String>[
  'Şirket Oluştur',
  'Mevcut Şirkete Katıl',
  'Şirket Sahibi veya Üyesi Değilim',
];
const List<String> positionList = <String>[
  "SERBEST KULLANICI",
  "MÜHENDİS",
  "BALIKÇI",
  "KAPTAN",
  "TEDARİKÇİ",
  "YETKİLİ",
  "ÇİFTLİK SAHİBİ",
];

class _RegisterPageState extends ConsumerState<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController orgController = TextEditingController();
  String? country;
  String? orgChoise;
  String? positionChoise;
  String newCompanyChoise = "Şirket Oluştur";
  String existingCompanyChoise = "Mevcut Şirkete Katıl";
  final _formKey = GlobalKey<FormState>();
  bool emailValidate = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColors.lightBlue,
            height: 4.0,
          ),
        ),
        centerTitle: true,
        title: const Text("Kayıt Ol"),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Bilgilerinizi Giriniz",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.contains("@") == false) {
                        return "Lütfen geçerli bir e-posta giriniz";
                      }
                      return null;
                    },
                    controller: emailController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    onChanged: (String value) {},
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "E-Posta adresiniz",
                      prefixIcon: Icon(Icons.mail, color: AppColors.grey),
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
                      if (value == null || value.isEmpty || value.length < 6) {
                        return "Şifreniz 6 haneden az olamaz";
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    onChanged: (String value) {},
                    style: TextStyle(color: AppColors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Şifreniz",
                      prefixIcon: Icon(Icons.lock, color: AppColors.grey),
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
                      if (value == null ||
                          value.isEmpty ||
                          passwordController.text != passwordConfirm.text) {
                        return "Şifreler uyuşmuyor";
                      }
                      return null;
                    },
                    controller: passwordConfirm,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    onChanged: (String value) {},
                    style: TextStyle(color: AppColors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Tekrar Şifreniz",
                      prefixIcon: Icon(Icons.lock, color: AppColors.grey),
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
                        return "Adınızı giriniz";
                      }
                      return null;
                    },
                    controller: nameController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Adınız",
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
                        return "Soyadınızı giriniz";
                      }
                      return null;
                    },
                    controller: surnameController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Soyadınız",
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
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      fillColor: AppColors.grey.withOpacity(0.3),
                      filled: true,
                    ),
                    iconEnabledColor: AppColors.grey,
                    dropdownColor: AppColors.white,
                    value: country,
                    hint: Text(
                      'Ülke seçiniz',
                      style: TextStyle(color: AppColors.grey),
                    ),
                    onChanged: (value) => setState(() => country = value),
                    validator: (value) =>
                        value == null ? 'Ülkenizi seçiniz' : null,
                    items: countryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 11) {
                        return "Geçerli bir telefon numarası giriniz";
                      }
                      return null;
                    },
                    controller: phoneController,
                    cursorColor: AppColors.lightBlue,
                    cursorWidth: 3,
                    style: TextStyle(color: AppColors.black),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: AppColors.grey),
                      hintStyle: TextStyle(color: AppColors.grey),
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.3),
                      hintText: "Telefon (0XXX)",
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
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      fillColor: AppColors.grey.withOpacity(0.3),
                      filled: true,
                    ),
                    iconEnabledColor: AppColors.grey,
                    dropdownColor: AppColors.white,
                    value: positionChoise,
                    hint: Text(
                      'Pozisyonunuzu Seçiniz',
                      style: TextStyle(color: AppColors.grey),
                    ),
                    onChanged: (value) =>
                        setState(() => positionChoise = value),
                    validator: (value) =>
                        value == null ? 'Pozisyon seçimi yapınız' : null,
                    items: positionList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        "Organizasyon Yapısı",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      fillColor: AppColors.grey.withOpacity(0.3),
                      filled: true,
                    ),
                    iconEnabledColor: AppColors.grey,
                    dropdownColor: AppColors.white,
                    value: orgChoise,
                    hint: Text(
                      'Seçiniz',
                      style: TextStyle(color: AppColors.grey),
                    ),
                    onChanged: (value) => setState(() => orgChoise = value),
                    validator: (value) =>
                        value == null ? 'Organizasyon seçimi yapınız' : null,
                    items:
                        orgList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kayıt olduğunuzda E-Fish Farm kullanım koşullarını kabul etmiş olursunuz.",
                    style: TextStyle(
                      fontSize: 11,
                      height: 1,
                      wordSpacing: 0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await ref
                            .read(registerRiverpod)
                            .dbServices
                            .registeredEmailCheck(
                                email: emailController.text)) {
                          Grock.toast(
                            text: "Bu e-posta adresi kullanılmaktadır.",
                            backgroundColor: AppColors.red,
                          );
                        } else {
                          if (_formKey.currentState!.validate()) {
                            ref.read(registerRiverpod).newUser = MyUser(
                              email: emailController.text,
                              name: nameController.text,
                              surname: surnameController.text,
                              country: country!,
                              phone: phoneController.text,
                              password: passwordController.text,
                              company: "",
                              position: positionChoise ?? "SERBEST KULLANICI",
                              profilePhoto: "",
                              waitCompany: "",
                            );
                            ref.read(registerRiverpod).addUser();
                            log(orgChoise.toString());
                            log(newCompanyChoise.toString());
                            if (orgChoise.toString() == newCompanyChoise.toString()) {
                              Grock.toRemove(const NewCompanyPage());
                            }
                            if (orgChoise.toString() == existingCompanyChoise.toString()) {
                              Grock.toRemove(const ExistingCompanyPage());
                            } else {
                              Grock.toRemove(const LandingPage());
                            }
                          } else {
                            Grock.toast(
                              text: "Bilgileri kontrol ediniz",
                              backgroundColor: AppColors.red,
                            );
                          }
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
                        "DEVAM ET",
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
