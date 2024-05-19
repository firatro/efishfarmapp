import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class EditCompanyPage extends ConsumerStatefulWidget {
  const EditCompanyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCompanyPageState();
}

class _EditCompanyPageState extends ConsumerState<EditCompanyPage> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyWebsiteController = TextEditingController();
  TextEditingController companySectorController = TextEditingController();
  TextEditingController companyCountryController = TextEditingController();
  TextEditingController companyCityController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController companyPersonCountController = TextEditingController();
  TextEditingController companyYearOfEstablishmentController =
      TextEditingController();
  TextEditingController companyNetworkController = TextEditingController();
  String? companySector;
  String? companyWorkerCount;
  String? companyCountry;
  String? companyNetwork;
  final _formKey = GlobalKey<FormState>();
  var image;

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
        title: const Text("Şirket Bilgilerini Düzenle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Company>(
                future: ref.read(farmRiverpod).getCompany(),
                builder: (BuildContext context, snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Bilgileri Düzenleyin",
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.file(
                                              ref.read(farmRiverpod).image!),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "btn1",
                                      backgroundColor: AppColors.grey,
                                      onPressed: () async {
                                        ref.read(farmRiverpod).image = await ref
                                            .read(farmRiverpod)
                                            .pickImage();
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
                                        ref.read(farmRiverpod).image = await ref
                                            .read(farmRiverpod)
                                            .pickImageC();
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
                                      return "Şirket adı giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyNameController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.name,
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
                                      return "Site adresi giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyWebsiteController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.website,
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
                                      return "E-posta adresi giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyEmailController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.email,
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
                                      return "Telefon giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyPhoneController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.phone,
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
                                      return "Şirket bilgisi giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyDescriptionController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  maxLines: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.description,
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
                                  value: companyNetwork,
                                  hint: Text(
                                    snapshot.data!.network,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  onChanged: (value) =>
                                      setState(() => companyNetwork = value),
                                  validator: (value) =>
                                      value == null ? 'Seçim yapınız' : null,
                                  items: companyNetworkList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                                  value: companySector,
                                  hint: Text(
                                    snapshot.data!.sector,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  onChanged: (value) =>
                                      setState(() => companySector = value),
                                  validator: (value) => value == null
                                      ? 'İş sektörünü seçiniz'
                                      : null,
                                  items: companySectorList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                                  value: companyCountry,
                                  hint: Text(
                                    snapshot.data!.country,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  onChanged: (value) =>
                                      setState(() => companyCountry = value),
                                  validator: (value) =>
                                      value == null ? 'Seçim yapınız' : null,
                                  items: companyCountryList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                                    if (value == null || value.isEmpty) {
                                      return "Şirketin bağlı olduğu şehri giriniz";
                                    }
                                    return null;
                                  },
                                  controller: companyCityController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.black),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText: snapshot.data!.city,
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
                                  value: companyWorkerCount,
                                  hint: Text(
                                    snapshot.data!.workerCount,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                                  onChanged: (value) => setState(
                                      () => companyWorkerCount = value),
                                  validator: (value) =>
                                      value == null ? 'Seçim yapınız' : null,
                                  items: companyWorkerCountList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                                        value.length != 4) {
                                      return "Kuruluş yılı giriniz";
                                    }
                                    return null;
                                  },
                                  controller:
                                      companyYearOfEstablishmentController,
                                  cursorColor: AppColors.lightBlue,
                                  cursorWidth: 3,
                                  style: TextStyle(color: AppColors.black),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: AppColors.grey),
                                    filled: true,
                                    fillColor: AppColors.grey.withOpacity(0.3),
                                    hintText:
                                        snapshot.data!.yearOfEstablishment,
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
                                      ref.read(registerRiverpod).newCompany =
                                          Company(
                                        companyLogo: await ref
                                            .read(farmRiverpod)
                                            .uploadFile(),
                                        city: companyCityController
                                                    .text.isEmpty ==
                                                true
                                            ? snapshot.data!.city
                                            : companyCityController.text,
                                        country: companyCountry ??
                                            snapshot.data!.country,
                                        description:
                                            companyDescriptionController
                                                        .text.isEmpty ==
                                                    true
                                                ? snapshot.data!.description
                                                : companyDescriptionController
                                                    .text,
                                        email: companyEmailController
                                                    .text.isEmpty ==
                                                true
                                            ? snapshot.data!.email
                                            : companyEmailController.text,
                                        name: companyNameController
                                                    .text.isEmpty ==
                                                true
                                            ? snapshot.data!.name
                                            : companyNameController.text,
                                        network: companyNetwork ??
                                            snapshot.data!.network,
                                        workerCount: companyWorkerCount ??
                                            snapshot.data!.workerCount,
                                        phone: companyPhoneController
                                                    .text.isEmpty ==
                                                true
                                            ? snapshot.data!.phone
                                            : companyPhoneController.text,
                                        sector: companySector ??
                                            snapshot.data!.sector,
                                        yearOfEstablishment:
                                            companyYearOfEstablishmentController
                                                        .text.isEmpty ==
                                                    true
                                                ? snapshot
                                                    .data!.yearOfEstablishment
                                                : companyYearOfEstablishmentController
                                                    .text,
                                        website: companyWebsiteController
                                                    .text.isEmpty ==
                                                true
                                            ? snapshot.data!.website
                                            : companyWebsiteController.text,
                                        ownerId: await ref
                                            .read(registerRiverpod)
                                            .getCurrentUserId(),
                                      );
                                      ref
                                          .read(registerRiverpod)
                                          .updateCompany();
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
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      //data hatası
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
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
                }),
          ],
        ),
      ),
    );
  }
}

const List<String> companyCountryList = <String>[
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

const List<String> companySectorList = <String>[
  "Balık",
];

const List<String> companyWorkerCountList = <String>[
  "1 - 100 arası",
  "100 - 500 arası",
  "500 - 1000 arası",
  "1000 - 10000 arası"
];

const List<String> companyNetworkList = <String>[
  "Uluslararası",
  "Yerel",
];
