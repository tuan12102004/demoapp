import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/bread_model.dart';
import '../../models/category_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchStates> {
  SearchBloc() : super((SearchStates())) {
    on<SearchTextChanged>(_search);
    on<SelectedEvent>(_selected);
  }
  void _selected(SelectedEvent event, Emitter<SearchStates> emit) {
    final random = List<Breads>.from(Breads.breadList)..shuffle();
    final breads = List<Breads>.from(Breads.breadList);

    if (event.category.toLowerCase() == "all") {
      emit(SearchStates(selectedItem: random));
    } else {
      final selected = breads
          .where((element) =>
      element.category.toLowerCase() == event.category.toLowerCase())
          .toList();
      emit(SearchStates(selectedItem: selected));
    }
  }

  void _search(SearchTextChanged event, Emitter<SearchStates> emit) {
    final bread = List<Breads>.from(Breads.breadList);
    final search = bread.where((element) => element.breadName.toLowerCase().contains(event.text.toLowerCase()),);
    if(event.text.isEmpty){
      emit(SearchStates(search: bread));
    }else {
      if(search.isNotEmpty){
        emit(SearchStates(search: List.from(search)));
      } else {
        emit(SearchStates(search: [],messenger: "Hiện tại không có sản phẩm bạn đang tìm"));
      }
    }
  }
}
