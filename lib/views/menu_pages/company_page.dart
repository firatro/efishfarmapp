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

class CompanyPage extends ConsumerStatefulWidget {
  CompanyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompanyPageState();
}

class _CompanyPageState extends ConsumerState<CompanyPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: 50,
          child: AppAssets.appLogo,
        ),
        actions: [
          Container(
            height: 40,
            width: 100,
            decoration: const BoxDecoration(
                color: Color(0xff074173),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            child: const Center(
              child: Text(
                "Şirketler",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 25)
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/app_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              // ignore: unrelated_type_equality_checks
              color: ref.read(appRiverpod).isDarkMode == true
                  ? AppColors.black
                  : AppColors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Bir teklif bulun veya bağlantı kurun",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
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
                      )
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
