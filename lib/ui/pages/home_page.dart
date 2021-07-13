import 'package:flutter/material.dart';
import 'package:jadhub_flutter/res/event_firestore_service.dart';
import 'package:jadhub_flutter/ui/pages/add_event.dart';
import 'package:jadhub_flutter/ui/pages/view_event.dart';
import 'package:jadhub_flutter/utils/color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../model/event.dart';

class HomePage extends StatefulWidget {
  DateTime _selectedDate;
  HomePage(this._selectedDate, {Key key}) : super(key: key);
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

  DateTime _showDate(DateTime selectedDate) {
    if (selectedDate.day == null ||
        selectedDate.month == null ||
        selectedDate.year == null) {
      return selectedDate = DateTime.now();
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Yakin?'),
                content: const Text('Yakin ingin keluar dari aplikasi?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Batal'),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Text('Jadwal DisHub',
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [orangeColors, orangeLightColors],
              //   // begin
              // ),
              color: orangeColors),
        ),
      ),
      // backgroundColor: orangeColors,
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
            }
            widget._selectedDate = _controller.selectedDay;
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
                      // centerHeaderTitle: true,
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
                        // size: 25,
                      ),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events, _) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
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
                            // DateFormat('EEE, MMM d, ''yy' ).format(tgl),
                            // checkDate(DateTime.now()),
                            // DateFormat. ,
                            // widget._selectedDate.toString(),
                            // "${widget._selectedDate.year} - ${widget._selectedDate.month} - ${widget._selectedDate.day}",
                            // style: Theme.of(context).textTheme.headline6
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
                                // "${event.eventDate.year} - ${event.eventDate.month} - ${event.eventDate.day}"
                                DateFormat('yMMMMd').format(event.eventDate),
                              ),
                              trailing: Icon(Icons.edit_sharp),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailsPage(
                                      event: event,
                                    ),
                                  ),
                                );
                              },
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
