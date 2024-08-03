import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../../domain layer/usecases/edit_profile_use_case.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileUseCase editProfileUseCase;

  EditProfileCubit({required this.editProfileUseCase})
      : super(EditProfileInitial());

  void editProfile(String name, String gender, DateTime dateOfBirth,
      List<dynamic> images) async {
    emit(EditProfileLoading());
    final result = await editProfileUseCase(name, gender, dateOfBirth, images);

    result.fold(
      (failure) {
        if (failure is ServerMessageFailure) {
          emit(EditProfileErreur(mapFailureToMessage(failure)));
        } else if (failure is UnauthorizedFailure) {
          emit(EditProfileUnauthorised(mapFailureToMessage(failure)));
        } else if (failure is OfflineFailure) {
          emit(EditProfileOffline(OfflineFailureMessage));
        } else if (failure is EndOfPlanFailure) {
          emit(EndOfPlan(mapFailureToMessage(failure)));
        } else {
          emit(EditProfileErreur('An error occurred'));
        }
      },
      (_) => emit(EditProfileSuccess()),
    );
  }
}
