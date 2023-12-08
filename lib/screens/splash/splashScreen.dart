import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/screens/splash/widgets/check_network.dart';
import 'package:whats_app/screens/splash/cubit/splash_cubit.dart';
import '../../core/assets/images/images.dart';
import '../core/bloc/multi_bloc_provider.dart';
import '../navigation_bar/navigation_bar_screen.dart';
import '../wellcome/wellcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashCubit cubit = SplashCubit.get(context);

    final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = platformBrightness == Brightness.dark;
    return BlocConsumer<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Image.asset(
                isDarkMode ? Images.splashDark : Images.splashLight),
          ),
        );
      },
      listener: (BuildContext context, SplashState state) {
        if (state is SplashEnd) {
          cubit.internetState();
        }else if(state is SplashEndAndConnected){
          cubit.newClient ? null : isOnline();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => cubit.newClient
                  ? const WellComeScreen()
                  : const NavigationBarScreen(),
            ),
                (route) => false,
          );
        }else if (state is SplashEndButNoNetwork){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>
              const CheckNetwork(),), (route) => false);
        }
      },
    );
  }
}
