import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/chip_input.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_tags.dart';
import 'package:reqres/common_widget/custom_text.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final TextEditingController controller = TextEditingController();
  List<String> items = [];
  final maxWidth = double.infinity;
  final flex = 8;

  @override
  void initState() {
    super.initState();
    controller.addListener(_moveCursorToEnd);
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
    if (text.isNotEmpty) {
      setState(() {
        items.add(text);

        controller.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomBackgroundPage(
            isPrimary: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 81, left: 23, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(
                      title: "Back",
                      leftIcon: Icons.arrow_back_ios,
                      rightTitle: 'Save',
                      onPressRightSide: () {
                        final data =
                            ScreenData(message: 'from-interest', items: items);
                        context.go('/profile', extra: data);
                      },
                      onPressed: () {
                        GoRouter.of(context).pop();
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
                        prefixIcon: items.isNotEmpty
                            ? Wrap(
                                direction: Axis.horizontal,
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: items.map((item) {
                                  int index = items.indexOf(item);
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
    );
  }
}

class ScreenData {
  final String message;
  final List<String> items;

  ScreenData({required this.message, required this.items});
}
