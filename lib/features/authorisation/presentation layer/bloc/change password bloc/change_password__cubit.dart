import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_password__state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
}
