import 'location.dart';

class UserDetail {
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? picture;
  final String? gender;
  final String? email;
  final DateTime? dateOfBirth;
  final String? phone;
  final Location? location;
  final DateTime? registerDate;
  final DateTime? updatedDate;

  const UserDetail({
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
}
