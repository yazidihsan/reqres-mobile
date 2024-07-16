import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_card.dart';
import 'package:reqres/common_widget/custom_loading_button.dart';
import 'package:reqres/common_widget/custom_text_button.dart';
import 'package:reqres/common_widget/refresh_data.dart';
import 'package:reqres/features/profile/data/models/user_model.dart';
import 'package:reqres/features/profile/domain/entities/user.dart';
import 'package:reqres/features/profile/presentation/cubit/create_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/get_user_cubit.dart';
import 'package:reqres/features/profile/presentation/cubit/update_user_cubit.dart';
import 'package:reqres/features/profile/presentation/interest_screen.dart';
import 'package:reqres/features/profile/widget/button_add.dart';
import 'package:reqres/features/profile/widget/edit_form.dart';
import 'package:reqres/features/profile/widget/inner_shadow.dart';
import 'package:reqres/features/profile/widget/rounded_card.dart';
import 'package:reqres/features/profile/widget/updated_about.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:image/image.dart' as img;
import 'package:reqres/theme_manager/value_manager.dart';
import 'dart:typed_data';

import 'package:reqres/utils/shared_pref.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.interests});

  final List<String>? interests;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

late TextEditingController nameController;
late TextEditingController hororscopeController;
late TextEditingController zodiacController;
late TextEditingController heightController;
late TextEditingController weightController;

late GetUserCubit _userCubit;
late CreateUserCubit _createUserCubit;
late UpdateUserCubit _updateUserCubit;

String stateVisible = 'initState';

String? selectedValue;
final List<String> options = ['Male', 'Female'];
File? imageFile;
File? _resizedImage;

final ImagePicker _picker = ImagePicker();

// User? user;

DateTime? selectedDate;

