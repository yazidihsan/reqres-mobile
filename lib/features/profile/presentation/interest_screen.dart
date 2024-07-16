import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/chip_input.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_loading_button.dart';
import 'package:reqres/common_widget/custom_tags.dart';
import 'package:reqres/common_widget/custom_text.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/presentation/cubit/create_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/update_user_cubit.dart';
import 'package:reqres/features/profile/presentation/profile_screen.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:reqres/theme_manager/value_manager.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final TextEditingController controller = TextEditingController();
  List<String>? items = [];
  final maxWidth = double.infinity;
  final flex = 8;

  late GetUserCubit _getUserCubit;
  late CreateUserCubit _createUserCubit;
  late UpdateUserCubit _updateUserCubit;
  User? user;
  String name = '';
  String birthday = '';
  String height = '0';
  String weight = '0';

  @override
  void initState() {
    super.initState();
    controller.addListener(_moveCursorToEnd);
    _getUserCubit = sl<GetUserCubit>()..getUser();
    _createUserCubit = sl<CreateUserCubit>();
    _updateUserCubit = sl<UpdateUserCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_moveCursorToEnd);
  }

  void _moveCursorToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int textLength = controller.text.length;
      // controller.selection = TextSelection.fromPosition(
      //   TextPosition(offset: textLength),
      // );
      controller.selection = TextSelection.collapsed(
        offset: textLength,
        affinity: TextAffinity.downstream,
      );
    });
  }

  void _addItem(String text) {
    // UserModel? user;

    if (text.isNotEmpty || items != null) {
      setState(() {
        items!.add(text);

        controller.clear();
      });
    }
  }

  void _removeItem(int index) {
    if (items != null) {
      setState(() {
        items!.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => _getUserCubit,
            ),
            BlocProvider(
              create: (context) => _createUserCubit,
            ),
            BlocProvider(
              create: (context) => _updateUserCubit,
            ),
          ],
          child: BlocListener<GetUserCubit, GetUserState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is GetUserFailed) {
                String message = state.message;
                if (message.isNotEmpty) {
                  ValueManager.customToast(message);
                }
              }
              if (state is GetUserSuccess) {
                final data = state.user;
                // items = data.interests;
                name = data.name.toString();
                birthday = data.birthday.toString();
                height = data.height.toString();
                weight = data.weight.toString();

                log('interest: $items');
              }
            },
            child: CustomBackgroundPage(
                isPrimary: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 81, left: 23, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<GetUserCubit, GetUserState>(
                          builder: (context, state) {
                            if (state is GetUserFailed) {
                              return const Center(
                                child: CustomLoadingButton(),
                              );
                            }
                            return CustomAppbar(
                              title: "Back",
                              leftIcon: Icons.arrow_back_ios,
                              rightTitle: 'Save',
                              onPressRightSide: () {
                                // _createUserCubit.createProfile(UserModel(
                                //     name: name,
                                //     birthday: birthday,
                                //     horoscope: '',
                                //     zodiac: '',
                                //     height: int.tryParse(height),
                                //     weight: int.tryParse(weight),
                                //     interest: items!));

                                // context.go('/main', extra: items);

                                context.go('/profile', extra: items);
                                // GoRouter.of(context)
                                //     .push("profile", extra: items);
                              },
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                            );
                          },
                        ),
                        73.0.spaceY,
                        const CustomText(
                            type: 'golden-gradient',
                            text: 'Tell everyone about yourself'),
                        12.0.spaceY,
                        Text(
                          'What interest you?',
                          style: whiteTextStyle1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        35.0.spaceY,
                        ChipInput(
                            controller: controller,
                            prefixIcon: items != null && items!.isNotEmpty
                                ? Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 4.0,
                                    runSpacing: 4.0,
                                    children: items!.map((item) {
                                      int index = items!.indexOf(item);
                                      return CustomTags(
                                          title: item,
                                          onPressed: () => _removeItem(index));
                                    }).toList(),
                                  )
                                : null,
                            onSubmitted: (value) {
                              _moveCursorToEnd();
                              _addItem(value!);
                            })
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class ScreenData {
  final String message;
  final List<String> items;

  ScreenData({required this.message, required this.items});
}
