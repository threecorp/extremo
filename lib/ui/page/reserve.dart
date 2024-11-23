// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';

class ReservePage extends HookConsumerWidget {
  const ReservePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservesState = useState<List<Reserve>>([]);

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
            final values = reservesState.value.map((value) {
              if (value.id == (details.appointment as Reserve).id) {
                // Update the reserve time
                return Reserve(
                  id: value.id,
                  subject: value.subject,
                  startTime: details.startTime!,
                  endTime: details.endTime!,
                  background: value.background,
                  isAllDay: value.isAllDay,
                );
              }
              return value;
            }).toList();

            // Update the state
            reservesState.value = values;

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
        dataSource: ReserveDataSource(reservesState.value),
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
          final reserve = isEdit ? details.appointments!.first as Reserve : null;

          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true, // Make the modal full height
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  color: Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white,
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
                      // Reserve form for editing
                      Expanded(
                        child: _ReserveForm(
                          id: reserve?.id,
                          subject: reserve?.subject ?? '',
                          startTime: reserve?.startTime ?? details.date!,
                          endTime: reserve?.endTime ?? details.date!.add(const Duration(hours: 1)),
                          onAdd: (reserve) {
                            if (!isEdit) {
                              reservesState.value = [...reservesState.value, reserve];
                            } else {
                              reservesState.value = reservesState.value.map((value) {
                                return value.id == reserve.id ? reserve : value;
                              }).toList();
                            }

                            // Show a Snackbar notification
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('"${reserve.subject}" saved!'),
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

class _ReserveForm extends HookConsumerWidget {
  const _ReserveForm({
    this.id,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.onAdd,
  });

  final String? id;
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final void Function(Reserve) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectController = useTextEditingController(text: subject);
    final sTimeState = useState(startTime);
    final eTimeState = useState(endTime);
    final userState = useState<User?>(null);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // user selection
          ElevatedButton(
            onPressed: () async {
              final user = await UserRoute().push<User>(context);
              if (user != null) {
                userState.value = user;
              }
            },
            child: Text(
              userState.value != null ? 'Selected: ${userState.value!.name}' : 'Select User',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: subjectController,
            decoration: const InputDecoration(labelText: 'Subject'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: sTimeState.value.toString(),
            decoration: const InputDecoration(labelText: 'Start Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(sTimeState.value));
              if (selectedTime != null) {
                sTimeState.value = DateTime(sTimeState.value.year, sTimeState.value.month, sTimeState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: eTimeState.value.toString(),
            decoration: const InputDecoration(labelText: 'End Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(eTimeState.value),
              );
              if (selectedTime != null) {
                eTimeState.value = DateTime(eTimeState.value.year, eTimeState.value.month, eTimeState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (subjectController.text.isNotEmpty && userState.value != null) {
                final reserve = Reserve.create(
                  id: id,
                  subject: subjectController.text,
                  startTime: sTimeState.value,
                  endTime: eTimeState.value,
                  background: const Color(0xFF0F8644),
                  isAllDay: false,
                  user: userState.value!,
                );
                onAdd(reserve); // TODO(impl): callback
                Navigator.pop(context); // TODO(impl): callback
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields and select a user')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class ReserveDataSource extends CalendarDataSource<Reserve> {
  ReserveDataSource(List<Reserve> source) {
    appointments = source;
    debugPrint('Appointments initialized: ${appointments?.length}');
  }

  @override
  DateTime getStartTime(int index) {
    return _getData(index).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getData(index).endTime;
  }

  @override
  String getSubject(int index) {
    return _getData(index).subject;
  }

  @override
  Color getColor(int index) {
    return _getData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getData(index).isAllDay;
  }

  @override
  Reserve convertAppointmentToObject(
    Reserve? customData,
    Appointment appointment,
  ) {
    return Reserve.create(
      subject: appointment.subject,
      startTime: appointment.startTime,
      endTime: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
    );
  }

  Reserve _getData(int index) {
    final dynamic data = appointments![index];
    late final Reserve reserve;

    if (data is Reserve) {
      reserve = data;
    }

    return reserve;
  }
}

class Reserve {
  Reserve({
    this.id,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.background,
    required this.isAllDay,
    this.user,
  });

  factory Reserve.create({
    String? id,
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required Color background,
    required bool isAllDay,
    User? user,
  }) {
    return Reserve(
      id: id ?? const Uuid().v7(),
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      background: background,
      isAllDay: isAllDay,
      user: user,
    );
  }

  final String? id;
  String subject;
  DateTime startTime;
  DateTime endTime;
  Color background;
  bool isAllDay;
  User? user;
}
