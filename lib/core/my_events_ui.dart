import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seat_finder/core/registered_event_description_ui.dart';

import '../api_services.dart';
import '../controllers/api/api_controller.dart';
import '../models/events.dart';
import 'event_description_ui.dart';

class MyEvents extends StatefulWidget {
  MyEvents({super.key});
  List<Event> myEventsList = [];
  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  // ApiController apiController = Get.put(ApiController());
  late Future<dynamic> myEvents;
  late Future<List<Event>> allEventsList;

  // Future<void> filterEventsByUserId(List<Event> events, int userId) async {
  //   print("running");
  //   myEventsList = events.where((event) => event.id == userId).toList();
  //   print(myEventsList);
  //   print("sll");
  // }
  List<Event> removeDuplicatesById(List<Event> events) {
    Set<int> ids = Set<int>(); // Set to store unique event ids
    List<Event> uniqueEvents = []; // List to store unique events

    for (Event event in events) {
      // If the id is not in the set, add the event to the unique events list
      if (!ids.contains(event.id)) {
        uniqueEvents.add(event);
        ids.add(event.id); // Add the id to the set to mark it as seen
      }
    }

    return uniqueEvents;
  }

  Future<List<Event>> fetchEventData() async {
    print("sssdereee");
    // print(removeDuplicatesById(widget.myEventsList));
    return removeDuplicatesById(widget.myEventsList);
  }

  void getAllEvents() async {
    myEvents = ApiServices().fetchMyEvents(8);
    allEventsList = ApiServices().fetchEvents();
    List<Event> events = await allEventsList;

    for (Event event in events) {
      myEvents.then((value) => value.forEach((element) {
            // print(element);
            if (event.id == element['event']) {
              widget.myEventsList.add(event);
//first print
              // print(myEventsList);
            }
          }));
    }
    //second print
    // print(myEventsList);
  }

  @override
  initState() {
    super.initState();
    print("aaa");

    // myEvents.then((value) => value.forEach((element) {
    //       print(element);
    //     }));
    // print(allEventsList);
    getAllEvents();
    print("bbb");
    // print(myEventsList);
    // allEventsList.then((events) {
    //   filterEventsByUserId(events, 8);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("wpeo");
    // print(widget.myEventsList);
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
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Registered Events',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<Event>>(
                future:
                    fetchEventData(), // Assuming myEvents is your list of events and userId is the id you want to filter by
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      'No events found',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Event event = snapshot.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterdEventDescriptionPage(
                                    event: event,
                                  ),
                                ));
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.network(event.thumb),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      event.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    0, 74, 200, 231)
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                event.date
                                                    .split('-')[2]
                                                    .substring(0, 2),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                event.date
                                                    .split('-')[1]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
