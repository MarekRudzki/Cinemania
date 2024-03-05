import 'package:equatable/equatable.dart';

class CastMember extends Equatable {
  final String character;
  final int gender;
  final int id;
  final String name;
  final String url;

  CastMember({
    required this.character,
    required this.gender,
    required this.id,
    required this.name,
    required this.url,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    final String basicUrl = json['profile_path'] != null
        ? json['profile_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return CastMember(
      character:
          json['character'] != null ? json['character'] as String : 'Unknown',
      gender: json['gender'] != null ? json['gender'] as int : 0,
      id: json['id'] as int,
      name: json['name'] != null ? json['name'] as String : 'No data',
      url: fullUrl,
    );
  }

  @override
  List<Object?> get props => [
        character,
        gender,
        id,
        name,
        url,
      ];
}
