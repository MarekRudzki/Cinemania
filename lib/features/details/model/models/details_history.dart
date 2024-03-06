import 'package:cinemania/common/enums.dart';
import 'package:equatable/equatable.dart';

class DetailsHistory extends Equatable {
  final Category category;
  final int id;

  DetailsHistory({
    required this.category,
    required this.id,
  });

  @override
  List<Object> get props => [
        category,
        id,
      ];
}
