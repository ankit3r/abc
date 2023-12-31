import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mpc/values/string_values.dart';

import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/viewmodels/user_view_modal.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:mpc/widgets/darwer.dart';
import 'package:mpc/widgets/homepage_widgets/categories.dart';
import 'package:mpc/widgets/homepage_widgets/image_sliding.dart';
import 'package:mpc/widgets/homepage_widgets/peogram_list.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;

  void getData() {
    context.read<HomeViewModel>().fetchTodayPrograms(context);
    context.read<HomeViewModel>().fetchOnGoingPrograms(context);
    context.read<HomeViewModel>().fetchUpComingPrograms(context);
    context.read<HomeViewModel>().fetchArchivedPrograms(context);
    context.read<HomeViewModel>().fetchAboutUs(context);
    context.read<HomeViewModel>().fetchSliderImages(context);
    context.read<HomeViewModel>().fetchAllCategories(context);
  }

  @override
  void initState() {
    super.initState();
    getData();
    context.read<UserViewModel>().userLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();
    final userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBar(),
      ),
      drawer: const ClipRRect(
          borderRadius: BorderRadius.only(
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
                SingleChildScrollView(
                  child: SafeArea(
                    child: homeViewModel.about.isEmpty
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
                            children: [
                              const SizedBox(height: 30),
                              homeViewModel.category.isNotEmpty
                                  ? RowWithCards(
                                      categroy: homeViewModel.category)
                                  : GestureDetector(
                                      onTap: getData,
                                      child: const Text(
                                        "Retry",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              // const SkeletonList(itemCount: 3),
                              ImageSlider(imageUrls: homeViewModel.imageUrls),

                              Container(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GradientText(
                                            'about_us'.tr(),
                                            style: const TextStyle(
                                              fontFamily: 'Hind',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            colors: const [
                                              Color(0xFFC33764),
                                              Color(0xFF1D2671),
                                            ],
                                            stops: const [0.0, 1],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      homeViewModel.about,
                                      style: const TextStyle(
                                          fontSize: 16, // Set text size
                                          fontWeight: FontWeight.w400,
                                          color: Color(
                                              0xFF797494) // Set font weight
                                          ),

                                      maxLines: homeViewModel.isExpanded
                                          ? 1000
                                          : 3, // Show only three lines if not expanded
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            homeViewModel.isExpanded
                                                ? 'read_less'.tr()
                                                : 'read_more'.tr(),
                                            style: const TextStyle(
                                                color: Color(0xFF797494)),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        homeViewModel.isExpanded =
                                            !homeViewModel.isExpanded;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              EventListCard(
                                eventList: homeViewModel.todayPrograms,
                                program: "today_program".tr(),
                                showProgram: false,
                                isLive: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EventListCard(
                                eventList: homeViewModel.onGoingPrograms,
                                program: "live_program".tr(),
                                showProgram:
                                    userViewModel.userLoginData?.isSuccess ==
                                            true
                                        ? false
                                        : true,
                                isLive: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EventListCard(
                                eventList: homeViewModel.upConingPrograms,
                                program: "upcoming_program".tr(),
                                showProgram: false,
                                isLive: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EventListCard(
                                eventList: homeViewModel.archivedPrograms,
                                program: "archived_program".tr(),
                                showProgram: false,
                                isLive: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
