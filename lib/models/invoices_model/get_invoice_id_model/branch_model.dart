class Branch {
  int? id;
  String? nameAr;

  Branch({this.id, this.nameAr});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    return data;
  }
}