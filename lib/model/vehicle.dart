class Vehicle {
  String? id;
  String? expires;
  int? role;
  String? model;
  String? color;
  String? vehicleID;
  int? type;
  String? phone;

  Vehicle(
      {this.id,
      this.expires,
      this.role,
      this.model,
      this.color,
      this.vehicleID,
      this.type,
      this.phone});

  Map<String, String> toJson() {
    return {
      'id': id ?? '',
      'expires': expires ?? '',
      'role': role.toString(),
      'model': model ?? '',
      'color': color ?? '',
      'vehicleID': vehicleID ?? '',
      'type': type.toString(),
      'phone': phone.toString()
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['vehicle_id'].toString(),
      expires: json['expires'].toString(),
      role: int.parse(json['role'].toString()),
      model: json['vehicle_model'].toString(),
      color: json['vehicle_color'].toString(),
      vehicleID: json['vehicle_id'].toString(),
      type: int.parse(json['vehicle_type'].toString()),
      phone: json['phone'].toString(),
    );
  }
}
