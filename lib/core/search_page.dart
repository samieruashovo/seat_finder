import 'package:flutter/material.dart';

import '../api_services.dart';
import '../models/events.dart';
import 'event_description_ui.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Event>>? futureEvents;
  List<Event> events = [];
  List<Event> _filteredEvents = [];
  @override
  void initState() {
    futureEvents = ApiServices().fetchEvents();
    _fetchEvents();

    super.initState();
  }

  Future<void> _fetchEvents() async {
    // Simulating fetching events from an API
    List<Event>? fetchedEvents = await futureEvents;
    print(fetchedEvents!.length.toString() + "aabb");
    setState(() {
      events = fetchedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text("Search Events",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  // print(events.length.toString() + "aa");
                  // Filter events based on the search query
                  var filteredEvents = events
                      .where((event) => event.link
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();

                  // Update the UI with the filtered events
                  setState(() {
                    _filteredEvents = filteredEvents;
                    print(_filteredEvents.length);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintText: 'Search events...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = _filteredEvents[index];
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    margin: const EdgeInsets.all(40),
                    // height: 200,
                    // width: 700,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EventDescriptionPage(
                                  event: event,
                                )));
                      },
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.network(event.thumb),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.3, // set width according to your requirement
                                    child: Text(
                                      event.name,
                                      textAlign: TextAlign.justify,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      maxLines:
                                          null, // or specify the maximum number of lines you want
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(0, 74, 200, 231)
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        event.date.split('-')[1].toUpperCase(),
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
            ),
          ],
        ),
      ),
    );
  }
}
