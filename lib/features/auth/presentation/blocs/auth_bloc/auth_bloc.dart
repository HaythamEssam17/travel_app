import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/logout.dart';

part 'auth_states.dart';

@Injectable()
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._logoutUseCase) : super(AuthInit());

  final LogoutUseCase _logoutUseCase;

  logout() async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      await _logoutUseCase.logoutMockData();

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
