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
    final booksAsync = ref.watch(filterBooksCaseProvider);
    final booksState = useState<List<BookModel>>([]);

    useEffect(() {
      if (booksAsync is AsyncData) {
        booksState.value = booksAsync.value ?? [];
      }
      return null;
    }, [booksAsync]);

    Future<void> updateBookByAppointment(dynamic appointment, DateTime? openedAt, DateTime? closedAt) async {
      if (appointment == null || appointment is! BookModel) {
        return;
      }
      if (openedAt == null) {
        return;
      }
      if (closedAt == null) {
        return;
      }
      var book = booksState.value.firstWhereOrNull((value) => value.pk == appointment.pk);
      if (book == null) {
        return;
      }

      // Update the reserve time
      book = book.copyWith(
        openedAt: openedAt,
        closedAt: closedAt,
        // TODO(impl): background: value.background,
        // TODO(impl): isAllDay: value.isAllDay,
      );

      // TODO(Refactoring): Use to ref.watch.
      // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
      final clientFks = book.clients.map((e) => e.pk).whereType<int>().toList();
      final teamFks = book.teams.map((e) => e.pk).whereType<int>().toList();
      final serviceFks = book.booksServices.map((e) => e.serviceFk).whereType<int>().toList();
      final usecase = await ref.read(updateBookCaseProvider(book, clientFks, teamFks, serviceFks).future);
      debugPrint('clientFks: $clientFks, teamFks: $teamFks, serviceFks: $serviceFks');

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
    }

    Future<void> upsertBookByFks(BookModel book, List<int> clientFks, List<int> teamFks, List<int> serviceFks) async {
      final pk = book.pk;
      final isEdit = pk != null && pk > 0;

      // TODO(Refactoring): Use to ref.watch.
      // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
      final provider = isEdit ? updateBookCaseProvider(book, clientFks, teamFks, serviceFks) : createBookCaseProvider(book, clientFks, teamFks, serviceFks);
      final usecase = await ref.read(provider.future);

      usecase.onSuccess<ArtifactModel>((book) {
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
    }

    return booksAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
      data: (books) {
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
            // resourceViewSettings: ResourceViewSettings(showAvatar: true),
            allowAppointmentResize: true,
            allowDragAndDrop: true,
            dataSource: ReserveDataSource(booksState.value),
            firstDayOfWeek: 1, // Monday
            monthViewSettings: const MonthViewSettings(showAgenda: true, appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            selectionDecoration: BoxDecoration(color: Colors.green.withOpacity(0.2), border: Border.all(color: Colors.transparent, width: 0)),
            showNavigationArrow: true,
            timeZone: 'Tokyo Standard Time',
            todayHighlightColor: Colors.red,
            // on
            onTap: (CalendarTapDetails details) {
              final isEdit = details.targetElement == CalendarElement.appointment && details.appointments != null;
              final book = isEdit ? details.appointments!.first as BookModel : null;

              debugPrint('clients: ${book?.clients.length} teams: ${book?.teams.length} services: ${book?.booksServices.length}');

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
                              clients: book?.clients ?? [],
                              teams: book?.teams ?? [],
                              services: book?.booksServices.map((e) => e.service).whereType<ServiceModel>().toList() ?? [],
                              name: book?.name ?? '',
                              openedAt: book?.openedAt ?? details.date!,
                              closedAt: book?.closedAt ?? details.date!.add(const Duration(hours: 1)),
                              // on
                              onAdd: upsertBookByFks,
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
            onViewChanged: (ViewChangedDetails details) => debugPrint('onViewChanged: ${details.visibleDates}'),
            // onAppointmentResizeStart: resizeStart,
            // onAppointmentResizeUpdate: resizeUpdate,
            onAppointmentResizeEnd: (AppointmentResizeEndDetails details) async {
              await updateBookByAppointment(details.appointment, details.startTime, details.endTime);
            },
            onDragEnd: (AppointmentDragEndDetails details) async {
              final appointment = details.appointment;
              final droppingTime = details.droppingTime;

              if (appointment == null || appointment is! BookModel) {
                return;
              }
              if (droppingTime == null) {
                return;
              }

              final oldStartTime = appointment.openedAt;
              final oldEndTime = appointment.closedAt;

              final oldDuration = oldEndTime.difference(oldStartTime);
              final newStartTime = droppingTime;
              final newEndTime = newStartTime.add(oldDuration);

              await updateBookByAppointment(appointment, newStartTime, newEndTime);
            }
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
    );
  }
}

class _ReserveForm extends HookConsumerWidget {
  const _ReserveForm({
    this.pk,
    this.clients = const [],
    this.teams = const [],
    this.services = const [],
    required this.name,
    required this.openedAt,
    required this.closedAt,
    required this.onAdd,
  });

  final int? pk;
  final List<UserModel> clients;
  final List<TeamModel> teams;
  final List<ServiceModel> services;
  final String name;
  final DateTime openedAt;
  final DateTime closedAt;
  final void Function(BookModel, List<int>, List<int>, List<int>) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectController = useTextEditingController(text: name);
    final openedAtState = useState(openedAt);
    final closedAtState = useState(closedAt);
    final clientsState = useState<List<UserModel>>(clients);
    final teamsState = useState<List<TeamModel>>(teams);
    final servicesState = useState<List<ServiceModel>>(services);

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
                clientsState.value = [user]; // XXX(impl): multiple selection
              }
            },
            child: Text(clientsState.value.firstOrNull?.profile?.name ?? 'Select User'),
          ),
          const SizedBox(height: 16),
          // service selection
          ElevatedButton(
            onPressed: () async {
              final service = await ServiceRoute($extra: (ServiceModel service) => Navigator.pop(context, service)).push<ServiceModel>(context);
              if (service != null) {
                servicesState.value = [service]; // XXX(impl): multiple selection
              }
            },
            child: Text(
              servicesState.value.firstOrNull?.name ?? 'Select Service',
            ),
          ),
          const SizedBox(height: 16),
          // team selection
          ElevatedButton(
            onPressed: () async {
              final team = await TeamRoute($extra: (TeamModel team) => Navigator.pop(context, team)).push<TeamModel>(context);
              if (team != null) {
                teamsState.value = [team]; // XXX(impl): multiple selection
              }
            },
            child: Text(
              teamsState.value.firstOrNull?.name ?? 'Select Team',
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
            initialValue: openedAtState.value.toString(),
            decoration: const InputDecoration(labelText: 'Start Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(openedAtState.value));
              if (selectedTime != null) {
                openedAtState.value = DateTime(openedAtState.value.year, openedAtState.value.month, openedAtState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            initialValue: closedAtState.value.toString(),
            decoration: const InputDecoration(labelText: 'End Time'),
            onTap: () async {
              final selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(closedAtState.value));
              if (selectedTime != null) {
                closedAtState.value = DateTime(closedAtState.value.year, closedAtState.value.month, closedAtState.value.day, selectedTime.hour, selectedTime.minute);
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (clientsState.value.isEmpty || servicesState.value.isEmpty || teamsState.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              onAdd(
                BookModel(
                  pk: pk,
                  name: subjectController.text,
                  openedAt: openedAtState.value,
                  closedAt: closedAtState.value,
                  // background: const Color(0xFF0F8644),
                  // isAllDay: false,
                ),
                clientsState.value.map((e) => e.pk).whereType<int>().toList(),
                teamsState.value.map((e) => e.pk).whereType<int>().toList(),
                servicesState.value.map((e) => e.pk).whereType<int>().toList(),
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

  // TODO(impl): Implement the following methods
  // @override
  // Color getColor(int index) {
  //   return _getData(index).background;
  // }
  //
  // @override
  // bool isAllDay(int index) {
  //   return _getData(index).isAllDay;
  // }

  @override
  BookModel convertAppointmentToObject(
    BookModel? customData,
    Appointment appointment,
  ) {
    return customData?.copyWith(
      name: appointment.subject,
      openedAt: appointment.startTime,
      closedAt: appointment.endTime,
    ) ?? BookModel(
      name: appointment.subject,
      openedAt: appointment.startTime,
      closedAt: appointment.endTime,
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

