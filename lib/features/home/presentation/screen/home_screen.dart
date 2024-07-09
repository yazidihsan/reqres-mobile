import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/features/home/presentation/cubit/user_cubit.dart';
import 'package:reqres/theme_manager/space_manager.dart';

import '../widget/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchUsers(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Data User', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                GoRouter.of(context).goNamed('user');
              },
              icon: const Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState is UserFailed) {
            return Center(child: Text(userState.message));
          }

          if (userState is UserLoaded) {
            final users = userState.users;

            // return UserCard(user: users);
            return ListView.separated(
              itemBuilder: (context, index) {
                final user = users[index];

                return UserCard(user: user);
              },
              separatorBuilder: (context, index) => 8.0.spaceY,
              itemCount: users.length,
            );
          }

          return Container();
        },
      ),
    );
  }
}
