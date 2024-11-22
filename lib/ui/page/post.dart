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

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingsState = useState<List<Meeting>>([]);

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
              SnackBar(
                content: Text(
                  'Meeting "${(details.appointment as Meeting).eventName}"'
                  'updated!',
                ),
                duration: const Duration(
                  seconds: 5,
                ), // Notification disappears after 5 seconds
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
                          meeting: meeting,
                          onSave: (mtg) {
                            if (isEdit) {
                              debugPrint('edit: ${mtg.eventName}');
                              // Update the selected meeting
                              final updatedMeeting = Meeting(
                                eventName: mtg.eventName,
                                from: mtg.from,
                                to: mtg.to,
                                background: mtg.background,
                                isAllDay: mtg.isAllDay,
                              );
                              meetingsState.value = meetingsState.value.map((elm) {
                                if (elm.eventName == meeting?.eventName) {
                                  return updatedMeeting; // Update the selected meeting
                                }
                                return elm;
                              }).toList();
                            } else {
                              debugPrint('new: ${mtg.eventName}');
                              meetingsState.value = [...meetingsState.value, mtg];
                            }
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
    required this.meeting,
    required this.onSave,
  });

  final Meeting? meeting;
  final void Function(Meeting) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNameController = TextEditingController(
      text: meeting?.eventName ?? '',
    );

    final startTime = useState(meeting?.from ?? DateTime.now());
    final endTime = useState(meeting?.to ?? DateTime.now().add(const Duration(hours: 1)));

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
            initialValue: startTime.value.toString(),
            decoration: const InputDecoration(labelText: 'Start Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(startTime.value),
              );
              if (selectedTime != null) {
                startTime.value = DateTime(
                  startTime.value.year,
                  startTime.value.month,
                  startTime.value.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: endTime.value.toString(),
            decoration: const InputDecoration(labelText: 'End Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(endTime.value),
              );
              if (selectedTime != null) {
                endTime.value = DateTime(
                  endTime.value.year,
                  endTime.value.month,
                  endTime.value.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (eventNameController.text.isNotEmpty) {
                final updatedMeeting = Meeting(
                  eventName: eventNameController.text,
                  from: startTime.value,
                  to: endTime.value,
                  background: meeting?.background ?? const Color(0xFF0F8644),
                  isAllDay: meeting?.isAllDay ?? false,
                );
                onSave(updatedMeeting);
                Navigator.pop(context);
              }
            },
            child: Text(meeting == null ? 'Add Event' : 'Save Changes'),
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
    Meeting? meeting,
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
