import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final String bidang;
  final String present;
  final String absent;
  final DateTime eventDate;

  EventModel({this.id, this.title, this.description, this.eventDate,this.bidang,this.absent,this.present})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDate: data['eventDate'],
      bidang: data['bidang'],
      present: data['present'],
      absent: data['absent'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      bidang: data['bidang'],
      present: data['present'],
      absent: data['absent'],
      eventDate: data['event_date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "bidang": bidang,
      "present": present,
      "absent": absent,
      "event_date": eventDate,
      "id": id,
    };
  }
}
