class UserProfile {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? photo;
  UserProfile({this.id, this.name, this.phone, this.email, this.photo});
  Map<String, String> toJson() {
    return {
      'id': id ?? '',
      'name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'photo': photo ?? '',
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        id: json['id'].toString(),
        name: json['name'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString(),
        photo: json['photo'].toString());
  }
}
