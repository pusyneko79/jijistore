class UserProfileModel {
  int? age;
  String? address;
  String? email;
  String? phone;
  int? id;
  String? password;
  String? name;
  String? img;

  UserProfileModel(
      {this.age,
      this.address,
      this.email,
      this.phone,
      this.id,
      this.password,
      this.name,
      this.img});

  UserProfileModel.fromJson(Map<dynamic, dynamic> json) {
    age = json['age'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    password = json['password'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['password'] = this.password;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}
