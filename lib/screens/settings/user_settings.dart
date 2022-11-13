// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

          s.nickname = nickCtrl.text;
          s.aboutMe = aboutMeCtrl.text;
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
            body: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: model.getImage,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: model.avatarImageFile == null
                              ? model.photoUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image.network(
                                        model.photoUrl,
                                        fit: BoxFit.cover,
                                        width: 90.w,
                                        height: 90.h,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.account_circle_outlined,
                                            size: 90.h,
                                            color: Colors.grey.shade300,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Container(
                                                width: 90.w,
                                                height: 90.h,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.grey,
                                                    value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null &&
                                                            loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                ));
                                          }
                                        },
                                      ),
                                    )
                                  : Icon(Icons.account_circle_outlined,
                                      size: 90.h, color: Colors.grey.shade300)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: Image.file(model.avatarImageFile!,
                                      width: 90.w,
                                      height: 90.h,
                                      fit: BoxFit.cover),
                                ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Name",
                                style: textTheme.subtitle2
                                    ?.copyWith(color: CrColors.primaryColor)),
                                    margin: EdgeInsets.only(left:10,bottom:5,top:10),
                          ), 
                          Container( 
                            
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
