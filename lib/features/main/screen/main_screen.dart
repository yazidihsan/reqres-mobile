import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres/common_widget/custom_loading_button.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/features/profile/presentation/profile_screen.dart';
import 'package:reqres/theme_manager/value_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.interests});

  final List<String>? interests;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
// with WidgetsBindingObserver
{
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GetUserCubit, GetUserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is GetUserLoading) {
            const Center(
              child: CustomLoadingButton(),
            );
          }
          if (state is GetUserFailed) {
            String message = state.message;

            if (message.isNotEmpty) {
              ValueManager.customToast(message);
            }
          }
          if (state is GetUserSuccess) {
            context.read<GetUserCubit>().getUser();
          }
        },
        child: ProfileScreen(
          interests: widget.interests,
        ),
      ),
    );
  }
}

// Widget mainBody() {
//   return  ProfileScreen(widget.inte);
// }
