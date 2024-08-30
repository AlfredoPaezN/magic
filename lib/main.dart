import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/blocProviders.dart';
import 'package:magic/injection.dart';
import 'package:magic/src/presentation/pages/me/me_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
          ),
          routeInformationParser: AppRouter().router.routeInformationParser,
          routeInformationProvider: AppRouter().router.routeInformationProvider,
          routerDelegate: AppRouter().router.routerDelegate,
        ),
      ),
    );
  }
}
