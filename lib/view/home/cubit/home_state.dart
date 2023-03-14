part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoggedOut extends HomeState {}

class HomeLoggedIn extends HomeState {}

class HomeLogIn extends HomeState {}
