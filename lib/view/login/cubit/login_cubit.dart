import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  var component = "login cubit";

  Future<void> getToken(String username, password) async {
    var token = await ApiService().login(username, password);
    await storage.write(key: "jwt", value: token.accessToken);
    logger.d(await storage.read(key: "jwt"), component);
  }
}
