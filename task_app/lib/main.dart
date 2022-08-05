import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/cubit/task_cubit.dart';
import 'package:task_app/cubit/theme_cubit.dart';

import 'app_router.dart';
import 'app_themes.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(
    MyApp(appRouter: AppRouter()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          )
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'BloC Tasks App',
              theme: state.switchValue
                  ? AppThemes.appThemeData[AppTheme.darkMode]
                  : AppThemes.appThemeData[AppTheme.lightMode],
              home: const TabsScreen(),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ));
  }
}
