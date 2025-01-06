// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/book.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/page/service.dart';
import 'package:extremo/ui/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
    final booksState = useState<List<BookModel>>([]);

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
        onAppointmentResizeEnd: (AppointmentResizeEndDetails details) async {
          final appointment = details.appointment;
          final startTime = details.startTime;
          final endTime = details.endTime;

          if (appointment == null || appointment is! BookModel) {
            return;
          }
          if (startTime == null) {
            return;
          }
          if (endTime == null) {
            return;
          }
          var book = booksState.value.firstWhereOrNull((value) => value.pk == appointment.pk);
          if (book == null) {
            return;
          }

          // Update the reserve time
          book = book.copyWith(
            openedAt: startTime,
            closedAt: endTime,
            // TODO(impl): background: value.background,
            // TODO(impl): isAllDay: value.isAllDay,
          );

          // TODO(Refactoring): Use to ref.watch.
          // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
          final usecase = await ref.read(updateBookCaseProvider(book).future);

          usecase.onSuccess<ArtifactModel>((book) {
            booksState.value = booksState.value.map((value) => value.pk == appointment.pk ? book : value).toList();

            // Show a Snackbar notification
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('time updated!'),
                duration: Duration(seconds: 5),
              ),
            );
          }).onFailure<Exception>((error) {
            final sb = SnackBar(content: Text(error.toString()));
            ScaffoldMessenger.of(context).showSnackBar(sb);
          });
        },
        allowDragAndDrop: true,
        dataSource: ReserveDataSource(booksState.value),
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
          final book = isEdit ? details.appointments!.first as BookModel : null;

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
                      // BookModel form for editing
                      Expanded(
                        child: _ReserveForm(
                          pk: book?.pk,
                          user: book?.user,
                          service: book?.service,
                          name: book?.name ?? '',
                          openedAt: book?.openedAt ?? details.date!,
                          closedAt: book?.closedAt ?? details.date!.add(const Duration(hours: 1)),
                          onAdd: (book) async {
                            // TODO(Refactoring): Use to ref.watch.
                            // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
                            final provider = isEdit ? updateBookCaseProvider(book) : createBookCaseProvider(book);
                            final usecase = await ref.read(provider.future);

                            usecase.onSuccess<ArtifactModel>((model) {
                              if (!isEdit) {
                                booksState.value = [...booksState.value, book];
                              } else {
                                booksState.value = booksState.value.map((value) => value.pk == book.pk ? book : value).toList();
                              }
                              // Show a Snackbar notification
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('"${book.name}" saved!'),
                                  duration: const Duration(seconds: 5),
                                ),
                              );
                            }).onFailure<Exception>((error) {
                              final sb = SnackBar(content: Text(error.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(sb);
                            });
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        // activeForegroundColor: Colors.white,
        // animatedIcon: AnimatedIcons.add_event,
        // animatedIconTheme: const IconThemeData(size: 22),
        activeBackgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor ?? Colors.blueGrey,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ?? Colors.grey,
        foregroundColor: Colors.white,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.assignment_add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            label: t.service,
            onTap: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (context) => const ServicePage(isModal: true),
            ),
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _ReserveForm extends HookConsumerWidget {
  const _ReserveForm({
    this.pk,
    this.user,
    this.service,
    required this.name,
    required this.openedAt,
    required this.closedAt,
    required this.onAdd,
  });

  final int? pk;
  final UserModel? user;
  final ServiceModel? service;
  final String name;
  final DateTime openedAt;
  final DateTime closedAt;
  final void Function(BookModel) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectController = useTextEditingController(text: name);
    final openedAtState = useState(openedAt);
    final closedAtState = useState(closedAt);
    final userState = useState<UserModel?>(user);
    final serviceState = useState<ServiceModel?>(service);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // user selection
          ElevatedButton(
            onPressed: () async {
              final user = await UserRoute($extra: (UserModel user) => Navigator.pop(context, user)).push<UserModel>(context);
              if (user != null) {
                userState.value = user;
              }
            },
            child: Text(
              userState.value != null ? 'Selected: ${userState.value?.profile?.name ?? ''}' : 'Select User',
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
            initialValue: closedAtState.value.toString(),
            decoration: const InputDecoration(labelText: 'Start Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(closedAtState.value));
              if (selectedTime != null) {
                closedAtState.value = DateTime(closedAtState.value.year, closedAtState.value.month, closedAtState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: openedAtState.value.toString(),
            decoration: const InputDecoration(labelText: 'End Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(openedAtState.value),
              );
              if (selectedTime != null) {
                openedAtState.value = DateTime(openedAtState.value.year, openedAtState.value.month, openedAtState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          // service selection
          ElevatedButton(
            onPressed: () async {
              final service = await ServiceRoute($extra: (ServiceModel service) => Navigator.pop(context, service)).push<ServiceModel>(context);
              if (service != null) {
                serviceState.value = service;
              }
            },
            child: Text(
              serviceState.value != null ? 'Selected: ${serviceState.value!.name}' : 'Select Service',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (userState.value == null || serviceState.value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              onAdd(
                BookModel(
                  pk: pk,
                  user: userState.value,
                  service: serviceState.value,
                  name: subjectController.text,
                  openedAt: closedAtState.value,
                  closedAt: openedAtState.value,
                  background: const Color(0xFF0F8644),
                  isAllDay: false,
                ),
              ); // TODO(impl): callback

              Navigator.pop(context); // TODO(impl): callback
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class ReserveDataSource extends CalendarDataSource<BookModel> {
  ReserveDataSource(List<BookModel> source) {
    appointments = source;
    debugPrint('Appointments initialized: ${appointments?.length}');
  }

  @override
  DateTime getStartTime(int index) {
    return _getData(index).openedAt;
  }

  @override
  DateTime getEndTime(int index) {
    return _getData(index).closedAt;
  }

  @override
  String getSubject(int index) {
    return _getData(index).name;
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
  BookModel convertAppointmentToObject(
    BookModel? customData,
    Appointment appointment,
  ) {
    return BookModel(
      pk: customData?.pk,
      user: customData?.user,
      service: customData?.service,
      name: appointment.subject,
      openedAt: appointment.startTime,
      closedAt: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
    );
  }

  BookModel _getData(int index) {
    final dynamic data = appointments![index];
    late final BookModel book;

    if (data is BookModel) {
      book = data;
    }

    return book;
  }
}

// class Reserve {
//   Reserve({
//     this.id,
//     this.user,
//     this.service,
//     required this.subject,
//     required this.startTime,
//     required this.endTime,
//     required this.background,
//     required this.isAllDay,
//   });
//
//   factory Reserve.create({
//     String? id,
//     UserModel? user,
//     ServiceModel? service,
//     required String subject,
//     required DateTime startTime,
//     required DateTime endTime,
//     required Color background,
//     required bool isAllDay,
//   }) {
//     return Reserve(
//       id: id ?? const Uuid().v7(),
//       user: user,
//       service: service,
//       subject: subject,
//       startTime: startTime,
//       endTime: endTime,
//       background: background,
//       isAllDay: isAllDay,
//     );
//   }
//
//   final String? id;
//   final UserModel? user;
//   final ServiceModel? service;
//   final String subject;
//   final DateTime startTime;
//   final DateTime endTime;
//   final Color background;
//   final bool isAllDay;
// }
