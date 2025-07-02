part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchTextChanged extends SearchEvent {
  final String text;
  const SearchTextChanged({required this.text});

  @override
  List<Object?> get props => [text];
}

class SelectedEvent extends SearchEvent {
  final String category;
   const SelectedEvent(this.category);

  @override
  List<Object?> get props => [category];
}
