import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/screens/activity/components/event_item.dart';
import 'package:gamify_app/screens/activity/edit_activity_screen.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EventDialog extends StatefulWidget {
  final Event event;
  final Function onRefresh;
  final BuildContext dialogContext;
  final BuildContext mainContext;
  const EventDialog({
    required this.event,
    required this.onRefresh,
    required this.dialogContext,
    required this.mainContext,
  });

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final eventService = EventService.instance;
  bool isShowSpinner = false;

  Future<void> deleteEvent() async {
    try {
      setState(() => isShowSpinner = true);
      await eventService.deleteEvent(
        eventId: widget.event.eventId!,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Evento eliminado con éxito',
      );
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: (e is ServiceException) ? e.message : kMensajeErrorGenerico,
        isError: true,
      );
    } finally {
      setState(() => isShowSpinner = false);
    }
  }

  Future<void> completeEvent() async {
    try {
      setState(() => isShowSpinner = true);
      await eventService.closeEvent(
        eventId: widget.event.eventId!,
      );
      final user = Provider.of<AppState>(context, listen: false).user;
      await Provider.of<AppState>(context, listen: false).setUser(
        user: User(
          userId: user!.userId,
          email: user.email,
          password: user.password,
          points: user.points + widget.event.points!,
          isAdmin: user.isAdmin,
          isGlobalSurveyDone: user.isGlobalSurveyDone,
          token: user.token,
        ),
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Evento completado con éxito',
      );
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: (e is ServiceException) ? e.message : kMensajeErrorGenerico,
        isError: true,
      );
    } finally {
      setState(() => isShowSpinner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Detalle',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    fontFamily: kRulukoFont,
                    color: kGrayColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: EventItem(
                    event: widget.event,
                  ),
                ),
                if (widget.event.closed! == false) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(widget.dialogContext);
                            Navigator.push(
                              widget.mainContext,
                              MaterialPageRoute(
                                builder: (context) => EditActivityScreen(
                                  eventId: widget.event.eventId,
                                  onRefresh: () => widget.onRefresh(),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                kEditImagePath,
                                height: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Editar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kRulukoFont,
                                  color: kGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            deleteEvent();
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Eliminar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kRulukoFont,
                                  color: kGrayColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                kDeleteImagePath,
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: CustomButton(
                      height: 45,
                      color: Color(0xFF495F75),
                      onTap: () {
                        completeEvent();
                      },
                      child: const Text(
                        'Completar Actividad',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: kRulukoFont,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(widget.dialogContext);
            },
            child: const Icon(
              Icons.close,
              color: kGrayColor,
            ),
          ),
        ),
        if (isShowSpinner)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: kGrayColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
