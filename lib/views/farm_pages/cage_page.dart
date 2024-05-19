import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

// ignore: must_be_immutable
class Cage extends StatefulWidget {
  Cage({
    super.key,
  });

  @override
  State<Cage> createState() => _CageState();
}

const List<String> list = <String>[
  'Sürmene Çamburnu Sistemi',
  '... Sistemi',
  '... Sistemi',
  '... Sistemi'
];

const List<Widget> fruits = <Widget>[
  Text('1'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5'),
  Text('6'),
  Text('7'),
];

class _CageState extends State<Cage> {
  bool isChecked = false;
  String dropdownValue = list.first;
  final List<bool> _selectedFruits = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false
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
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width * 0.8,
                      initialSelection: list.first,
                      trailingIcon: Icon(
                        Icons.menu_open_sharp,
                        color: AppColors.white,
                      ),
                      textStyle: TextStyle(
                        color: AppColors.white,
                      ),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
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
                              "Ort. Balık Sayısı",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("150.000")),
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
                              "Ort. Balık Ağırlığı",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("3.43 kg")),
                          ),ListTile(
                            leading: Text(
                              "Hasat Zamanı",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Align(
                                alignment: Alignment.centerRight,
                                child: Text("11.11.2023")),
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
