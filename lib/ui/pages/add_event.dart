import 'package:jadhub_flutter/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jadhub_flutter/model/message.dart';
import 'package:jadhub_flutter/model/messaging.dart';
import 'package:jadhub_flutter/res/event_firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:jadhub_flutter/utils/color.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;

  const AddEventPage({Key key, this.note}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController _title;
  TextEditingController _description;
  TextEditingController _bidang;
  TextEditingController _present;
  TextEditingController _absent;
  final List<Message> messages = [];
  
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _bidang = TextEditingController(
        text: widget.note != null ? widget.note.bidang : "");
    _present = TextEditingController(
        text: widget.note != null ? widget.note.present : "");
    _absent = TextEditingController(
        text: widget.note != null ? widget.note.absent : "");
    _eventDate = DateTime.now();
    processing = false;
    // _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    // _firebaseMessaging.getToken();

    // _firebaseMessaging.subscribeToTopic('all');

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     final notification = message['notification'];
    //     setState(() {
    //       messages.add(Message(
    //           title: notification['title'], body: notification['body']));
    //     });
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");

    //     final notification = message['data'];
    //     setState(() {
    //       messages.add(Message(
    //         title: '${notification['title']}',
    //         body: '${notification['body']}',
    //       ));
    //     });
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Sunting Agenda" : "Tambah Agenda",
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [orangeColors, orangeLightColors],
              //   // begin
              // ),
              color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                      (value.isEmpty) ? "Masukan Nama Acara" : null,
                  decoration: InputDecoration(
                    labelText: "Nama Acara",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.7)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pilih Tanggal dan Waktu',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(_eventDate.year - 5),
                            maxTime: DateTime(_eventDate.year + 5),
                            currentTime: _eventDate,
                            locale: LocaleType.id,
                            onConfirm: (date) {
                              setState(() {
                                _eventDate = date;
                              });
                            },
                          );
                        },
                        child: Text(
                          // '${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day} - ${_eventDate.hour}:${_eventDate.minute}',
                          DateFormat('EEE, MMM d, h:mm a').format(_eventDate),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.4)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _bidang,
                  validator: (value) =>
                      (value.isEmpty) ? "Masukan Nama bidang" : null,
                  decoration: InputDecoration(
                      labelText: "Bidang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                      (value.isEmpty) ? "Tolong Masukan Kesimpulan" : null,
                  decoration: InputDecoration(
                      labelText: "Kesimpulan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _present,
                  validator: (value) =>
                      (value.isEmpty) ? "Masukan Jumlah Kehadiran" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Jumlah Hadir",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _absent,
                  validator: (value) =>
                      (value.isEmpty) ? "Masukan Jumlah Kehadiran" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Jumlah Tidak Hadir",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        color: orangeColors,
                        shadowColor: orangeColors,
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                processing = true;
                              });
                              if (widget.note != null) {
                                await eventDBS.updateData(widget.note.id, {
                                  "title": _title.text,
                                  "description": _description.text,
                                  "event_date": _eventDate,
                                  "bidang": _bidang.text,
                                  "present": _present.text,
                                  "absent": _absent.text,
                                });
                              } else {
                                await eventDBS.createItem(EventModel(
                                    title: _title.text,
                                    description: _description.text,
                                    bidang: _bidang.text,
                                    present: _present.text,
                                    absent: _absent.text,
                                    eventDate: _eventDate));
                              }
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                            }
                            // sendNotification();
                          },
                          child: Text(
                            "SIMPAN",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
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

// Future sendNotification() async {
//     final response = await Messaging.sendToAll(
//       title: _title.text,
//       body: _eventDate.toString(),
//       // fcmToken: fcmToken,
//     );

//     if (response.statusCode != 200) {
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content:
//             Text('[${response.statusCode}] Error message: ${response.body}'),
//       ));
//     }
//   }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  // void sendTokenToServer(String fcmToken) {
  //   print('Token: $fcmToken');
  //   // send key to your server to allow server to use
  //   // this token to send push notifications
  // }
}
