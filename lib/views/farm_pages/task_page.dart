import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

// ignore: must_be_immutable
class TaskList extends ConsumerStatefulWidget {
  const TaskList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  bool isChecked = false;
  MyUser? myUser;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    myUser = await ref.read(registerRiverpod).dbServices.getUser();
    setState(() {});
  }

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
                  myUser == null
                      ? ""
                      : "${myUser!.position} ",
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "GÖREVLER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: AppColors.lightBlue,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Sıcaklık Kontrolü"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 30.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBlue, width: 2.0),
                      ),
                      hintText: 'Sıcaklık Giriniz...',
                    ),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: AppColors.lightBlue,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Yemleme"),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: AppColors.lightBlue,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Antibiyotik"),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: AppColors.lightBlue,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Ağ Kontrolü"),
                  ),
                ),
                ListTile(
                  leading: Checkbox(
                    activeColor: AppColors.lightBlue,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Ölü Balık"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 30.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightBlue, width: 2.0),
                      ),
                      hintText: 'Adet Giriniz...',
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "GÜNLÜK RAPOR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 8, //or null
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lightBlue, width: 2.0),
                    ),
                    hintText: 'Günlük Raporunuz...',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Operasyonu bitirmek için görevleri tamamlayınız.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Grock.toast(
                          text:
                              "Operasyonu bitirmek için görevleri tamamlayınız.",
                          backgroundColor: Color(0xFFDA0037));
                    },
                    child: Text(
                      "TAMAMLANDI",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
