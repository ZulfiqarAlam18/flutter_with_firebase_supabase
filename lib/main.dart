import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/auth/login.dart';
import 'package:flutter_firebase/views/auth/signup.dart';
import 'package:flutter_firebase/views/student_screens/delete.dart'
    show DeleteStudentScreen;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/home_screen/home_page.dart';
import 'views/student_screens/add.dart';
import 'views/student_screens/update.dart';
import 'views/student_screens/view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/supabase_key.dart';
import 'services/simple_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'controller/auth_controller.dart';
import 'controller/student_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize Supabase
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  // Initialize Notification Service
  await SimpleNotificationService.initialize();

  // Register GetX Controllers
  Get.put(AuthController());
  Get.put(StudentController());

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
            theme: ThemeData(
              // Modern Color Scheme
              primarySwatch: Colors.blue,
              primaryColor: Color(0xFF1976D2),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFF1976D2),
                brightness: Brightness.light,
              ),

              // Modern Typography
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
                headlineMedium: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
                bodyLarge: TextStyle(fontSize: 16.sp, color: Color(0xFF555555)),
                bodyMedium: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF666666),
                ),
              ),

              // App Bar Theme
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              // Elevated Button Theme
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Input Decoration Theme
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
                ),
                fillColor: Color(0xFFF8F9FA),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),

              // Card Theme
              cardTheme: CardThemeData(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                color: Colors.white,
              ),
            ),
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
