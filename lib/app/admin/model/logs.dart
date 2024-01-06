class Logs {
  int? id;
  int? status;
  String? time;
  int? vehicleID;
  Logs(
      {required this.id,
      required this.status,
      required this.time,
      required this.vehicleID});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'time': time,
      'vehicle_id': vehicleID,
    };
  }

  factory Logs.fromJson(Map<String, dynamic> json) {
    return Logs(
      id: json['id'],
      status: json['status'],
      time: json['time'],
      vehicleID: json['vehicle_id'],
    );
  }
}
