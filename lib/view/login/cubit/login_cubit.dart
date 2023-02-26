import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/utils/storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> getToken(String username, password) async {
    var token = await ApiService().login(username, password);
    storage.write(key: "jwt", value: token.accessToken);
    emit(LoggedIn());
  }
}
