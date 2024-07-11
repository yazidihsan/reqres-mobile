import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme_manager/color_manager.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: ColorManager.white,
    );
  }
}
