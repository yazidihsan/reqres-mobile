import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reqres/common_widget/custom_appbar.dart';
import 'package:reqres/common_widget/custom_bg_page.dart';
import 'package:reqres/common_widget/custom_input_list.dart';
import 'package:reqres/common_widget/custom_text.dart';
import 'package:reqres/theme_manager/color_manager.dart';
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
                    Container(
                      constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                          maxWidth: double.infinity),
                      decoration: BoxDecoration(
                          color: ColorManager.whiteWithOpacity4,
                          borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: items.isEmpty ? 0 : 2,
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 4.0,
                                    children: items.map((item) {
                                      int index = items.indexOf(item);
                                      return SizedBox(
                                        child: Card(
                                          color: ColorManager.bg3,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(item),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () =>
                                                    _removeItem(index),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(width: 1),
                                Expanded(
                                  flex: items.isEmpty ? 8 : 2,
                                  child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      labelText: 'Enter item',
                                      border: OutlineInputBorder(),
                                    ),
                                    onSubmitted: _addItem,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
