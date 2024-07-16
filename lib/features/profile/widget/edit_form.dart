import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class EditForm extends StatefulWidget {
  const EditForm(
      {super.key,
      required this.label,
      this.selectedInputType = 'Text',
      this.hintText,
      this.items,
      this.onChanged,
      this.value,
      this.hint,
      this.astroPrediction = false,
      this.controller,
      this.children,
      this.keyboardType});

  final String label;
  final String selectedInputType;
  final String? hintText;
  final TextEditingController? controller;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;
  final String? value;
  final String? hint;
  final bool? astroPrediction;
  final List<Widget>? children;
  final TextInputType? keyboardType;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  DateTime? selectedDate;

  // Future<void> pickDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: whiteTextStyle7.copyWith(
              fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Card(
          color: ColorManager.greyWithOpacity1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ColorManager.whiteWithOpacity8, // Border color
              width: 1, // Border width
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            width: 202,
            height: 36,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: widget.selectedInputType == 'Text'
                  ? TextFormField(
                      textAlign: TextAlign.right,
                      controller: widget.controller,
                      cursorColor: ColorManager.white,
                      keyboardType: widget.keyboardType,
                      style: widget.astroPrediction == true
                          ? whiteTextStyle7.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none)
                          : whiteTextStyle1.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 10),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle:
                            TextStyle(color: ColorManager.whiteWithOpacity6),
                      ),
                    )
                  : widget.selectedInputType == 'DropDownList'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton(
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.keyboard_arrow_down,
                                      color: ColorManager.white),
                                ),
                                style: whiteTextStyle1.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none),
                                dropdownColor: ColorManager.bg5,
                                underline: Container(),
                                iconSize: 24,
                                value: widget.value,
                                hint: Text(
                                  widget.hint ?? '',
                                  style: whiteTextStyle7.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                items: widget.items,
                                onChanged: widget.onChanged),
                          ],
                        )
                      : widget.selectedInputType == 'PickDate'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: widget.children!
                              // [

                              //   TextButton(
                              //     onPressed: () => pickDate(context),
                              //     child: Text(
                              //       selectedDate == null
                              //           ? 'DD MM YYYY'
                              //           : '${selectedDate!.toLocal()}'
                              //               .split(' ')[0],
                              //       style: selectedDate == null
                              //           ? whiteTextStyle7.copyWith(
                              //               fontWeight: FontWeight.w500,
                              //               fontSize: 13)
                              //           : whiteTextStyle1.copyWith(
                              //               fontWeight: FontWeight.w500,
                              //               fontSize: 13),
                              //     ),
                              //   ),
                              // ],
                              )
                          : Container(),
            ),
          ),
        )
      ],
    );
  }
}
