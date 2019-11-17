import 'package:flutter/cupertino.dart';
import 'package:servicer/ui/email_registration_screen.dart';
import 'package:servicer/ui/home_screen.dart';
import 'package:servicer/ui/login_scree.dart';
import 'package:servicer/ui/main_page.dart';
import 'package:servicer/ui/otp_verification_screen.dart';
import 'package:servicer/ui/setup_complete_screen.dart';
import 'package:servicer/ui/signup_screen.dart';
import 'package:servicer/ui/splash_screen.dart';
import 'package:servicer/ui/upload_image_screen.dart';

final routes = {
  '/splash' : (BuildContext context) => new SplashScreen(),
  '/main' : (BuildContext context) => new MainPage(),
  '/signup' : (BuildContext context) => new SignUpPage(),
  '/login' : (BuildContext context) => new LoginPage(),
  '/emailregistration' : (BuildContext context) => new EmailSignUpScreen(),
  '/otpverification' : (BuildContext context) => new OtpVerificationScreen(),
  '/setupcomplete' : (BuildContext context) => new SetupCompleteScreen(),
  '/uploadimage' : (BuildContext context) => new UploadImageScreen(),
  '/home' : (BuildContext context) => new HomeScreen(),
};