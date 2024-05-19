import 'package:efishfarmapp/models/product_model.dart';
import 'package:efishfarmapp/models/user_model.dart';

class Company {
  String name;
  String sector;
  String? website;
  String country;
  String city;
  String email;
  String phone;
  String description;
  String workerCount;
  String yearOfEstablishment;
  String network;
  List<dynamic>? products;
  List<dynamic>? waitWorkers;
  List<dynamic>? workers;
  MyUser? owner;
  String? ownerId;
  String? companyLogo;

  Company({
    required this.name,
    required this.sector,
    this.website,
    required this.country,
    required this.city,
    required this.email,
    required this.phone,
    required this.description,
    required this.workerCount,
    required this.yearOfEstablishment,
    required this.network,
    this.products,
    this.waitWorkers,
    this.workers,
    this.ownerId,
    this.owner,
    this.companyLogo
  });
}
