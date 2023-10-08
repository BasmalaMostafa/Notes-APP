import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationLoading());

  bool isPassword = true;

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  void passwordVisibility() {
    isPassword = !isPassword;
    emit(AuthenticationPasswordVisibility(isPassword: isPassword));
  }
}
