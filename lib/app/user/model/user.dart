class UserProfile {
  String? id;
  String? name;
  String? email;
  String? photo;
  UserProfile({this.id, this.name, this.email, this.photo});
  Map<String, String> toJson() {
    return {
      'id': id ?? '',
      'name': name ?? '',
      'email': email ?? '',
      'photo': photo ?? '',
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        id: json['id'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
        photo: json['url_photo'].toString());
  }
}
