import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/screens/academies_information_screen.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/animation_page_route.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AcademiesPage extends StatefulWidget {
  const AcademiesPage({super.key});

  @override
  State<AcademiesPage> createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  void getData() {
    context.read<HomeViewModel>().fetchAllAcadmiec(context);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int selectedTabIndex = 1;
  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBar(),
        ),
        drawer: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            child: CustomDrawer()),
        body: homeViewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Opacity(
                    opacity: 0.05,
                    child: Image.asset(
                      'assets/scaffold.jpg',
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 30),
                    child: homeViewModel.academiesList.isEmpty
                        ? SizedBox(
                            height: 600,
                            child: Center(
                              child: Column(children: [
                                GestureDetector(
                                  onTap: getData,
                                  child: const Text(
                                    "Retry",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GradientText(
                                'academy'.tr(),
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                                colors: const [
                                  Color(0xFFC33764),
                                  Color(0xFF1D2671),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: // Inside your ListView.builder
                                      ListView.builder(
                                itemCount: homeViewModel.academiesList.length,
                                itemBuilder: (context, index) {
                                  // Dummy data for illustration
                                  var data = homeViewModel.academiesList[index];
                                  String eventName =
                                      data.deptName!; //'संस्कृति संचालनालय';
                                  String eventDescription =
                                      data.deptDesignation!;
                                  //'माननीय राष्ट्रपति श्रीमती द्रौपदी मुर्मू 3 अगस्त, 2023 को सुबह 11:30 बजे भोपाल स्थित........';

                                  // Generate random color
                                  List<Color> colorList = const [
                                    Color(0xFF9750DB),
                                    Color(0xFFD94D33),
                                    Color(0xFF029CE2),
                                    Color(0xFFFFB425),
                                    Color(0xFFD361BA),
                                  ];

                                  // Randomly choose a color from the list
                                  Color repeatColor =
                                      colorList[index % colorList.length];

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              FadePageRoute(
                                                builder: (context) =>
                                                    AcademiesInformationScreen(
                                                        acd: data),
                                              ));
                                        },
                                        child: Container(
                                          height: 134,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 27, bottom: 20),
                                          decoration: BoxDecoration(
                                            color:
                                                repeatColor, // Use the random color
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      eventName,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      eventDescription,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 2,
                                                child: data.deptImage != null
                                                    ? Image.network(
                                                        data.deptImage ?? "NA",
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Image.asset(
                                                            'assets/school.png',
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                      )
                                                    : Image.asset(
                                                        'assets/school.png',
                                                        height: 64,
                                                        width: 64,
                                                      ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              )),
                            ],
                          ),
                  ),
                ],
              ));
  }
}
