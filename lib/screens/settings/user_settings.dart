import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../providers/theme_notifier.dart';
import '../../utilities/constants/constants.dart';
import 'settings_view_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController nickCtrl = TextEditingController();
  TextEditingController aboutMeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final textTheme = Theme.of(context).textTheme;

    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (s) {
          s.setInitialised(true);
          s.readLocal();
          nickCtrl.text = s.nickname;
          aboutMeCtrl.text = s.aboutMe;
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor:
                theme.darkTheme ? Colors.grey.shade800 : CrColors.primaryColor,
            appBar: AppBar(
              backgroundColor: theme.darkTheme
                  ? CrColors.primaryColor.withOpacity(0.7)
                  : CrColors.secondaryColor,
              title: Text(
                AppConstants.settingsTitle,
                style: textTheme.subtitle2?.copyWith(),
              ),
              centerTitle: true,
            ),
            body: const Text('button'),
          );
        });
  }
}
