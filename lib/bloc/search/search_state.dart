part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
 class SearchStates extends Equatable {
  final List<Breads> search;
  final List selectedItem;
  final String messenger;
  const SearchStates({this.messenger = '', this.search = const [],this.selectedItem = const []});
  SearchStates copy({String? messenger, List<Breads>? search, List<Breads>? selectedItem}){
    return SearchStates(messenger: messenger ?? this.messenger, selectedItem: selectedItem ?? this.selectedItem, search: search ?? this.search);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [messenger, search, selectedItem];
}
