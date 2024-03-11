part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryPressed extends CategoryEvent {
  final String query;
  final Category type;

  FetchCategoryPressed({
    required this.query,
    required this.type,
  });

  @override
  List<Object> get props => [
        query,
        type,
      ];
}
