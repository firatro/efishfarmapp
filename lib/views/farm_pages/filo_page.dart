import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

// ignore: must_be_immutable
class Filo extends StatefulWidget {
  Filo({
    super.key,
  });

  @override
  State<Filo> createState() => _FiloState();
}

const List<String> list = <String>[
  'Sürmene Çamburnu Sistemi',
  '... Sistemi',
  '... Sistemi',
  '... Sistemi'
];

const List<Widget> fruits = <Widget>[
  Text('TAKA II'),
  Text('ORKA'),
  Text('OMEGA I'),
  Text('OMEGA II'),
  Text('DURSUN'),
];

class _FiloState extends State<Filo> {
  bool isChecked = false;
  String dropdownValue = list.first;
  final List<bool> _selectedFruits = <bool>[
    true,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "TEKNELER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1.8,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ToggleButtons(
                        direction: Axis.vertical,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < _selectedFruits.length; i++) {
                              _selectedFruits[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.blue[700],
                        selectedColor: AppColors.white,
                        fillColor: AppColors.lightBlue.withOpacity(0.5),
                        color: AppColors.black.withOpacity(0.7),
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: _selectedFruits,
                        children: fruits,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text(
                              "Boyut",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("200 gt")),
                          ),
                          ListTile(
                            leading: Text(
                              "Uzunluk",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("20 mt")),
                          ),
                          ListTile(
                            leading: Text(
                              "Görev",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Hasat")),
                          ),
                          ListTile(
                            leading: Text(
                              "Ort. Balık Boyutu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("0.74 cm")),
                          ),
                          ListTile(
                            leading: Text(
                              "Sorumlu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("Ad Soyad")),
                          ),
                          ListTile(
                            leading: Text(
                              "Ekipmanlar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Tıklayınız",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightBlue),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              "Konum Bilgisi",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Tıklayınız",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightBlue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
