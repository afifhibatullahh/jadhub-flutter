import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadhub_flutter/model/event.dart';
import 'package:jadhub_flutter/model/menu_item.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:intl/intl.dart';
import 'package:jadhub_flutter/res/event_firestore_service.dart';
import 'package:jadhub_flutter/utils/menu_items.dart';
import 'package:share/share.dart';

import 'add_event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _accept() {
      Navigator.pop(context, true); // dialog returns true
    }

    void _notAccept() {
      Navigator.pop(context, false); // dialog returns false
    }

    PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(item.text),
            ],
          ),
        );

    void onSelected(BuildContext context, MenuItem item) async {
      switch (item) {
        case MenuItems.itemDelete:
             {
            final confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Peringatan!',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: Text('Yakin ingin menghapus agenda ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => _accept(),
                        child:
                            Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () => _notAccept(),
                        child: Text('Batal'),
                      ),
                    ],
                  ),
                ) ??
                false;
            if (confirm) {
              await eventDBS.removeItem(event.id);
              Navigator.pop(context);
            }
          };
          break;
        case MenuItems.itemEdit:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventPage(
                note: event,
              ),
            ),
          );
          break;
        case MenuItems.itemShare:
        var eventdate =  DateFormat('EEEE, MMMM d, h:mm a').format(event.eventDate);
          await Share.share('Agenda Pada ${eventdate}.\nmengenai ${event.title}  diharapkan peserta dapat menghadiri acara tersebut');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Agenda',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    ...MenuItems.itemsFirst.map(buildItem).toList(),
                  ])
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
                Text(
                  'Kehadiran :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
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
