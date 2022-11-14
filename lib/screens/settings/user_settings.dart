// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:circles/widgets/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../models/models.dart';
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
          // log(s.toString());d
          log(".........${s.nickname}");
          log(s.aboutMe);
          log(nickCtrl.text);
     
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
                              ? model.photoUrl.toString().isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image.network(
                                        model.photoUrl.toString(),
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
                            margin: const EdgeInsets.only(
                                left: 10, bottom: 5, top: 10),
                            child: Text("Name",
                                style: textTheme.subtitle2
                                    ?.copyWith(color: CrColors.secondaryColor)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  primaryColor: CrColors.secondaryColor),
                              child: TextFormField(
                                style: textTheme.subtitle1
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CrColors.secondaryColor),
                                    ),
                                    hintText: "Write your name",
                                    hintStyle: textTheme.headline6?.copyWith(),
                                    contentPadding: const EdgeInsets.all(5)),
                                controller: nickCtrl,
                                // onChanged: (value) {
                                //   model.nickname = value;

                                //   // model.setName(value);
                                // },
                                focusNode: model.focusNickname,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, bottom: 5, top: 30),
                            child: Text("About me",
                                style: textTheme.subtitle2
                                    ?.copyWith(color: CrColors.secondaryColor)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  primaryColor: CrColors.secondaryColor),
                              child: TextFormField(
                                style: textTheme.subtitle1
                                    ?.copyWith(color: Colors.grey),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CrColors.secondaryColor),
                                    ),
                                    hintText:
                                        "Write something about yourself..",
                                    hintStyle: textTheme.headline6?.copyWith(),
                                    contentPadding: const EdgeInsets.all(5)),
                                controller: aboutMeCtrl,
                                // onChanged: (value) {
                                //   model.aboutMe = value;
                                //   // model.setAboutMe(value);
                                // },
                                focusNode: model.focusAboutMe,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, bottom: 0, top: 30),
                            child: Text(" Phone No",
                                style: textTheme.subtitle2
                                    ?.copyWith(color: CrColors.secondaryColor)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  primaryColor: CrColors.secondaryColor),
                              child: TextField(
                                style: textTheme.subtitle1
                                    ?.copyWith(color: Colors.grey),
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText: model.phoneNumber,
                                    hintStyle: textTheme.headline6?.copyWith(),
                                    contentPadding: const EdgeInsets.all(5)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 30, bottom: 5),
                            child: SizedBox(
                                width: 100.w,
                                height: 60.h,
                                child: CountryCodePicker(
                                  onChanged: (country) {
                                    // model.dialoCodedigits = country.dialCode!;
                                    model.setdialCodes(country.dialCode);
                                  },
                                  initialSelection: "NG",
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  favorite: const ["+1", "US", "+234", "NG"],
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: TextField(
                              style: textTheme.subtitle1
                                  ?.copyWith(color: Colors.grey),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: CrColors.secondaryColor),
                                  ),
                                  hintText: "Phone Number",
                                  hintStyle: textTheme.headline6?.copyWith(),
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(model.dialoCodedigits),
                                  )
                                  // contentPadding: const EdgeInsets.all(5)
                                  ),
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                              controller: model.pController,
                            ),
                          ),
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 50, bottom: 50),
                              child: TextButton(
                                  onPressed: model.handleUpdateData,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              CrColors.secondaryColor
                                                  .withOpacity(0.6))),
                                  child: const Text("Update Now")),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: model.isloading
                      ? const LoadingView()
                      : const SizedBox.shrink())
            ]),
          );
        });
  }
}
