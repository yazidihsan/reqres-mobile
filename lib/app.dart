import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres/features/auth/presentation/cubit/login_cubit.dart';
import 'package:reqres/features/auth/presentation/cubit/register_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/create_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/update_user_cubit.dart';
import 'package:reqres/theme_manager/theme_data_manager.dart';
import 'package:reqres/utils/routes_service.dart';

import 'sl.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginCubit>()),
        BlocProvider(create: (context) => sl<RegisterCubit>()),
        BlocProvider(create: (context) => sl<GetUserCubit>()),
        BlocProvider(create: (context) => sl<CreateUserCubit>()),
        BlocProvider(create: (context) => sl<UpdateUserCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Reqres',
        theme: getApplicationThemeData(context),
        routerConfig: RoutesService.goRouter,
      ),
    );
  }
}
