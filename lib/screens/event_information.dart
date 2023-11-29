import 'package:flutter/material.dart';
import 'package:mpc/data/models/event_model.dart';
import 'package:mpc/values/string_values.dart';
import 'package:mpc/viewmodels/homeviewmodel/home_view_model.dart';
import 'package:mpc/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventInformationScreen extends StatefulWidget {
  final EventData eventData;
  const EventInformationScreen({super.key, required this.eventData});

  @override
  State<EventInformationScreen> createState() => _EventInformationScreenState();
}

class _EventInformationScreenState extends State<EventInformationScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeViewModel>()
        .fetchSingleProgram(context, widget.eventData.id!);
  }

  @override
  Widget build(BuildContext context) {
    StringValue.updateValues();
    final homeViewModel = context.watch<HomeViewModel>();

    var data = homeViewModel.singleProgram;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: CustomAppBarSecondary(),
      ),
      body: homeViewModel.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 228,
                    child: Image.asset(
                      'assets/EventHeader.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 16, right: 16, top: 10),
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: Row(
                        //       children: List.generate(
                        //         6,
                        //         (index) => Container(
                        //           width: MediaQuery.of(context).size.width /
                        //               5.096, // Adjust the width as needed
                        //           height: MediaQuery.of(context).size.height /
                        //               31.583,

                        //           margin: const EdgeInsets.only(
                        //               right:
                        //                   16), // Add margin between containers
                        //           decoration: BoxDecoration(
                        //             color: const Color(0xFFCE6ED1),
                        //             borderRadius: BorderRadius.circular(8),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               "MusicShow $index",
                        //               style: const TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        GradientText(
                          data.programCategory ??
                              "NA", //वर्तमान मैं संचालित हो रहे कार्यक्रम
                          style: const TextStyle(
                            fontFamily: 'Hind',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          colors: const [Color(0xFFC33764), Color(0xFF1D2671)],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GradientText(
                                  data.programName ??
                                      "NA", //वर्तमान मैं संचालित हो रहे कार्यक्रम
                                  style: const TextStyle(
                                    fontFamily: 'Hind',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                  colors: const [
                                    Color(0xFFC33764),
                                    Color(0xFF1D2671)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${data.startingDate ?? "NA"} at ${data.startingTime ?? "NA"}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${data.city ?? "NA"},${data.district ?? "NA"}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("View on Maps",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFA01B8A))),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // MoreInfo
                  Divider(
                    color: Colors.grey.withOpacity(0.6),
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 10,
                    ),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "More Information",
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 35.61,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 25,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 70,
                                child: Text(
                                  "कलाकार:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.eventData.artists?[0].name ??
                                    "NA", // "भारत की लोकभारत की लोक.....",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 2),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                child: Text(
                                  "कला प्रकार:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                // "शिव केन्द्रित भक्ति गायन",
                                data.programType ?? "NA",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 2),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                child: Text(
                                  "प्रवेश :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data.entryType ?? "NA",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 2),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                child: Text(
                                  "वेणु:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  // "शैव ज्ञान परंपरा से उद्भूत कलाओं पर एकाग्र साप्ताहित श्रंखला अनादि के अन्तर्गत इस रविवार शिव केन्द्रित भक्ति गायन की प्रस्तुति ।",
                                  data.venu ?? "NA",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.50,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.6),
                    thickness: 0.5,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Container(
                  //       height: 1.550,
                  //       width: MediaQuery.of(context).size.width,
                  //       child: Column(
                  //         children: [
                  //           Align(
                  //             alignment: Alignment.centerLeft,
                  //             child: Container(
                  //               width:
                  //                   MediaQuery.of(context).size.width * 0.75467,
                  //               child: Text(
                  //                 "Click on interested to stay update about this event",
                  //                 textScaleFactor: 0.9,
                  //                 style: TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: Colors.grey[800]),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 1.50,
                  //           ),
                  //           Align(
                  //             alignment: Alignment.topLeft,
                  //             child: Container(
                  //               padding: EdgeInsets.all(4),
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   color: Color(0xFFE91E63).withOpacity(0.6),
                  //                   width: 1,
                  //                 ),
                  //                 borderRadius: BorderRadius.circular(4),
                  //                 // color: Color(0xFFE91E63).withOpacity(0.1),
                  //               ),
                  //               child: Text(
                  //                 'Interested?',
                  //                 style: TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: Color(0xFFE91E63)),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 1.50,
                  //           ),
                  //           Align(
                  //             alignment: Alignment.topLeft,
                  //             child: Text(
                  //               "50+ People have shown interest recently",
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.grey[600]),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Divider(
                  //   color: Colors.grey.withOpacity(0.6),
                  //   thickness: 0.5,
                  // ),
                  // Container(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 16),
                  //     child: Column(
                  //       children: [
                  //         Align(
                  //           alignment: Alignment.topLeft,
                  //           child: Text(
                  //             'Artist',
                  //             style: TextStyle(
                  //                 fontSize: 24,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Color(0xFF000000)),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 0, right: 16, top: 10),
                  //           child: SingleChildScrollView(
                  //             scrollDirection: Axis.horizontal,
                  //             child: Row(
                  //               children: List.generate(
                  //                 6,
                  //                 (index) => Padding(
                  //                   padding: const EdgeInsets.only(right: 16),
                  //                   child: Column(
                  //                     children: [
                  //                       Container(
                  //                         height: 1.512,
                  //                         width: 112,
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10),
                  //                         ),
                  //                         child: Image.asset(
                  //                             "assets/Artist.jpg",
                  //                             fit: BoxFit.cover),
                  //                       ),
                  //                       Text(
                  //                         "सुश्री नवधा",
                  //                         maxLines: 1,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.w500,
                  //                           color: Color(0xFF000000),
                  //                         ),
                  //                       ),
                  //                       Text(
                  //                         "सुश्री नवधा त्रिवेणी कला",
                  //                         maxLines: 1,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: TextStyle(
                  //                           fontSize: 10,
                  //                           fontWeight: FontWeight.w500,
                  //                           color: Color(0xFF000000),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringValue.about,
                            style: const TextStyle(
                                fontSize: 24,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 1.50,
                        ),
                        Text(
                          data.about ?? "NA",
                          style: const TextStyle(
                              fontSize: 16, // Set text size
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF797494) // Set font weight
                              ),

                          maxLines: homeViewModel.isExpanded
                              ? 1000
                              : 3, // Show only three lines if not expanded
                          overflow: TextOverflow.ellipsis,
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                homeViewModel.isExpanded
                                    ? 'Read Less'
                                    : 'Read More',
                                style:
                                    const TextStyle(color: Color(0xFF952766)),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            StringValue.artistName,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 16, top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  widget.eventData.artists?.length ?? 0,
                                  (index) {
                                var data = widget.eventData.artists?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 158,
                                        width: 158,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.asset("assets/Artist.jpg",
                                            fit: BoxFit.cover),
                                      ),
                                      Text(
                                        data?.name ?? "NA",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF000000)),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            StringValue.gallery,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 16, top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 158,
                                        width: 158,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.asset("assets/Artist.jpg",
                                            fit: BoxFit.cover),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23)
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
