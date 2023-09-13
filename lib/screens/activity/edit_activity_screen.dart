import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/screens/activity/components/activity_form.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class EditActivityScreen extends StatefulWidget {
  final String? eventId;
  final Function onRefresh;
  const EditActivityScreen({
    this.eventId,
    required this.onRefresh,
  });

  @override
  State<EditActivityScreen> createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  final eventService = EventService.instance;
  bool isShowSpinner = false;

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      isShowSpinner: isShowSpinner,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverFillRemaining(
                child: ActivityForm(
                  eventId: widget.eventId,
                  onGetEvent: (Event event) {
                    editActivity(event);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editActivity(Event event) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await eventService.updateEvent(
        event: event,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Evento actualizado con éxito',
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
}
