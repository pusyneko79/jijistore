class UserRegisterModel {
  int? id;
  String? name;
  String? address;
  int? age;
  String? img;
  String? email;
  String? password;
  String? phone;

  UserRegisterModel(this.id, this.name, this.address, this.age, this.img,
      this.email, this.password, this.phone);

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    age = json['age'];
    img = json['img'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['age'] = this.age;
    data['img'] = this.img;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}
