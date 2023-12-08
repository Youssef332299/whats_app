import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/wellcome/widgets/register/components/register_success.dart';
import 'package:whats_app/screens/wellcome/widgets/register/cubit/register_cubit.dart';
import 'package:whats_app/screens/wellcome/widgets/register/widgets/profile_info_screen.dart';
import '../../../../core/widgets/snack_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            cubit.isLoading = true;
          } else if (state is RegisterError) {
            cubit.isLoading = false;
            showSnackBar(context, state.errorMessage!);
          } else if (state is RegisterSuccess) {
            cubit.isLoading = false;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ProfileInfoScreen(),
            ));
          }
        },
        builder: (BuildContext context, RegisterState state) => Scaffold(
          body: CustomRegisterSuccess(cubit: cubit),
        ));
  }
}
