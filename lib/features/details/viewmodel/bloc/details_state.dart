part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {
  final Movie? movie;
  final TVShow? tvShow;
  final Person? person;
  final String scrollableListCategory;
  final int scrollableListIndex;

  DetailsSuccess({
    this.movie,
    this.tvShow,
    this.person,
    required this.scrollableListCategory,
    required this.scrollableListIndex,
  });

  @override
  List<Object> get props => [
        movie ?? Object,
        tvShow ?? Object,
        person ?? Object,
        scrollableListCategory,
        scrollableListIndex,
      ];
}

final class DetailsError extends DetailsState {
  final String errorMessage;

  DetailsError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
