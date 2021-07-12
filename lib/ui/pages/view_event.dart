import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadhub_flutter/model/event.dart';
import 'package:jadhub_flutter/res/event_firestore_service.dart';
import 'package:jadhub_flutter/ui/pages/home_page.dart';

import 'add_event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Agenda'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () async {
              final confirm = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Peringatan!', style: TextStyle(color: Colors.red),),
                      content: Text('Yakin ingin menghapus agenda ini?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Hapus', style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
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
            },
          ),
          IconButton(
            icon: Icon(
              Icons.edit_sharp,
              color: Colors.white,
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
            Text(
              event.title,
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(height: 20.0),
            Text(event.description),
            Text(event.absent),
            Text(event.present),
            Text(event.bidang),
          ],
        ),
      ),
    );
  }
}
