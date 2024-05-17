class note {
  String? sId;
  String? title;
  String? description;
  String? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  note(
      {this.sId,
      this.title,
      this.description,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.iV});

  note.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    owner = json['owner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['owner'] = this.owner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
