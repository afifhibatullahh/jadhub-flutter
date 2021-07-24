import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jadhub_flutter/res/event_firestore_service.dart';
import 'package:jadhub_flutter/ui/pages/add_event.dart';
import 'package:jadhub_flutter/ui/pages/main_drawer.dart';
import 'package:jadhub_flutter/ui/pages/view_event.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../model/event.dart';
import 'package:flutter_session/flutter_session.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DateTime tgl;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('Jadwal DisHub',
            style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: orangeColors),
        ),
      ),
      drawer: MainDrawer(),
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.week,
                    calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: orangeColors,
                      selectedColor: orangeLightColors,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                            color: orangeColors,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        weekendStyle: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: orangeColors,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left_rounded,
                        color: orangeColors,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right_rounded,
                        color: orangeColors,
                      ),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events, _) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) =>
                          Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: orangeColors,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                      todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: orangeLightColors,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    calendarController: _controller,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [orangeColors, Colors.blue[100]],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        ListTile(
                          title: Text(
                            'Agenda',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ..._selectedEvents.map(
                          (event) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: ListTile(
                              title: Text(event.title),
                              subtitle: Text(
                                DateFormat.Hm().format(event.eventDate),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings:
                                        RouteSettings(name: "/homePage"),
                                    builder: (context) => EventDetailsPage(
                                      event: event,
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.edit_sharp),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEventPage(
                                      note: event,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Tambah Agenda'),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddEventPage())),
      ),
    );
  }
}
