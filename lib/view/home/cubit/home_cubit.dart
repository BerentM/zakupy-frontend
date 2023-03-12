import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zakupy_frontend/data/api_service.dart';
import 'package:zakupy_frontend/utils/logs.dart';
import 'package:zakupy_frontend/utils/storage.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final component = "HomeCubit";
  HomeCubit() : super(HomeInitial());

  void checkJwt() async {
    var token = await storage.read(key: "jwt");
    logger.d("token: $token", component);
    if (token != null) {
      emit(HomeLoggedIn());
    } else {
      emit(HomeLoggedOut());
    }
  }

  void logOut() async {
    await ApiService().logout();
    await storage.delete(key: "jwt");
    checkJwt();
  }
}
