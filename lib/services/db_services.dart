import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class DbServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  User? user = FirebaseAuth.instance.currentUser;
  MyUser? myUser;

  Future<void> addUser({MyUser? myUser}) async {
    var registeredEmailUser;

    registeredEmailUser = await registeredEmailCheck(email: myUser?.email);

    log(registeredEmailUser.toString());

    return createUser(email: myUser?.email, password: myUser?.password)
        .then((value) => users.doc(value).set({
              'email': myUser?.email,
              'name': myUser?.name,
              'surname': myUser?.surname,
              'country': myUser?.country,
              'phone': myUser?.phone,
              'wait_company': myUser?.waitCompany ?? "",
              'company': myUser?.company ?? "",
              'position': myUser?.position ?? "",
              'profile_photo': myUser?.profilePhoto ?? "",
            }))
        .catchError((error) => log("Failed to add user: $error"));
  }

  Future<bool> registeredEmailCheck({String? email}) async {
    var qs = await users.where("email", isEqualTo: email).get();

    if (qs.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addCompany({Company? company}) {
    return companies
        .doc(user?.uid)
        .set({
          'name': company?.name,
          'website': company?.website ?? "",
          'company_sector': company?.sector,
          'country': company?.country,
          'city': company?.city,
          'email': company?.email,
          'phone': company?.phone,
          'worker_count': company?.workerCount,
          'description': company?.description,
          'year_of_establishment': company?.yearOfEstablishment,
          'network': company?.network,
          'owner_id': company?.ownerId,
          'products': [],
          'wait_workers': [],
          'workers': [],
          'sector': company?.sector,
          'logo': company?.companyLogo,
        })
        .then((value) => users.doc(user?.uid).update({
              'company': user?.uid,
            }))
        .catchError((error) => log("Failed to add company: $error"));
  }

  Future<String> createUser({String? email, String? password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Şifreniz yeterince güçlü değil.';
      } else if (e.code == 'email-already-in-use') {
        return 'E-posta adresi kullanılmaktadır.';
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
    return "Bir hata oluştu.";
  }

  Future<String?> currentUser() async {
    if (user != null) {
      String uid = user!.uid;
      return uid;
    }
    return null;
  }

  Future<MyUser?> getUser({String? userId}) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    myUser = MyUser(
      email: ds['email'],
      name: ds['name'],
      surname: ds['surname'],
      country: ds['country'],
      phone: ds['phone'],
      company: ds["company"] ?? "",
      position: ds["position"],
      profilePhoto: ds["profile_photo"],
      waitCompany: ds["wait_company"],
    );

    return myUser;
  }

  Future<Company> getCompany() async {
    Company myCompany;

    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('companies')
        .doc(user?.uid)
        .get();

    MyUser? owner = await getUser(userId: ds["owner_id"]);

    myCompany = Company(
      name: ds['name'],
      city: ds['city'],
      country: ds['country'],
      description: ds['description'],
      email: ds['email'],
      network: ds['network'],
      owner: owner,
      phone: ds['phone'],
      sector: ds['sector'],
      workerCount: ds['worker_count'],
      yearOfEstablishment: ds['year_of_establishment'],
      website: ds['website'] ?? "",
      companyLogo: ds['logo'] ?? "",
      products: ds['products'] == [] ? [] : ds['products'],
      waitWorkers: ds['wait_workers'] == [] ? [] : ds['wait_workers'],
      workers: ds['workers'] == [] ? [] : ds['workers'],
    );

    return myCompany;
  }

  Future<bool> registeredCompanyCheck() async {
    log(user!.uid.toString());
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();

    if (ds["company"] == "") {
      return false;
    } else {
      return true;
    }

    // Company myCompany;

    // DocumentSnapshot ds = await FirebaseFirestore.instance
    //     .collection('companies')
    //     .doc(user?.uid)
    //     .get();

    // MyUser? owner = await getUser(userId: ds["owner_id"]);

    // myCompany = Company(
    //   name: ds['name'],
    //   city: ds['city'],
    //   country: ds['country'],
    //   description: ds['description'],
    //   email: ds['email'],
    //   network: ds['network'],
    //   owner: owner,
    //   phone: ds['phone'],
    //   sector: ds['sector'],
    //   workerCount: ds['worker_count'],
    //   yearOfEstablishment: ds['year_of_establishment'],
    //   website: ds['website'] ?? "",
    //   companyLogo: ds['logo'] ?? "",
    //   products: ds['products'] == [] ? [] : ds['products'],
    //   waitWorkers: ds['wait_workers'] == [] ? [] : ds['wait_workers'],
    //   workers: ds['workers'] == [] ? [] : ds['workers'],
    // );

    // return myCompany;
  }

  Future<void> addProduct({Product? product}) {
    return products
        .add({
          'name': product?.name,
          'description': product?.description,
          'photo': product?.photo ?? "",
          "company_id": user?.uid
        })
        .then((value) => addProductCompanyUpdate())
        .catchError((error) => log("Failed to add product: $error"));
  }

  Future<List<Product>> getProduct() async {
    var qs = await products.where("company_id", isEqualTo: user!.uid).get();

    Product product;

    List<Product> productsList = [];
    for (var element in qs.docs) {
      product = Product(
          name: element.get("name"),
          description: element.get("description"),
          photo: element.get("photo") ?? "");
      productsList.add(product);
    }

    return productsList;
  }

  Future<List<Company>> searchCompany({String? keyword}) async {
    var qs = await companies.where("name", isLessThan: keyword).get();

    Company company;

    List<Company> companyList = [];

    if (qs.docs.isNotEmpty) {
      for (var element in qs.docs) {
        company = Company(
          yearOfEstablishment: element.get("year_of_establishment"),
          phone: element.get("phone"),
          city: element.get("city"),
          name: element.get("name"),
          sector: element.get("sector"),
          country: element.get("country"),
          description: element.get("description"),
          email: element.get("email"),
          companyLogo: element.get("logo") ?? "",
          network: element.get("network"),
          ownerId: element.get("owner_id"),
          products: element.get("products"),
          website: element.get("website"),
          workerCount: element.get("worker_count"),
          workers: element.get("workers"),
        );
        companyList.add(company);
      }
    } else {
      return [];
    }

    return companyList;
  }

  Future<void> deleteProduct(int index) async {
    var productId;

    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('companies')
        .doc(user?.uid)
        .get();

    productId = ds['products'][index];

    await FirebaseFirestore.instance
        .collection('companies')
        .doc(user?.uid)
        .update({
      "products": FieldValue.arrayRemove([productId])
    });

    await products.doc(productId).delete();

    log("Ürün silme işlemi başarılı");
  }

  Future<void> addProductCompanyUpdate() async {
    var qs = await products.where("company_id", isEqualTo: user!.uid).get();

    List<String> productsList = [];
    for (var element in qs.docs) {
      log(element.id);
      productsList.add(element.id);
    }

    return companies
        .doc(user!.uid)
        .update({"products": productsList})
        .then((value) => log("Company in Producs updated"))
        .catchError((onError) => log("Failed to update Company in Products"));
  }

  Future<String> uploadFile({File? image}) async {
    if (image == null) return "";
    final fileName = basename(image.path);
    final destination = 'products/${user?.uid}';

    try {
      final referance = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(fileName);
      await referance.putFile(image);
      return await referance.getDownloadURL();
    } catch (e) {
      log('error occured');
    }
    return "";
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
  }
}
