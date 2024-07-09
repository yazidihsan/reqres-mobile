import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres/features/home/presentation/cubit/user_cubit.dart';
import 'package:reqres/theme_manager/theme_data_manager.dart';
import 'package:reqres/utils/routes_service.dart';

import 'sl.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserCubit>(),
      child: MaterialApp.router(
        title: 'Reqres',
        theme: getApplicationThemeData(context),
        routerConfig: RoutesService.goRouter,
      ),
    );
  }
}
