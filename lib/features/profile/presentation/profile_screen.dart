import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_card.dart';
import 'package:reqres/common_widget/custom_text_button.dart';
import 'package:reqres/features/profile/presentation/interest_screen.dart';
import 'package:reqres/features/profile/widget/button_add.dart';
import 'package:reqres/features/profile/widget/edit_form.dart';
import 'package:reqres/features/profile/widget/inner_shadow.dart';
import 'package:reqres/features/profile/widget/rounded_card.dart';
import 'package:reqres/features/profile/widget/updated_about.dart';
import 'package:reqres/sl.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import 'package:reqres/utils/shared_pref.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.data});

  final ScreenData? data;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController nameController = TextEditingController();
TextEditingController hororscopeController = TextEditingController();
TextEditingController zodiacController = TextEditingController();
TextEditingController heightController = TextEditingController();
TextEditingController weightController = TextEditingController();

String stateVisible = 'initState';

String? selectedValue;
final List<String> options = ['Male', 'Female'];
File? imageFile;
File? _resizedImage;

final ImagePicker _picker = ImagePicker();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final SharedPref pref = sl<SharedPref>();
    log('token : ${pref.getAccessToken()}');
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
        body: CustomBackgroundPage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 81, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(
                    title: "Back",
                    centerTitle: "@JohnDoe",
                    leftIcon: Icons.arrow_back_ios,
                    rightIcon: Icons.more_horiz_rounded,
                    onPressed: () {
                      final SharedPref pref = sl<SharedPref>();
                      pref.clearAccessToken();
                      GoRouter.of(context).goNamed('login');
                    },
                  ),
                  28.0.spaceY,
                  stateVisible == 'update' && imageFile != null
                      ? Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)),
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
                                '@johndoe, 28',
                                style: whiteTextStyle1.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Positioned(
                              left: 13,
                              bottom: 62,
                              child: Text(
                                'Male',
                                style: whiteTextStyle1.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                              ),
                            ),
                            const Positioned(
                                bottom: 8,
                                left: 26,
                                child: Row(
                                  children: [
                                    RoundedCard(
                                        icon: 'assets/icon/hororscope.svg',
                                        text: 'Virgo'),
                                    RoundedCard(
                                        icon: 'assets/icon/zodiac.svg',
                                        text: 'Pig')
                                  ],
                                ))
                          ]),
                        )
                      : CustomCard(
                          child: Stack(
                          children: [
                            Positioned(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset('assets/icon/edit.svg')
                                ],
                              ),
                            ),
                            Positioned(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '@johndoe123,',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "About",
                                    style: whiteTextStyle1.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Add in your your to help others know you better",
                                  style: whiteTextStyle2.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "About",
                                        style: whiteTextStyle1.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    CustomTextButton(
                                      isBottom: false,
                                      onPressed: () {
                                        setState(() {
                                          stateVisible = 'update';
                                        });
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
                                              _resizedImage != null
                                                  ? pickAndResizeImage()
                                                  : null;
                                            },
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                child: Image.file(
                                                  _resizedImage!,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.contain,
                                                )),
                                          ),
                                    15.0.spaceX,
                                    Text(
                                      "Add image",
                                      style: whiteTextStyle1.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
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
                                  selectedInputType: 'DropDownList',
                                  value: selectedValue,
                                  hint: 'Select Gender',
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  },
                                  items: options.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                2.0.spaceY,
                                const EditForm(
                                  label: 'Birthday:',
                                  selectedInputType: 'PickDate',
                                ),
                                2.0.spaceY,
                                EditForm(
                                  astroPrediction: true,
                                  label: 'Hororscope:',
                                  selectedInputType: 'Text',
                                  hintText: '--',
                                  controller: hororscopeController,
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
                                  controller: heightController,
                                ),
                                2.0.spaceY,
                                EditForm(
                                  label: 'Weight:',
                                  selectedInputType: 'Text',
                                  hintText: 'Add Weight',
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "About",
                                            style: whiteTextStyle1.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
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
                                    24.0.spaceY,
                                    const UpdatedAbout(
                                        title: 'Birthday',
                                        data: '28/08/1995 (Age 28)'),
                                    15.0.spaceY,
                                    const UpdatedAbout(
                                        title: 'Hororsope', data: 'Virgo'),
                                    15.0.spaceY,
                                    const UpdatedAbout(
                                        title: 'Zodiac', data: 'Pig'),
                                    15.0.spaceY,
                                    const UpdatedAbout(
                                        title: 'Height', data: '175 cm'),
                                    15.0.spaceY,
                                    const UpdatedAbout(
                                        title: 'Weight', data: '69 kg'),
                                    15.0.spaceY,
                                  ]))
                              : Container(),
                  CustomCard(
                      isList: true,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Interest",
                                style: whiteTextStyle1.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  GoRouter.of(context).goNamed('interest');
                                },
                                child:
                                    SvgPicture.asset('assets/icon/edit.svg')),
                          ],
                        ),
                        (widget.data != null) &&
                                (widget.data!.message == 'from-interest')
                            ? 24.0.spaceY
                            : 28.0.spaceY,
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: (widget.data != null) &&
                                  (widget.data!.message == 'from-interest')
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Wrap(
                                        runSpacing: 4.0,
                                        spacing: 4.0,
                                        children:
                                            widget.data!.items.map((item) {
                                          return RoundedCard(text: item);
                                        }).toList()),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Add in your interest to find a better match",
                                      style: whiteTextStyle2.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
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
      ),
    );
  }
}
