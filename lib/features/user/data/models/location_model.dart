import 'package:equatable/equatable.dart';
import 'package:logique_test/features/user/domain/entities/location.dart';

class LocationModel extends Equatable {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? timezone;

  const LocationModel({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  factory LocationModel.fromEntity(Location location) => LocationModel(
        street: location.street,
        city: location.city,
        state: location.state,
        country: location.country,
        timezone: location.timezone,
      );

  Location toEntity() => Location(
        street: street,
        city: city,
        state: state,
        country: country,
        timezone: timezone,
      );

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        street: json['street'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        timezone: json['timezone'],
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'timezone': timezone,
      };

  @override
  List<Object?> get props => [street, city, state, country, timezone];
}
