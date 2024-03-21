part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDataPressed extends DetailsEvent {
  final int id;
  final String scrollableListCategory;
  final int scrollableListIndex;

  FetchMovieDataPressed({
    required this.id,
    required this.scrollableListCategory,
    required this.scrollableListIndex,
  });

  @override
  List<Object> get props => [
        id,
        scrollableListCategory,
        scrollableListIndex,
      ];
}

class FetchTVShowDataPressed extends DetailsEvent {
  final int id;
  final String scrollableListCategory;
  final int scrollableListIndex;

  FetchTVShowDataPressed({
    required this.id,
    required this.scrollableListCategory,
    required this.scrollableListIndex,
  });

  @override
  List<Object> get props => [
        id,
        scrollableListCategory,
        scrollableListIndex,
      ];
}

class FetchPersonDataPressed extends DetailsEvent {
  final int id;
  final String scrollableListCategory;
  final int scrollableListIndex;

  FetchPersonDataPressed({
    required this.id,
    required this.scrollableListCategory,
    required this.scrollableListIndex,
  });

  @override
  List<Object> get props => [
        id,
        scrollableListCategory,
        scrollableListIndex,
      ];
}

class AddToHistoryPressed extends DetailsEvent {
  final int id;
  final Category category;
  final int scrollableListIndex;
  final String scrollableListCategory;

  AddToHistoryPressed({
    required this.id,
    required this.category,
    required this.scrollableListIndex,
    required this.scrollableListCategory,
  });

  @override
  List<Object> get props =>
      [id, category, scrollableListIndex, scrollableListCategory];
}

class DeleteLastHistoryElementPressed extends DetailsEvent {}
