class LogsTable {
  int? id;
  String? name;
  String? phone;
  String? vehicleID;
  String? model;
  String? time;
  String? expries;
  String? color;
  int? status;
  int? role;
  LogsTable(
      {required this.id,
      required this.name,
      required this.phone,
      required this.vehicleID,
      required this.model,
      required this.time,
      required this.expries,
      required this.color,
      required this.role,
      required this.status});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'vehicle_id': vehicleID,
      'time': time,
      'vehicle_model': model,
      'status': status,
      'vehicle_color': color,
      'expires': expries,
      'role': role
    };
  }

  factory LogsTable.fromJson(Map<String, dynamic> json) {
    return LogsTable(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        vehicleID: json['vehicle_id'],
        model: json['vehicle_model'],
        time: json['time'],
        status: json['status'],
        color: json['vehicle_color'],
        role: json['role'],
        expries: json['expires']);
  }
}
