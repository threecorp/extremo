// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:gap/gap.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(t.post)),
      body: SfCalendar(
        view: CalendarView.week,
        allowedViews: const [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
        ],
        allowAppointmentResize: true,
        onAppointmentResizeStart: resizeStart,
        onAppointmentResizeUpdate: resizeUpdate,
        onAppointmentResizeEnd: resizeEnd,
        allowDragAndDrop: true,
        dataSource: MeetingDataSource(_getDataSource()),
        firstDayOfWeek: 1, // Monday
        showNavigationArrow: true,
        timeZone: 'Tokyo Standard Time',
        todayHighlightColor: Colors.red,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        onViewChanged: (ViewChangedDetails details) {
          print("onViewChanged: ${details.visibleDates}");
        },
        onTap: (CalendarTapDetails details) {
          print("onTap: ${details.date}");
        },
        // resourceViewSettings: ResourceViewSettings(showAvatar: true),
      ),
    );
  }

  void resizeStart(
      AppointmentResizeStartDetails appointmentResizeStartDetails) {
    dynamic appointment = appointmentResizeStartDetails.appointment;
    CalendarResource? resource = appointmentResizeStartDetails.resource;
  }

  void resizeUpdate(
      AppointmentResizeUpdateDetails appointmentResizeUpdateDetails) {
    dynamic appointment = appointmentResizeUpdateDetails.appointment;
    DateTime? resizingTime = appointmentResizeUpdateDetails.resizingTime;
    Offset? resizingOffset = appointmentResizeUpdateDetails.resizingOffset;
    CalendarResource? resourceDetails = appointmentResizeUpdateDetails.resource;
  }

  void resizeEnd(AppointmentResizeEndDetails appointmentResizeEndDetails) {
    dynamic appointment = appointmentResizeEndDetails.appointment;
    DateTime? startTime = appointmentResizeEndDetails.startTime;
    DateTime? endTime = appointmentResizeEndDetails.endTime;
    CalendarResource? resourceDetails = appointmentResizeEndDetails.resource;
  }

  List<Meeting> _getDataSource() {
    final meetings = <Meeting>[];
    final today = DateTime.now();
    final startTime = DateTime(today.year, today.month, today.day, 9);
    final endTime = startTime.add(const Duration(hours: 2));

    meetings.add(
      Meeting(
        eventName: 'Conference',
        from: startTime,
        to: endTime,
        background: const Color(0xFF0F8644),
        isAllDay: false,
      ),
    );

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}
