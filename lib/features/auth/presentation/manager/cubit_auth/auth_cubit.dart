import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());

  final AuthRepo _authRepo;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    var response = await _authRepo.signIn(email: email, password: password);
    response.fold((failure) {
      print('Auth cubit !!!!!!!!!!!!!!! ${failure.errMessage}');
      emit(AuthFailure(errMessage: failure.errMessage));
    }, (_) {
      emit(AuthSuccess());
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    var response = await _authRepo.signUp(email: email, password: password);
    response.fold((failure) {
      emit(AuthFailure(errMessage: failure.errMessage));
    }, (_) {
      emit(AuthSuccess());
    });
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    var response = await _authRepo.forgetPassword(email: email);
    response.fold((failure) {
      emit(AuthFailure(errMessage: failure.errMessage));
    }, (_) {
      emit(AuthSuccess());
    });
  }
}
