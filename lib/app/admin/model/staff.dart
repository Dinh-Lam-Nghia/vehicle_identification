class Staff {
  int? id;
  String? phone;
  String? plateNumber;
  String? expires;
  int? role;
  String? name;
  String? model;
  Staff({
    required this.id,
    required this.phone,
    required this.plateNumber,
    required this.expires,
    required this.role,
    required this.name,
    required this.model,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'plate_number': plateNumber,
      'expires': expires,
      'role': role,
      'name': name,
      'model': model,
    };
  }

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      phone: json['phone'],
      plateNumber: json['plate_number'],
      expires: json['expires'],
      role: json['role'],
      name: json['name'],
      model: json['model'],
    );
  }
}
