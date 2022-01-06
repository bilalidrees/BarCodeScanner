import 'package:json_annotation/json_annotation.dart';

// part 'User.g.dart';
//
// @JsonSerializable()
class User {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'COUPON')
  String? coupon;

  User({this.email, this.password, this.coupon});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      email: json["email"] as String,
      password: json["password"] as String,
      coupon: json["COUPON"] as String,
    );
  }

  Map<String, dynamic> toJson() => _userToJson(this);

  Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
        'email': instance.email,
        'password': instance.password,
        'COUPON': instance.coupon,
      };
}
