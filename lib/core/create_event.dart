// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

import 'package:seat_finder/api_endpoints.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  File? _selectedImage;
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();
  final TextEditingController _eventCityController = TextEditingController();
  final TextEditingController _eventCapacityController =
      TextEditingController();
  final TextEditingController _eventPriceController = TextEditingController();
  final TextEditingController _eventPasswordController =
      TextEditingController();
  final TextEditingController _eventLinkController = TextEditingController();
  // final TextEditingController _eventSpeakerController1 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController2 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController3 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController4 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController5 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController6 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController7 =
  //     TextEditingController();
  // final TextEditingController _eventSpeakerController8 =
  //     TextEditingController();
  final TextEditingController _eventTagsController = TextEditingController();
  final TextEditingController _eventHostController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      setState(() {
        selectedDate = pickedDate;
      });
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      setState(() {
        selectedTime = pickedTime;
      });
    }

    // Future<void> _selectDate(BuildContext context) async {
    //   final DateTime? picked = await showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(2000),
    //     lastDate: DateTime(2101),
    //   );
    //   if (picked != null && picked != selectedDate)
    //     setState(() {
    //       selectedDate = picked;
    //     });
    // }

    Future<File?> pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery); // Or ImageSource.camera
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
      return null;
    }

    // Future<void> sendPostRequestWithFile(var file) async {
    //   final url = Uri.parse(
    //       '${ApiEndPoints.baseUrl}api/events/'); // Replace with your API endpoint

    //   // Prepare the multipart request
    //   var request = http.MultipartRequest('POST', url);

    //   // Add text fields
    //   request.fields['name'] = 'Event Name2';
    //   request.fields['description'] = 'Event Description2';
    //   request.fields['link'] = 'http://eventlink.com';
    //   request.fields['date'] = '2024-06-05T21:00:00Z';
    //   request.fields['location'] = 'Event Location';
    //   request.fields['city'] = 'City Name';
    //   request.fields['capacity'] = '100';
    //   request.fields['isPrivate'] = 'false';
    //   request.fields['pkey'] = '12345';
    //   request.fields['hasFee'] = 'true';
    //   request.fields['entryFee'] = '10.00';
    //   request.fields['host'] = 'Host Name';
    //   request.fields['tags'] = 'tag1, tag2, tag3';

    //   // Add file

    //   print(file);
    //   request.files.add(await http.MultipartFile.fromPath('thumb', file,
    //       filename: basename(file)));
    //   print(request.fields);
    //   // Send the request
    //   final response = await request.send();

    //   if (response.statusCode == 200) {
    //     print('Request successful!');
    //   } else {
    //     print('Request failed with status: ${response.statusCode}');
    //   }
    // }

    Future<void> createPostWithImage(
        File file,
        String name,
        String description,
        String link,
        String location,
        String city,
        String capacity,
        String isPrivate,
        String pKey,
        String hasFee,
        String entryFee,
        String host,
        String tags) async {
      final url = Uri.parse(
          '${ApiEndPoints.baseUrl}api/events/'); // Replace with your API endpoint
      print(selectedDate);
      print(selectedTime);
      DateTime combinedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      String formattedDateTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(combinedDateTime);
      print(formattedDateTime);
      // Prepare the multipart request
      var request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      // Add text fields
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['link'] = link;
      request.fields['date'] = formattedDateTime;
      request.fields['location'] = location;
      request.fields['city'] = city;
      request.fields['capacity'] = capacity;
      request.fields['isPrivate'] = isPrivate;
      request.fields['pkey'] = pKey;
      request.fields['hasFee'] = hasFee;
      request.fields['entryFee'] = entryFee;
      request.fields['host'] = host;
      request.fields['tags'] = tags;

      // Add file
      request.files.add(await http.MultipartFile.fromPath('thumb', file.path,
          filename: basename(file.path)));
      print(request.fields);
      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Registration Successful'),
                content: const Text('User has been registered successfully.'),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Registration unsuccessful'),
                content: Text("Error Code: ${response.statusCode}"),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
        print('Request failed with status: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: 1050,
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
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Post an Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event Name",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => pickImage(),
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9225B9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xff67438C),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Choose File",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff9225B9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: _selectedImage.isNull
                              ? Text("No file chosen",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ))
                              : Text(_selectedImage!.path.split('/').last,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventDescriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event Description",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventLocationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event Location",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff67438C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _eventCityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        labelText: "City",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff67438C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _eventCapacityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        labelText: "Event Capacity",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      height: 55,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff67438C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          selectedDate == null
                              ? 'Select Date'
                              : DateFormat('yyyy-MM-dd').format(selectedDate!),
                          style: const TextStyle(color: Colors.white),

                          // child: TextField(
                          //   style: const TextStyle(color: Colors.white),
                          //   controller: _eventDateController,
                          //   decoration: const InputDecoration(
                          //     border: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(10.0))),
                          //     labelText: "Event Date",
                          //     labelStyle: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: Container(
                      height: 55,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff67438C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          selectedTime == null
                              ? 'Select Time'
                              : selectedTime!.format(context),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      // child: TextField(
                      //   style: const TextStyle(color: Colors.white),
                      //   controller: _eventTimeController,
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(10.0))),
                      //     labelText: "Event Time",
                      //     labelStyle: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventPriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Ticket Price",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event Password",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventLinkController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event-Link",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventHostController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Event host",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _eventTagsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Tags",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController2,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 2",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController3,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 3",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController4,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 4",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController5,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 5",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController6,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 6",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController7,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 7",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController8,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 8",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 55,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     style: const TextStyle(color: Colors.white),
              //     controller: _eventSpeakerController9,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: "Speaker name 9",
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                height: 47,
                width: 327,
                margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff51822B),
                      Color(0xff636066),
                      Color(0xff753BA2),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // File? image = await pickImage();

                    await createPostWithImage(
                        _selectedImage!,
                        _eventCityController.text,
                        _eventDescriptionController.text,
                        _eventLinkController.text,
                        // _eventDateController.text,
                        _eventLocationController.text,
                        _eventCityController.text,
                        _eventCapacityController.text,
                        'false',
                        '12345',
                        'true',
                        _eventPriceController.text,
                        _eventHostController.text,
                        _eventTagsController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 0),
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                  child: const Text(
                    'Post Event',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
