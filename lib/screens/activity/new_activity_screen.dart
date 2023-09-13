import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/loading_page.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/screens/activity/components/activity_form.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';

class NewActivityScreen extends StatefulWidget {
  final Function onRefresh;
  const NewActivityScreen({
    required this.onRefresh,
  });

  @override
  State<NewActivityScreen> createState() => _NewActivityScreenState();
}

class _NewActivityScreenState extends State<NewActivityScreen> {
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
                  onGetEvent: (Event event) {
                    registerActivity(event);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerActivity(Event event) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() => isShowSpinner = true);
      await eventService.registerEvent(
        event: event,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Evento registrado con éxito',
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
