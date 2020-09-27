import 'package:flutter/material.dart';

// --------------------------------------------------------
import '../screens/about_us/about_us.dart';
import '../screens/authentication/edit_profile.dart';
import '../screens/authentication/login.dart';
import '../screens/authentication/signup.dart';
import '../screens/authentication/verification.dart';
import '../screens/book/book.dart';
import '../screens/chapter/chapter.dart';
import '../screens/home/home.dart';
import '../screens/poem/poem.dart';
import '../screens/poet/poet.dart';
import '../screens/saved_poem/saved_poem.dart';
import '../screens/splash/splash.dart';

// --------------------------------------------------------
const SplashRoute = '/';

const SignupRoute = '/signup';
const LoginRoute = '/login';
const VerificationRoute = '/verify';

const HomeRoute = '/home';
const PoetRoute = '/home/poet';
const BookRoute = '/home/book';
const ChapterRoute = '/home/chapter';
const PoemRoute = '/home/poem';

const EditProfileRoute = 'menu/edit';
const SavedPoemRoute = 'menu/savedPoem';
const AboutUsRoute = '/menu/about';

// --------------------------------------------------------
navigate(settings) {
  final Map<String, dynamic> arguments = settings.arguments;
  Widget screen;
  switch (settings.name) {
    case AboutUsRoute:
      screen = AboutUs();
      break;
    case EditProfileRoute:
      screen = EditProfile();
      break;
    case LoginRoute:
      screen = Login();
      break;
    case SignupRoute:
      screen = Signup();
      break;
    case VerificationRoute:
      screen = Verification();
      break;
    case BookRoute:
      screen = Book(id: arguments['BookID']);
      break;
    case ChapterRoute:
      screen = Chapter(id: arguments['chapterID']);
      break;
    case HomeRoute:
      screen = Home();
      break;
    case PoemRoute:
      screen = Poem(id: arguments['PoemID']);
      break;
    case PoetRoute:
      screen = Poet(id: arguments['PoetID']);
      break;
    case SavedPoemRoute:
      screen = SavedPoem();
      break;
    case SplashRoute:
      screen = Splash();
      break;

    default:
      return null;
  }
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
