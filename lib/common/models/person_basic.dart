import 'package:equatable/equatable.dart';

class PersonBasic extends Equatable {
  // Gender:
  // 0 - unknown
  // 1 - man
  // 2 - woman
  // 3 - non-binary
  final int id;
  final int gender;
  final String imageUrl;
  final String name;

  PersonBasic({
    required this.id,
    required this.gender,
    required this.imageUrl,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        gender,
        imageUrl,
        name,
      ];

  factory PersonBasic.fromJson(Map<String, dynamic> json) {
    final String basicUrl = json['profile_path'] != null
        ? json['profile_path'] as String
        : 'No data';
    final String fullUrl = 'https://image.tmdb.org/t/p/w500$basicUrl';

    return PersonBasic(
      id: json['id'] as int,
      gender: json['gender'] != null ? json['gender'] as int : 0,
      name: json['name'] != null ? json['name'] as String : 'No data',
      imageUrl: fullUrl,
    );
  }
}