String name = '';
String horoscope = '--';
String zodiac = '--';
String birthday = '--';
String height = '0';
String weight = '0';
// List<String> interests = [];

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    final SharedPref pref = sl<SharedPref>();
    log('token dapet dak : ${pref.getAccessToken()}');

    _userCubit = sl<GetUserCubit>()..getUser();
    _createUserCubit = sl<CreateUserCubit>();
    _updateUserCubit = sl<UpdateUserCubit>();

    // final state = _createUserCubit.state;
    // nameController = TextEditingController();
    // hororscopeController = TextEditingController();
    // zodiacController = TextEditingController();
    // heightController = TextEditingController();
    // weightController = TextEditingController();
    // final stateUser = _userCubit.state;
    final state = _userCubit.state;
    final stateCreate = _createUserCubit.state;
    final stateUpdate = _updateUserCubit.state;
    // if (stateUser is GetUserSuccess) {
    //   final data = stateUser;
    //   setState(() {
    //     name = data.name.toString();
    //     horoscope = data.horoscope.toString();
    //     zodiac = data.zodiac.toString();
    //     height = data.height.toString();
    //     weight = data.weight.toString();
    //   });
    // }
    if (state is GetUserSuccess ||
        stateCreate is CreateUserSuccess ||
        stateUpdate is UpdateUserSuccess) {
      nameController = TextEditingController(text: name);
      hororscopeController = TextEditingController(text: horoscope);
      zodiacController = TextEditingController(text: zodiac);
      heightController = TextEditingController(text: height);
      weightController = TextEditingController(text: weight);
    } else {
      nameController = TextEditingController();
      hororscopeController = TextEditingController();
      zodiacController = TextEditingController();
      heightController = TextEditingController();
      weightController = TextEditingController();
    }
    // }
  }

  @override
  void dispose() {
    // TODO: implement activate
    nameController.clear();
    hororscopeController.clear();
    zodiacController.clear();
    heightController.clear();
    weightController.clear();

    // context.read<GetUserCubit>().close();
    _userCubit.close();
    _createUserCubit.close();
    _updateUserCubit.close();
    super.dispose();
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickAndResizeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);

        // Read the image from file
        Uint8List? imageBytes;
        img.Image? originalImage;
        if (imageFile != null) {
          imageBytes = await imageFile!.readAsBytes();

          originalImage = img.decodeImage(imageBytes);
        }

        // Resize the image
        img.Image? resizedImage;
        if (originalImage != null) {
          resizedImage = img.copyResize(originalImage, width: 50, height: 50);
        }

        Uint8List? resizedImageBytes;
        //Convert back to Uin8List
        if (resizedImage != null) {
          resizedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));
        }

        // Save the resized image to a file or use it as need
        File resizedFile =
            File('${(imageFile!.parent.path)}/resized_image.png');

        if (resizedImageBytes != null) {
          await resizedFile.writeAsBytes(resizedImageBytes);
        }

        // Optionally display the resized image
        setState(() {
          _resizedImage = resizedFile;
        });
      }
      // final XFile? image = await _picker.pickImage(
      //   source: ImageSource.gallery,
      // );
      // setState(() {
      //   imageFile = image?.path;
      // });
    } catch (e) {
      log('Error : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorManager.bg2,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => _userCubit,
            ),
            BlocProvider(
              create: (context) => _createUserCubit,
            ),
            BlocProvider(
              create: (context) => _updateUserCubit,
            ),
          ],
          child: MultiBlocListener(
              listeners: [
                BlocListener<CreateUserCubit, CreateUserState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is CreateUserLoading) {
                      const Center(child: CustomLoadingButton());
                    }
                    if (state is CreateUserSuccess) {
                      final data = state.user;

                      setState(() {
                        name = data.name.toString();
                        height = data.height.toString();
                        weight = data.weight.toString();
                      });
                    }

                    if (state is CreateUserFailed) {
                      String message = state.message;

                      if (message.isNotEmpty) {
                        ValueManager.customToast(message);
                      }
                    }
                  },
                ),
                BlocListener<UpdateUserCubit, UpdateUserState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is UpdateUserLoading) {
                      const Center(child: CustomLoadingButton());
                    }
                    if (state is UpdateUserSuccess) {
                      final data = state.user;

                      setState(() {
                        name = data.name.toString();
                        height = data.height.toString();
                        weight = data.weight.toString();
                      });
                    }

                    if (state is UpdateUserFailed) {
                      String message = state.message;

                      if (message.isNotEmpty) {
                        ValueManager.customToast(message);
                      }
                    }
                  },
                ),
              ],
              child: BlocBuilder<GetUserCubit, GetUserState>(
                builder: (context, state) {
                  if (state is GetUserLoading) {
                    return const Center(
                      child: CustomLoadingButton(),
                    );
                  }
                  if (state is GetUserFailed) {
                    String message = state.message;

                    if (message.isNotEmpty) {
                      ValueManager.customToast(message);
                    }
                    return Center(
                      child: RefreshData(
                        onPressed: () async => message
                                .contains('Internal server error')
                            ? GoRouter.of(context).pushReplacementNamed('login')
                            : context.read<GetUserCubit>().getUser(),
                      ),
                    );
                  }

                  if (state is GetUserSuccess) {
                    final data = state.user;

                    final dataDecoded = jsonDecode(jsonEncode(data));

                    return RefreshIndicator(
                      onRefresh: () async =>
                          context.read<GetUserCubit>()..getUser(),
                      child: CustomBackgroundPage(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 81, left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAppbar(
                                  title: "Back",
                                  centerTitle: "@${data.name}",
                                  leftIcon: Icons.arrow_back_ios,
                                  rightIcon: Icons.more_horiz_rounded,
                                  onPressed: () {
                                    final SharedPref pref = sl<SharedPref>();
                                    pref.clearAccessToken();
                                    GoRouter.of(context)
                                        .pushReplacementNamed('login');
                                  },
                                ),
                                28.0.spaceY,
                                stateVisible == 'update' && imageFile != null
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17)),
                                        child: Stack(children: [
                                          InnerShadowImage(
                                            borderRadius: 17,
                                            child: ClipRRect(
                                              child: Image.file(
                                                imageFile!,
                                                width: 359,
                                                height: 190,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 13,
                                            bottom: 84,
                                            child: Text(
                                              '@${data.name}, ${data.birthday}',
                                              style: whiteTextStyle1.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Positioned(
                                            left: 13,
                                            bottom: 62,
                                            child: Text(
                                              '$selectedValue',
                                              style: whiteTextStyle1.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 8,
                                              left: 26,
                                              child: Row(
                                                children: [
                                                  RoundedCard(
                                                      icon:
                                                          'assets/icon/hororscope.svg',
                                                      text: dataDecoded[
                                                          'horoscope']),
                                                  RoundedCard(
                                                      icon:
                                                          'assets/icon/zodiac.svg',
                                                      text:
                                                          dataDecoded['zodiac'])
                                                ],
                                              ))
                                        ]),
                                      )
                                    : CustomCard(
                                        child: Stack(
                                        children: [
                                          Positioned(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icon/edit.svg')
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '@${data.name},',
                                                style: whiteTextStyle1.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ))
                                        ],
                                      )),
                                stateVisible == 'initState'
                                    ? CustomCard(
                                        isList: true,
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  "About",
                                                  style:
                                                      whiteTextStyle1.copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      stateVisible = 'edit';
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      'assets/icon/edit.svg')),
                                            ],
                                          ),
                                          33.0.spaceY,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Add in your your to help others know you better",
                                                style: whiteTextStyle2.copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          )
                                        ]))
                                    : stateVisible == 'edit'
                                        ? CustomCard(
                                            isList: true,
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Text(
                                                      "About",
                                                      style: whiteTextStyle1
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  CustomTextButton(
                                                    isBottom: false,
                                                    onPressed: () {
                                                      if (widget.interests !=
                                                              null &&
                                                          widget.interests!
                                                              .isNotEmpty) {
                                                        if (nameController
                                                                .text.isEmpty ||
                                                            hororscopeController
                                                                .text.isEmpty ||
                                                            zodiacController.text
                                                                .isEmpty ||
                                                            heightController
                                                                .text.isEmpty ||
                                                            weightController
                                                                .text.isEmpty) {
                                                          _createUserCubit.createProfile(
                                                              nameController
                                                                  .text,
                                                              selectedDate?.day
                                                                      .toString() ??
                                                                  '0',
                                                              int.tryParse(
                                                                      heightController
                                                                          .text
                                                                          .toString()) ??
                                                                  0,
                                                              int.tryParse(
                                                                      weightController
                                                                          .text
                                                                          .toString()) ??
                                                                  0,
                                                              List<String>.from(
                                                                  widget
                                                                      .interests!));

                                                          setState(() {
                                                            stateVisible =
                                                                'update';
                                                            nameController =
                                                                TextEditingController(
                                                                    text: name);
                                                            hororscopeController =
                                                                TextEditingController(
                                                                    text:
                                                                        horoscope);
                                                            zodiacController =
                                                                TextEditingController(
                                                                    text:
                                                                        zodiac);
                                                            heightController =
                                                                TextEditingController(
                                                                    text:
                                                                        height);
                                                            weightController =
                                                                TextEditingController(
                                                                    text:
                                                                        weight);
                                                          });
                                                        } else {
                                                          _updateUserCubit.updateProfile(
                                                              nameController
                                                                  .text,
                                                              selectedDate?.day
                                                                      .toString() ??
                                                                  '0',
                                                              int.tryParse(
                                                                      heightController
                                                                          .text
                                                                          .toString()) ??
                                                                  0,
                                                              int.tryParse(
                                                                      weightController
                                                                          .text
                                                                          .toString()) ??
                                                                  0,
                                                              List<String>.from(
                                                                  widget
                                                                      .interests!));
                                                          setState(() {
                                                            stateVisible =
                                                                'update';
                                                          });
                                                          context
                                                              .read<
                                                                  GetUserCubit>()
                                                              .getUser();
                                                        }
                                                      } else {
                                                        return ValueManager
                                                            .customToast(
                                                                "Please enter your interests");
                                                      }
                                                    },
                                                    text: "Save & Update",
                                                  )
                                                ],
                                              ),
                                              31.0.spaceY,
                                              Row(
                                                children: [
                                                  _resizedImage == null
                                                      ? ButtonAdd(
                                                          onPressed: () {
                                                            pickAndResizeImage();
                                                          },
                                                          child: SvgPicture.asset(
                                                              'assets/icon/add.svg'))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            _resizedImage !=
                                                                    null
                                                                ? pickAndResizeImage()
                                                                : null;
                                                          },
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17),
                                                              child: Image.file(
                                                                _resizedImage!,
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .contain,
                                                              )),
                                                        ),
                                                  15.0.spaceX,
                                                  Text(
                                                    "Add image",
                                                    style: whiteTextStyle1
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  )
                                                ],
                                              ),
                                              29.0.spaceY,
                                              EditForm(
                                                label: 'Display Name:',
                                                selectedInputType: 'Text',
                                                hintText: 'Enter Name',
                                                controller: nameController,
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                label: 'Gender:',
                                                selectedInputType:
                                                    'DropDownList',
                                                value: selectedValue,
                                                hint: 'Select Gender',
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedValue = newValue;
                                                  });
                                                },
                                                items: options.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 50.0),
                                                      child: Text(value),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                label: 'Birthday:',
                                                selectedInputType: 'PickDate',
                                                children: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        pickDate(context),
                                                    child: Text(
                                                      selectedDate == null
                                                          ? 'DD MM YYYY'
                                                          : '${selectedDate!.toLocal()}'
                                                              .split(' ')[0],
                                                      style: selectedDate ==
                                                              null
                                                          ? whiteTextStyle7
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13)
                                                          : whiteTextStyle1
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                astroPrediction: true,
                                                label: 'Hororscope:',
                                                selectedInputType: 'Text',
                                                hintText: '--',
                                                controller:
                                                    hororscopeController,
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                astroPrediction: true,
                                                label: 'Zodiac:',
                                                selectedInputType: 'Text',
                                                hintText: '--',
                                                controller: zodiacController,
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                label: 'Height:',
                                                selectedInputType: 'Text',
                                                hintText: 'Add Height',
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: heightController,
                                              ),
                                              2.0.spaceY,
                                              EditForm(
                                                label: 'Weight:',
                                                selectedInputType: 'Text',
                                                hintText: 'Add Weight',
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: weightController,
                                              ),
                                              2.0.spaceY,
                                            ]))
                                        : stateVisible == 'update'
                                            ? CustomCard(
                                                isList: true,
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Text(
                                                          "About",
                                                          style: whiteTextStyle1
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              stateVisible =
                                                                  'edit';
                                                            });
                                                          },
                                                          child: SvgPicture.asset(
                                                              'assets/icon/edit.svg')),
                                                    ],
                                                  ),
                                                  24.0.spaceY,
                                                  UpdatedAbout(
                                                      title: 'Birthday',
                                                      data:
                                                          '${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year} (Age ${data.birthday})'),
                                                  15.0.spaceY,
                                                  UpdatedAbout(
                                                      title: 'Hororsope',
                                                      data: horoscope),
                                                  15.0.spaceY,
                                                  UpdatedAbout(
                                                      title: 'Zodiac',
                                                      data: zodiac),
                                                  15.0.spaceY,
                                                  UpdatedAbout(
                                                      title: 'Height',
                                                      data: '$height cm'),
                                                  15.0.spaceY,
                                                  UpdatedAbout(
                                                      title: 'Weight',
                                                      data: '$weight kg'),
                                                  15.0.spaceY,
                                                ]))
                                            : Container(),
                                CustomCard(
                                    isList: true,
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Interest",
                                              style: whiteTextStyle1.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                GoRouter.of(context)
                                                    .pushNamed('interest');
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/icon/edit.svg')),
                                        ],
                                      ),
                                      widget.interests != null
                                          ? 24.0.spaceY
                                          : 28.0.spaceY,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: widget.interests != null
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Wrap(
                                                      runSpacing: 4.0,
                                                      spacing: 4.0,
                                                      children: widget
                                                          .interests!
                                                          .map((item) {
                                                        return RoundedCard(
                                                            text: item);
                                                      }).toList()),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Add in your interest to find a better match",
                                                    style: whiteTextStyle2
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    color: ColorManager.bg5,
                    child: Text("seko opo iki coeg"),
                  );
                },
              )),
        ),
      ),
    );
  }
}
