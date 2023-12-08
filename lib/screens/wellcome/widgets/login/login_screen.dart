import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/widgets/snack_bar.dart';
import 'package:whats_app/screens/navigation_bar/navigation_bar_screen.dart';
import 'package:whats_app/screens/wellcome/widgets/login/components/custom_login_success.dart';
import 'package:whats_app/screens/wellcome/widgets/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginLoading){
              cubit.isLoading = true;
          }else if(state is LoginError){
              cubit.isLoading = false;
            showSnackBar(context, state.errorMessage!);
          }else if(state is LoginSuccess){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NavigationBarScreen(),));
          }
        },
        builder: (BuildContext context, LoginState state) =>
         Scaffold(
          body: CustomLoginSuccess(cubit: cubit),
        )
    );
  }
}
