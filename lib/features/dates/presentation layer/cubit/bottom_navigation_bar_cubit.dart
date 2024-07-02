import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(1);

  void changePage(int index) {
    emit(index);
  }
}
