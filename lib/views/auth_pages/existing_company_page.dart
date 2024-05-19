import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/position_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExistingCompanyPage extends ConsumerStatefulWidget {
  const ExistingCompanyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExistingCompanyPagePageState();
}

const List<String> list = <String>['Ülke', 'Two', 'Three', 'Four'];
const List<String> orgList = <String>[
  'Seçiniz',
  'Şirket Oluştur',
  'Mevcut Şirkete Katıl',
];

class _ExistingCompanyPagePageState extends ConsumerState<ExistingCompanyPage> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    searchResultList();
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection("companies")
        .orderBy("name")
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResults) {
        var name = clientSnapShot['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultList = showResults;
    });
  }

  String dropdownValue = list.first;
  TextEditingController searchCompanyController = TextEditingController();
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
        title: Text("Mevcut Şirket Bilgileri"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.875,
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Şirketinizi seçin",
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
                  CupertinoSearchTextField(
                    controller: _searchController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _resultList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                titleTextStyle: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                contentTextStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                                backgroundColor: AppColors.lightGrey,
                                title: const Text('Emin misiniz?'),
                                content: const Text(
                                    'Doğru şirketi seçtiğinziden emin misiniz?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('İptal',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      log(_resultList[index].id.toString());
                                      ref
                                              .read(registerRiverpod)
                                              .newUser!
                                              .waitCompany =
                                          _resultList[index].id.toString();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PositionPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Evet, eminim',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            leading: SizedBox(
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Image.network(_resultList[index]["logo"]),
                              ),
                            ),
                            title: Text(
                              _resultList[index]["name"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              _resultList[index]["email"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
