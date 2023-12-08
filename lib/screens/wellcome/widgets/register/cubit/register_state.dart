part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class ImageSelected extends RegisterState {}
class RegisterEmoji extends RegisterState {}
class RegisterFocus extends RegisterState {}
// class RemoveImageSelected extends RegisterState {}
class RegisterError extends RegisterState {
  String? errorMessage;
  RegisterError({required this.errorMessage});
}
