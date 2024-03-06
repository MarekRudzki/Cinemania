part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDataPressed extends DetailsEvent {
  final int id;

  FetchMovieDataPressed({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class FetchTVShowDataPressed extends DetailsEvent {
  final int id;

  FetchTVShowDataPressed({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class FetchPersonDataPressed extends DetailsEvent {
  final int id;

  FetchPersonDataPressed({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}

class AddToHistoryPressed extends DetailsEvent {
  final int id;
  final Category category;

  AddToHistoryPressed({
    required this.id,
    required this.category,
  });

  @override
  List<Object> get props => [
        id,
        category,
      ];
}

class DeleteLastHistoryElementPressed extends DetailsEvent {}
