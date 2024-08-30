import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/injection.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/routes/routes.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpRealRouterApp(
    String location,
    Widget Function(Widget child) builder, {
    bool isConnected = true,
  }) {
    return pumpWidget(
      builder(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => locator<MagicBloc>(),
            ),
          ],
          child: ScreenUtilInit(
            minTextAdapt: true,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(),
                useMaterial3: true,
                cardTheme: const CardTheme(
                  surfaceTintColor: Colors.white,
                ),
              ),
              // routerConfig: AppRouter.returnRouter(),
              routeInformationParser: AppRouter().router.routeInformationParser,
              routeInformationProvider:
                  AppRouter().router.routeInformationProvider,
              routerDelegate: AppRouter().router.routerDelegate,
            ),
          ),
        ),
      ),
    );
  }
}
