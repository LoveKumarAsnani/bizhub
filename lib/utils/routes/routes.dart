import 'package:bizhub_new/utils/routes/routes_name.dart';
import 'package:bizhub_new/view/account/change_password.dart';
import 'package:bizhub_new/view/account/contact_us.dart';
import 'package:bizhub_new/view/account/profile/edit_my_profile.dart';
import 'package:bizhub_new/view/account/profile/view_my_profile.dart';
import 'package:bizhub_new/view/auth/forgot_password_screen.dart';
import 'package:bizhub_new/view/auth/login_screen.dart';
import 'package:bizhub_new/view/auth/otp_sccess_screen.dart';
import 'package:bizhub_new/view/auth/reset_password_screen.dart';
import 'package:bizhub_new/view/auth/signup_screen.dart';
import 'package:bizhub_new/view/auth/welcome_auth_screen.dart';
import 'package:bizhub_new/view/chat/messages.dart';
import 'package:bizhub_new/view/chat/poster/poster_messages.dart';
import 'package:bizhub_new/view/chat/worker/worker_messages.dart';
import 'package:bizhub_new/view/create/create_post.dart';
import 'package:bizhub_new/view/create/select_category.dart';
import 'package:bizhub_new/view/create/select_service.dart';
import 'package:bizhub_new/view/home/filter_screen.dart';
import 'package:bizhub_new/view/home/search_posts.dart';
import 'package:bizhub_new/view/navigation/bottom_navigation.dart';
import 'package:bizhub_new/view/onboard_screen.dart';
import 'package:bizhub_new/view/splash_screen.dart';
import 'package:bizhub_new/widgets/common/loading_screen.dart';
import 'package:flutter/material.dart';
import '../../view/auth/otp_verification_screen.dart';
import '../../view/my_services/jobs/edit_poster_service.dart';
import '../../view/my_services/jobs/lead_complete.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      // case RouteName.home:
      //   return MaterialPageRoute(builder: (context) => const HomeView());
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.onboard:
        return MaterialPageRoute(builder: (context) => const OnboardScreen());
      case RouteName.welcome:
        return MaterialPageRoute(
            builder: (context) => const WelcomeAuthScreen());
      // case RouteName.loading:
      //   return MaterialPageRoute(builder: (context) => const LoadingScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case RouteName.resetPassword:
        return MaterialPageRoute(builder: (context) => const ResetPassword());
      case RouteName.otp:
        return MaterialPageRoute(
            builder: (context) => const OTPVerificationScreen());
      case RouteName.otpSuccess:
        return MaterialPageRoute(
            builder: (context) => const OTPSuccessScreen());
      case RouteName.home:
        return MaterialPageRoute(
            builder: (context) => const NavigatoionBarScreen());
      case RouteName.filter:
        return MaterialPageRoute(builder: (context) => const FilterScreen());
      // case RouteName.postDetail:
      //   return MaterialPageRoute(builder: (context) => const PostJobDetail());
      case RouteName.searchPost:
        return MaterialPageRoute(builder: (context) => const SearchPosts());
      // case RouteName.myJobDetail:
      //   return MaterialPageRoute(

      //     builder: (context) => MyJobDetail(),
      //   );
      // case RouteName.myJobComplete:
      //   return MaterialPageRoute(builder: (context) => const JobComplete());
      case RouteName.selectService:
        return MaterialPageRoute(builder: (context) => const SelectService());
      case RouteName.selectCategory:
        return MaterialPageRoute(builder: (context) => const SelectCategory());
      case RouteName.createPost:
        return MaterialPageRoute(builder: (context) => const CreatePost());
      case RouteName.editMyPosterService:
        return MaterialPageRoute(
            builder: (context) => const EditMyPosterService());
      // Messages
      case RouteName.posterMessages:
        return MaterialPageRoute(builder: (context) => const PosterMessages());
      case RouteName.workerMessages:
        return MaterialPageRoute(builder: (context) => const WorkerMessages());
      // MORE
      case RouteName.viewMyProfile:
        return MaterialPageRoute(builder: (context) => const ViewMyProfile());
      case RouteName.editMyProfile:
        return MaterialPageRoute(builder: (context) => const EditMyProfile());
      case RouteName.changePassword:
        return MaterialPageRoute(builder: (context) => const ChangePassword());
      case RouteName.contactUs:
        return MaterialPageRoute(builder: (context) => const ContactUs());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text('No route defined'),
          ),
        );
      },
    );
  }
}
