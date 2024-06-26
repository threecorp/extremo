// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/artifact.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(t.post)),
      // body: SfCalendar(view: CalendarView.month),
      //
      // body: SfCalendar(
      //   view: CalendarView.week,
      //   firstDayOfWeek: 1,
      //   // timeSlotViewSettings: const TimeSlotViewSettings(
      //   //   startHour: 9,
      //   //   endHour: 20,
      //   //   nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
      //   // ),
      // ),
      //
      //
      // body: SfCalendar(
      //   view: CalendarView.month,
      //   monthViewSettings: const MonthViewSettings(showAgenda: true),
      // ),
      //
      //
      body: SfCalendar(
        view: CalendarView.week,
        showNavigationArrow: true,
        allowAppointmentResize: true,
        allowDragAndDrop: true,
        todayHighlightColor: Colors.red,
        firstDayOfWeek: 1, // Monday
        timeZone: 'Tokyo Standard Time',
        dataSource: MeetingDataSource(_getDataSource()),
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
      //
      // body: MyCustomForm(),
    );
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

// class MyCustomForm extends HookConsumerWidget {
//   const MyCustomForm({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
//
//     return FormBuilder(
//       key: formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FormBuilderTextField(
//             name: 'title',
//             decoration: InputDecoration(labelText: t.title),
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(),
//               FormBuilderValidators.maxWordsCount(255),
//             ]),
//           ),
//           FormBuilderTextField(
//             name: 'summary',
//             decoration: InputDecoration(labelText: t.summary),
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(),
//               FormBuilderValidators.maxWordsCount(255),
//             ]),
//           ),
//           FormBuilderTextField(
//             name: 'content',
//             decoration: InputDecoration(labelText: t.content),
//             minLines: 3,
//             maxLines: 10,
//             // validator: FormBuilderValidators.compose([]),
//           ),
//           // FormBuilderTextField(
//           //   name: 'status',
//           //   decoration: InputDecoration(labelText: t.status),
//           //   validator: FormBuilderValidators.compose([
//           //     FormBuilderValidators.required(),
//           //     FormBuilderValidators.maxWordsCount(255),
//           //   ]),
//           // ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Validate and save the form values
//                 if (formKey.currentState?.saveAndValidate() ?? false) {
//                   debugPrint(formKey.currentState?.value.toString());
//                 }
//
//                 // On another side, can access all field values
//                 // without saving form with instantValues
//                 debugPrint(formKey.currentState?.instantValue.toString());
//               },
//               child: const Text('Submit'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
