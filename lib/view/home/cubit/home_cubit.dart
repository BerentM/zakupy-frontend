import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final component = "HomeCubit";
  HomeCubit() : super(HomeInitial());

  Future<void> loginPage() async {
    emit(HomeLogIn());
  }

  Future<void> checkJwt() async {
    var token = await storage.read(key: "jwt");
    logger.d("token: $token", component);
    if (token != null) {
      emit(HomeLoggedIn());
    } else {
      emit(HomeLoggedOut());
    }
  }

  void logIn(String username, password, BuildContext context) {
    ApiService()
        .login(username, password)
        .then(
          (value) {
            storage.write(key: "jwt", value: value.accessToken);
            return value.accessToken;
          },
        )
        .then((value) => logger.d(value, component))
        .then((value) => Navigator.popAndPushNamed(context, HOME));
  }

  Future<void> logOut() async {
    ApiService().logout();
    storage.delete(key: "jwt");
  }
}
