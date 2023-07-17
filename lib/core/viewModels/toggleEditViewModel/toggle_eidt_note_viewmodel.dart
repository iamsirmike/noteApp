import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_eidt_note_viewmodel.g.dart';

@riverpod
class EditingViewModel extends _$EditingViewModel {
  @override
  bool build() {
    return false;
  }

  void toggleEditing(bool isEditing) {
    state = isEditing;
  }
}

// final editingProvider = NotifierProvider<EditingProvider, bool>(() {
//   return EditingProvider();
// });
