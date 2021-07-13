import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadhub_flutter/model/event.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:intl/intl.dart';

import 'add_event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Agenda', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [orangeColors, orangeLightColors],
              //   // begin
              // ),
              color: Colors.white),
        ),iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              // final confirm = await
              showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Peringatan!',
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text('Yakin ingin menghapus agenda ini?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, "OK"),
                      child: Text('Hapus', style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, "OK"),
                      child: Text('Batal'),
                    ),
                  ],
                ),
              );
              // ??
              //     false;
              // if (confirm) {
              //   // await eventDBS.removeItem(event.id);
              //   // Navigator.pop(context);
              // }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.edit_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEventPage(
                          note: event,
                        ))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              alignment: Alignment.bottomLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: orangeColors,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    event.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat('EEEE, MMMM d, h:mm a').format(event.eventDate),
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bidang',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  event.bidang,
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kesimpulan',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    event.description,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kehadiran :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Text("  " + event.present + " Hadir"),
                Text("  " + event.absent + " Tidak Hadir"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
