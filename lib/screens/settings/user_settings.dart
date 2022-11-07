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
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (s) {
          s.setInitialised(true);
          
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor:
                theme.darkTheme ? Colors.grey.shade800 : CrColors.primaryColor,
          );
        });
  }
}
