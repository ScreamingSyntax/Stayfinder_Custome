// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? full_name;
  String? email;
  String? image;
  String? token;
  UserModel({
    this.id,
    this.full_name,
    this.email,
    this.image,
    this.token,
  });

  UserModel copyWith({
    int? id,
    String? full_name,
    String? email,
    String? image,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': full_name,
      'email': email,
      'image': image,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, full_name: $full_name, email: $email, image: $image, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.full_name == full_name &&
        other.email == email &&
        other.image == image &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        full_name.hashCode ^
        email.hashCode ^
        image.hashCode ^
        token.hashCode;
  }
}
