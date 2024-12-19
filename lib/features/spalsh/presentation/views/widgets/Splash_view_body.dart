import 'package:attendy/core/utils/app_router.dart';
import 'package:attendy/features/spalsh/presentation/views/widgets/slidind_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/assets.dart';
import 'package:attendy/constants.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
   navigateToHome();

  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsData.logo,width: 100,height: 100,),
       SlidingText(slidingAnimation: slidingAnimation)

      ],
    );
  }
  void initSlidingAnimation() {
    animationController=AnimationController(
        vsync: this,
        duration: kTransitionDuration);
    slidingAnimation =Tween<Offset>(begin:const Offset(0,2) ,end:const Offset(0,0) ).animate(animationController);
    animationController.forward();
  }
  void navigateToHome() {
    Future.delayed( Duration(seconds: 3),(){
      GoRouter.of(context).push(AppRouter.kHomeView);


    });
  }
}

