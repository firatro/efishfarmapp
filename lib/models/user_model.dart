class MyUser {
  String? id;
  String email;
  String name;
  String surname;
  String country;
  String phone;
  String? password;
  String? waitCompany;
  String? company;
  String? position;
  String? profilePhoto;

  MyUser({
    this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.country,
    required this.phone,
    this.password,
    this.waitCompany,
    this.company,
    this.position,
    this.profilePhoto,
  });
}
