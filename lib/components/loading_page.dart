import 'package:flutter/material.dart';
import 'package:gamify_app/utils/constans.dart';

class LoadingPage extends StatelessWidget {
  final Widget child;
  final bool isShowSpinner;
  LoadingPage({
    required this.child,
    this.isShowSpinner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            child,
            if (isShowSpinner)
              Container(
                color: Colors.black.withOpacity(0.8),
                width: double.infinity,
                height: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kGrayColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
