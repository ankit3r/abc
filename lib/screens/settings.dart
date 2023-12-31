import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mpc/components/theme_data.dart';
import 'package:mpc/screens/user/user_preferences.dart';
import 'package:mpc/screens/webViewPage/web_view.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';

import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/bottombar.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/custom_container.dart';
import 'package:mpc/widgets/custom_snackbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map<String, bool> toggledStates = {};
  // void _changeLanguage(bool isEnglish) {
  //   final locale = isEnglish ? Locale('en', 'US') : Locale('hi', 'IN');
  //   AppLocalizations.of(context)!.load(locale);
  // }
  late bool isEnglish;
  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().userLogin(context);
    context.read<UserViewModel>().getEmailEnable();
    context.read<UserViewModel>().getSmsEnable();
    // context.read<UserViewModel>().fetchUserProfile(context, 3);
    // Initialize it with a default image path or any other valid initialization.
  }

  void _showDialog(BuildContext context) {
    StringValue.updateValues();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringValue.contactWithUs),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "${StringValue.email} :",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    StringValue.contactEmail,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(
                    const ClipboardData(text: StringValue.contactEmail));
                Navigator.of(context).pop();
                CustomSnackbar.show(context, StringValue.emailCopyDone);
              },
              child: Text(StringValue.copy),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(StringValue.close),
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(bool value) {
    // final locale = isEnglish ? Locale('en', 'US') : Locale('hi', 'IN');
    // AppLocalizations.of(context)!.load(locale);
    // setState(() {
    //   this.isEnglish = !isEnglish; // Corrected line
    // });
    if (value) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('hi', 'IN'));
    }
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final userViewModel = Provider.of<UserViewModel>(context);
    var userData = userViewModel.userModel;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: CustomAppBarSecondary(),
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        child: CustomDrawer(),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/scaffold.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Center(
                    child: GradientText(
                      'settings'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                      colors: const [
                        Color(0xFFC33764),
                        Color(0xFF1D2671),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                  child: Container(
                    height: 74,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.7)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Container(
                            width: 60,
                            child: const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18),
                            child: userViewModel.userLoginData!.isSuccess
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          userData.name ?? 'Name',
                                          style: const TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          userData.email ?? 'Email',
                                          style: const TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserPreferencesScreen()),
                                      );
                                    },
                                    child: Text(
                                      StringValue.logIn,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ))),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                FadePageRoute(
                                  builder: (context) => CustomBottomBar(
                                    selectedIndex: 4,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CustomContainer(
                    text: 'email_notifications'.tr(),
                    icon: Icons.mark_email_unread_outlined,
                    onArrowPressed: () {
                      print('Arrow for Item 1 pressed');
                    },
                    onToggleChanged: (value) {
                      // setState(() {
                      //   toggledStates['Email Notifications'] = value;
                      // });
                      userViewModel.toggleEmail();
                      Future.delayed(const Duration(seconds: 1), () {
                        context.read<UserViewModel>().notificationEnable(
                            context,
                            sms: userViewModel.isSmsEnalbe,
                            email: userViewModel.isEmailEnable,
                            data: userData);
                      });
                    },
                    initialValue: userViewModel.isEmailEnable,
                  ),
                ),
                CustomContainer(
                  text: 'sms_notifications'.tr(),
                  icon: Icons.notifications,
                  onArrowPressed: () {},
                  onToggleChanged: (value) async {
                    // setState(() {
                    //   toggledStates['SMS Notifications'] = value;
                    // });
                    userViewModel.toggleSms();
                    Future.delayed(const Duration(seconds: 1), () {
                      context.read<UserViewModel>().notificationEnable(context,
                          sms: userViewModel.isSmsEnalbe,
                          email: userViewModel.isEmailEnable,
                          data: userData);
                    });
                  },
                  initialValue: userViewModel.isSmsEnalbe,
                ),
                CustomContainer(
                  text: 'dark_mode'.tr(),
                  icon: Icons.dark_mode_outlined,
                  onToggleChanged: (value) {
                    setState(() {
                      toggledStates['Dark Mode'] = value;
                    });
                    themeProvider.toggleTheme();
                    print('Toggle for Dark Mode changed to $value');
                  },
                  initialValue: themeProvider.isDarkMode,
                ),
                CustomLanguageContainer(
                  text: 'english'.tr(),
                  icon: Icons.language_rounded,
                  onToggleChanged: (value) {
                    _changeLanguage(value);
                    setState(() {
                      toggledStates['English'] = value;
                    });
                    themeProvider.toggleLanguage();
                  },
                  initialValue: themeProvider.isEnglish,
                ),
                CustomContainer(
                  text: 'password'.tr(),
                  icon: Icons.lock_outline,
                  showForwardArrow: true,
                  onArrowPressed: () {},
                  initialValue: toggledStates['Password'] ?? false,
                ),
                CustomContainer(
                  text: 'privacy'.tr(),
                  icon: Icons.privacy_tip_outlined,
                  showForwardArrow: true,
                  onArrowPressed: () {
                    Navigator.push(
                        context,
                        FadePageRoute(
                            builder: (context) => const WebViewScreen(
                                  url: StringValue.privicyUrl,
                                )));
                  },
                  initialValue: toggledStates['Privacy'] ?? false,
                ),
                CustomContainer(
                  text: 'support'.tr(),
                  icon: Icons.contact_support_outlined,
                  showForwardArrow: true,
                  onArrowPressed: () {
                    _showDialog(context);
                  },
                  initialValue: toggledStates['Support'] ?? false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//ustomLanguageContainer

class CustomLanguageContainer extends StatefulWidget {
  final String text;
  final IconData icon;
  final ValueChanged<bool>? onToggleChanged;
  final bool initialValue;

  CustomLanguageContainer({
    required this.text,
    required this.icon,
    this.onToggleChanged,
    required this.initialValue,
  });

  @override
  _CustomLanguageContainerState createState() =>
      _CustomLanguageContainerState();
}

class _CustomLanguageContainerState extends State<CustomLanguageContainer> {
  late bool isToggled;
  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomLanguageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        isToggled = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 0),
      child: Container(
        height: 54,
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                gradient: LinearGradient(
                  colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                  stops: [0.0, 1.0],
                  transform: GradientRotation(122.32 * 3.1415927 / 180),
                ),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(widget.text, style: const TextStyle(fontSize: 16)),
            Expanded(child: SizedBox()),
            Transform.scale(
              scale: 0.6,
              child: CupertinoSwitch(
                trackColor: Colors.grey,
                thumbColor: Colors.white70,
                activeColor: Color(0xFFC33764),
                value: isToggled,
                onChanged: (value) {
                  if (widget.onToggleChanged != null) {
                    widget.onToggleChanged!(value);
                  }
                  setState(() {
                    isToggled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
