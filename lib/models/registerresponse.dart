class registerresponse {
  String? fname;
  String? lname;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  registerresponse(
      {this.fname,
      this.lname,
      this.email,
      this.phone,
      this.username,
      this.password,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  registerresponse.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
