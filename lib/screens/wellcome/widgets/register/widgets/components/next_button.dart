import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/widgets/circle_progras_indicator.dart';
import 'package:whats_app/core/widgets/snack_bar.dart';
import '../../../../../../core/colors/app_colors.dart';
import '../../../../../navigation_bar/navigation_bar_screen.dart';
import '../../cubit/register_cubit.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return cubit.isLoading
            ? loading()
            : GestureDetector(
                onTap: () => cubit.onTapNextButton(),
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 21, left: 21),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: messageColor),
                  child: const Text("Next",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ),
              );
      },
      listener: (BuildContext context, RegisterState state) {
        if (state is RegisterLoading) {
          cubit.isLoading = true;
        } else if (state is RegisterError) {
          cubit.isLoading = false;
          showSnackBar(context, state.errorMessage!);
        } else if (state is RegisterSuccess) {
          cubit.isLoading = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const NavigationBarScreen()),
            (route) => false,
          );
        }
      },
    );
  }
}
