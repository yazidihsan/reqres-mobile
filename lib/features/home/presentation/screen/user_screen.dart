import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres/features/home/presentation/cubit/user_cubit.dart';
import 'package:reqres/features/home/presentation/widget/custom_button_home.dart';
import 'package:reqres/features/home/presentation/widget/text_field.dart';
import 'package:reqres/features/home/presentation/widget/title_app.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.from});

  final String? from;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  late String? _from;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    _from = widget.from;
    super.initState();
  }

  @override
  void dispose() {
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: TitleApp(
            title: 'Tambah Data',
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.0.spaceY,
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: TitleApp(
                  //     title: 'Tambah User',
                  //   ),
                  // ),
                  32.0.spaceY,
                  UserTextField(
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    title: 'first name',
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return "Masukkan Nama Pertama User";
                      }
                      return null;
                    },
                  ),
                  16.0.spaceY,
                  UserTextField(
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    title: 'last name',
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return "Masukkan Nama Terakhir User";
                      }
                      return null;
                    },
                  ),
                  16.0.spaceY,
                  UserTextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    title: 'email',
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return "Masukkan Email User";
                      }
                      return null;
                    },
                  ),
                  24.0.spaceY,
                  BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomButtonHome(onPressed: () {
                      // if((_formKey.currentState ?? FormState())
                      //   .validate()){
                      //     context.read<UserCubit>().start
                      //   }
                    });
                  })
                ],
              )),
        ));
  }
}
