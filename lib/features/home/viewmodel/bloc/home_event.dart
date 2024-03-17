part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CategoryChangePressed extends HomeEvent {
  final String selectedTab;
  final Category category;

  CategoryChangePressed({
    required this.selectedTab,
    required this.category,
  });

  @override
  List<Object> get props => [
        selectedTab,
        category,
      ];
}
