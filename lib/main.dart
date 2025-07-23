import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/auth/login.dart';
import 'package:flutter_firebase/views/auth/signup.dart';
import 'package:flutter_firebase/views/student_screens/delete.dart'
    show DeleteStudentScreen;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/auth_controller.dart';
import 'firebase_options.dart';
import 'views/home_screen/home_page.dart';
import 'views/student_screens/add.dart';
import 'views/student_screens/update.dart';
import 'views/student_screens/view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/supabase_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Auth + Firestore)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase (for storage only)
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder:
          (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Manager',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
            initialRoute: '/login',
            getPages: [
              GetPage(name: '/login', page: () => LoginScreen()),
              GetPage(name: '/signup', page: () => SignUpScreen()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/add-student', page: () => AddStudentScreen()),
              GetPage(name: '/view-students', page: () => ViewStudentsScreen()),
              GetPage(
                name: '/update-student',
                page: () => UpdateStudentScreen(),
              ),
              GetPage(
                name: '/delete-student',
                page: () => DeleteStudentScreen(),
              ),
            ],
          ),
    );
  }
}
