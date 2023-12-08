part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashEnd extends SplashState {}
class SplashEndButNoNetwork extends SplashState {}
class SplashEndAndConnected extends SplashState {}
