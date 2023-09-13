import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/screens/benefit/components/benefit_page.dart';
import 'package:gamify_app/utils/constans.dart';

class BenefitScreen extends StatefulWidget {
  const BenefitScreen();

  @override
  State<BenefitScreen> createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _indexTab;

  @override
  void initState() {
    super.initState();
    _indexTab = 0;
    _controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: _indexTab,
    );
    _controller.addListener(() {
      setState(() => _indexTab = _controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(vertical: 15),
                    labelColor: kGrayColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: kBungeeFont,
                      color: kGrayColor,
                    ),
                    controller: _controller,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: kActiveColor,
                        width: 3,
                      ),
                    ),
                    tabs: const [
                      Text(
                        'BENEFICIOS',
                      ),
                      Text(
                        'MIS BENEFICIOS',
                      ),
                    ],
                    onTap: (index) => setState(
                      () => _indexTab = index,
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _controller,
                children: [
                  BenefitPage(),
                  BenefitPage(myBenefit: true),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
