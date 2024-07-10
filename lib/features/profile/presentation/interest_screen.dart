import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_input_list.dart';
import 'package:reqres/common_widget/custom_text.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';
import 'package:flutter/services.dart';
import 'package:textfield_tags/textfield_tags.dart';

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
  late double _distanceToField;
  final _stringTagController = StringTagController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _stringTagController = StringTagController();
  // }
  @override
  void initState() {
    super.initState();
    controller.addListener(_moveCursorToEnd);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_moveCursorToEnd);
    _stringTagController.dispose();
  }

  void _moveCursorToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int textLength = controller.text.length;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: textLength),
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
                    TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorManager.whiteWithOpacity4,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide.none),
                            prefixIconConstraints: const BoxConstraints(
                              maxWidth: double.infinity,
                            ),
                            prefixIcon: items.isNotEmpty
                                ? Wrap(
                                    // direction: Axis.horizontal,
                                    spacing: 4.0,
                                    runSpacing: 4.0,
                                    children: items.map((item) {
                                      int index = items.indexOf(item);
                                      return Card(
                                        color: ColorManager.whiteWithOpacity9,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                item,
                                                style: whiteTextStyle1.copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: ColorManager.white,
                                              ),
                                              onPressed: () =>
                                                  _removeItem(index),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : null),
                        onSubmitted: (value) {
                          _moveCursorToEnd();
                          _addItem(value);
                        }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
