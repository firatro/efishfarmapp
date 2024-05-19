import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/farm_pages/add_product_page.dart';
import 'package:efishfarmapp/views/farm_pages/edit_company_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class WaitCompanyWorkersPage extends ConsumerStatefulWidget {
  const WaitCompanyWorkersPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WaitCompanyWorkersPageState();
}

class _WaitCompanyWorkersPageState extends ConsumerState<WaitCompanyWorkersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bekleyen Talepler"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                     FutureBuilder<MyUser?>(
                        future: ref
                            .read(registerRiverpod)
                            .getUser(), // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<MyUser?> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Column(
                                children: [
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return  ListTile(
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
                                      setState(() {
                                        
                                      });
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
                            leading: 
                            snapshot.data!.profilePhoto! != null ?
                            
                            SizedBox(
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Icon(Icons.person),
                              ),
                            ) : SizedBox(
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Image.network(snapshot.data!.profilePhoto!),
                              ),
                            ) ,
                            title: Text(
                              snapshot.data!.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                    snapshot.data!.email,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          );   },
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
                                    onPressed: () {    },
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
            )
          ],
        ),
      ),
    );
  }
}
