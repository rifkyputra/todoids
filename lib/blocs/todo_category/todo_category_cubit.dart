import 'package:bloc/bloc.dart';
import 'package:todoids/blocs/app_state.dart';
import 'package:meta/meta.dart';

part 'todo_category_state.dart';

class TodoCategoryCubit extends Cubit<AppState> {
  TodoCategoryCubit() : super(Initialized());

  List dropDownList = [];
  String selected = '';

  selectDropdown(String item) {
    selected = item;
    if (state is Loaded<List>) {
      emit(
        Loaded<List>(dropDownList, data: {
          'selected': selected,
        }),
      );
    }
  }

  addCategory(String categoryName) {
    dropDownList.add(categoryName);
    emit(Loaded(dropDownList, data: {
      'selected': selected,
    }));
  }
}
