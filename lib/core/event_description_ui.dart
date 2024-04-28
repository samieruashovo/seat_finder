import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class EventDescriptionPage extends StatefulWidget {
  const EventDescriptionPage({super.key});

  @override
  State<EventDescriptionPage> createState() => _EventDescriptionPageState();
}

class _EventDescriptionPageState extends State<EventDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Artificial Intilligence": 5,
      "Research": 3,
      "Deep Learning": 2,
      "Research Writing": 2,
    };
    final legendLabels = <String, String>{
      "Flutter": "Flutter legend",
      "React": "React legend",
      "Xamarin": "Xamarin legend",
      "Ionic": "Ionic legend",
    };

    final colorList = <Color>[
      const Color(0xff84DD97),
      const Color(0xffE0BE68),
      const Color(0xffE06868),
      const Color(0xff68AEE0),
      const Color(0xff6c5ce7),
    ];
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(8, 16, 43, 1.0),
                Color.fromRGBO(90, 0, 82, 1.0),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(children: [
                Container(
                  // height: 300,

                  // padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.asset(
                        'assets/image_2.png',
                        height: 300,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Celestial Symposium: Exploring \nthe Universe's Mysteries.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21),
                              ),
                            ),
                            // Container(
                            //   height: 50,
                            //   width: 40,
                            //   decoration: BoxDecoration(
                            //     color: const Color.fromARGB(0, 74, 200, 231)
                            //         .withOpacity(0.7),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: const Column(
                            //     children: [
                            //       Text(
                            //         '28',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 18),
                            //       ),
                            //       Text(
                            //         'JAN',
                            //         style: TextStyle(color: Colors.white),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  // height: 50,
                  padding: const EdgeInsets.only(top: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/nav_icon_1.png',
                              // width: 200,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Container(
                          height: 45,
                          width: 157,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 58, 20, 95)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  " My Name",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Container(
                                  width: 72, // Increase the width
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(0, 45, 42, 134)
                                        .withOpacity(1),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    Icons.person_2_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/location_1.png'),
                  ),
                  const Text(
                    "Google Meet",
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/clock_1.png'),
                  ),
                  const Text(
                    "9:00 PM",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 74, 200, 231)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '28',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          'JAN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 20),
                  child: Text(
                    "Category:",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 50,
                  chartRadius: MediaQuery.of(context).size.width / 7.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 35,
                  // centerText: "HYBRID",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 10),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: false,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: Text(
                      "Description",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(child: Container()),
                  Image.asset("assets/chevron_down.png"),
                  Image.asset("assets/chevron_up.png"),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size(300, 50),
                    side: BorderSide(color: Color(0xffB9B0B0)),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Register Now",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ));
  }
}
