import 'package:equatable/equatable.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';

import 'location_model.dart';

class UserDetailModel extends Equatable {
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? picture;
  final String? gender;
  final String? email;
  final DateTime? dateOfBirth;
  final String? phone;
  final LocationModel? location;
  final DateTime? registerDate;
  final DateTime? updatedDate;

  const UserDetailModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
  });

  factory UserDetailModel.fromEntity(UserDetail userDetail) {
    return UserDetailModel(
      id: userDetail.id,
      title: userDetail.title,
      firstName: userDetail.firstName,
      lastName: userDetail.lastName,
      picture: userDetail.picture,
      gender: userDetail.gender,
      email: userDetail.email,
      dateOfBirth: userDetail.dateOfBirth,
      phone: userDetail.phone,
      location: userDetail.location == null
          ? null
          : LocationModel.fromEntity(userDetail.location!),
      registerDate: userDetail.registerDate,
      updatedDate: userDetail.updatedDate,
    );
  }

  UserDetail toEntity() => UserDetail(
        id: id,
        title: title,
        firstName: firstName,
        lastName: lastName,
        picture: picture,
        gender: gender,
        email: email,
        dateOfBirth: dateOfBirth,
        phone: phone,
        location: location?.toEntity(),
        registerDate: registerDate,
        updatedDate: updatedDate,
      );

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
        gender: json['gender'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : '${json['dateOfBirth']}'.readIsoDate(),
        phone: json['phone'],
        location: json['location'] != null
            ? LocationModel.fromJson(json['location'])
            : null,
        registerDate: json['registerDate'] == null
            ? null
            : '${json['registerDate']}'.readIsoDate(),
        updatedDate: json['updateDate'] == null
            ? null
            : '${json['updateDate']}'.readIsoDate(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'picture': picture,
        'gender': gender,
        'email': email,
        'dateOfBirth': dateOfBirth?.toIso8601String,
        'phone': phone,
        'location': location?.toJson(),
        'registerDate': registerDate?.toIso8601String,
        'updateDate': updatedDate?.toIso8601String,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        firstName,
        lastName,
        picture,
        gender,
        email,
        dateOfBirth,
        phone,
        location,
        registerDate,
        updatedDate,
      ];
}
