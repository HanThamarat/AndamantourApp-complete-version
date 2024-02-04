class DropDrown {
  int? id;
  String? nameEn;

  DropDrown({ this.id, this.nameEn});

  DropDrown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    return data;
  }
}