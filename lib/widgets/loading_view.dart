import 'package:circles/utilities/constants/constants.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CrColors.primaryColor.withOpacity(0.8),
        child: Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(CrColors.secondaryColor),
          ),
        ));
  }
}
