class CarBrand {
  String? logo;
  String? name;

  CarBrand({this.logo, this.name});

  CarBrand.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['name'] = this.name;
    return data;
  }
}