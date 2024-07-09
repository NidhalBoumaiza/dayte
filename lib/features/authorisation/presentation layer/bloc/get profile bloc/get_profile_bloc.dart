import 'package:bloc/bloc.dart';
import 'package:client/core/utils/map_failure_to_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain layer/entities/user_entity.dart';
import '../../../domain layer/usecases/get_profile_use_case.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  GetProfileUseCase getProfileUseCase;

  GetProfileBloc({required this.getProfileUseCase})
      : super(GetProfileInitial()) {
    on<GetProfileEvent>((event, emit) {});
    on<GetProfile>(_getProfile);
  }

  _getProfile(GetProfileEvent event, Emitter<GetProfileState> emit) async {
    emit(GetProfileLoading());
    final failureOrSuccess = await getProfileUseCase();
    failureOrSuccess.fold((failure) {
      if (failure is UnauthorizedFailure) {
        emit(GetProfileUnauthorized());
      } else {
        emit(GetProfileFailure(mapFailureToMessage(failure)));
      }
    }, (user) => emit(GetProfileSuccess(user)));
  }
}
