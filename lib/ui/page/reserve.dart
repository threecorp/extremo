// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReservePage extends HookConsumerWidget {
  const ReservePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingsState = useState<List<Meeting>>([]);

    return Scaffold(
      appBar: AppBar(title: Text(t.reserve)),
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
        // onAppointmentResizeStart: resizeStart,
        // onAppointmentResizeUpdate: resizeUpdate,
        onAppointmentResizeEnd: (AppointmentResizeEndDetails details) {
          if (details.appointment != null && details.startTime != null && details.endTime != null) {
            final updatedMeetings = meetingsState.value.map((meeting) {
              if (meeting.eventName == (details.appointment as Meeting).eventName) {
                // Update the meeting time
                return Meeting(
                  eventName: meeting.eventName,
                  from: details.startTime!,
                  to: details.endTime!,
                  background: meeting.background,
                  isAllDay: meeting.isAllDay,
                );
              }
              return meeting;
            }).toList();

            // Update the state
            meetingsState.value = updatedMeetings;

            // Show a Snackbar notification
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('time updated!'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        },
        allowDragAndDrop: true,
        dataSource: MeetingDataSource(meetingsState.value),
        firstDayOfWeek: 1, // Monday
        showNavigationArrow: true,
        timeZone: 'Tokyo Standard Time',
        todayHighlightColor: Colors.red,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        onViewChanged: (ViewChangedDetails details) {
          debugPrint('onViewChanged: ${details.visibleDates}');
        },
        onTap: (CalendarTapDetails details) {
          final isEdit = details.targetElement == CalendarElement.appointment && details.appointments != null;
          final meeting = isEdit ? details.appointments!.first as Meeting : null;
          final eventName = meeting?.eventName ?? '';
          final startTime = meeting?.from ?? details.date!;
          final endTime = meeting?.to ?? details.date!.add(const Duration(hours: 1));

          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true, // Make the modal full height
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isEdit ? 'Edit Reservation' : 'Add Reservation',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      // Event form for editing
                      Expanded(
                        child: _EventForm(
                          eventName: eventName,
                          startTime: startTime,
                          endTime: endTime,
                          onAdd: (mtg) {
                            if (!isEdit) {
                              meetingsState.value = [...meetingsState.value, mtg];
                            } else {
                              meetingsState.value = meetingsState.value.map((elm) {
                                return elm.eventName == eventName ? mtg : elm;
                              }).toList();
                            }

                            // Show a Snackbar notification
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('"${mtg.eventName}" saved!'),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          debugPrint('onTap: ${details.date}');
        },
        // resourceViewSettings: ResourceViewSettings(showAvatar: true),
      ),
    );
  }
}

class _EventForm extends HookConsumerWidget {
  const _EventForm({
    required this.eventName,
    required this.startTime,
    required this.endTime,
    required this.onAdd,
  });

  final String eventName;
  final DateTime startTime;
  final DateTime endTime;
  final void Function(Meeting) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNameController = useTextEditingController(text: eventName);
    final sTime = useState(startTime);
    final eTime = useState(endTime);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: eventNameController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: sTime.value.toString(),
            decoration: const InputDecoration(labelText: 'Start Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(sTime.value));
              if (selectedTime != null) {
                sTime.value = DateTime(sTime.value.year, sTime.value.month, sTime.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: eTime.value.toString(),
            decoration: const InputDecoration(labelText: 'End Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(eTime.value),
              );
              if (selectedTime != null) {
                eTime.value = DateTime(eTime.value.year, eTime.value.month, eTime.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (eventNameController.text.isNotEmpty) {
                final newMeeting = Meeting(
                  eventName: eventNameController.text,
                  from: sTime.value,
                  to: eTime.value,
                  background: const Color(0xFF0F8644),
                  isAllDay: false,
                );
                onAdd(newMeeting);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource<Meeting> {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
    debugPrint('Appointments initialized: ${appointments?.length}');
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

  @override
  Meeting convertAppointmentToObject(
    Meeting? customData,
    Appointment appointment,
  ) {
    return Meeting(
      eventName: appointment.subject,
      from: appointment.startTime,
      to: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
    );
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

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
