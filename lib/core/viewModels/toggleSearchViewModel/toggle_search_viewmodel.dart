import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_search_viewmodel.g.dart';

@riverpod
class ToggleSearch extends _$ToggleSearch {
  @override
  bool build() {
    return false;
  }

  void toggleSearch(bool showSearch) {
    state = showSearch;
  }
}
