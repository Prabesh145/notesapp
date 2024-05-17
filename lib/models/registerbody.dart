class registerbody {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? confirmpassword;

  registerbody(
      {this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.username,
      this.password,
      this.confirmpassword});

  registerbody.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    confirmpassword = json['confirmpassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['confirmpassword'] = this.confirmpassword;
    return data;
  }
}
