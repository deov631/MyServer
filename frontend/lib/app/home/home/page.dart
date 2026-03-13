import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/widget/floating.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverAppBarDelegate(title: 'Welcome'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 400),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: MyFloatingCard(
                          height: 300,
                          title: 'README',
                          color1: Colors.orangeAccent,
                          color2: Colors.orange,
                          onTap: () {
                            debugPrint('Tapped README');
                          },
                        ),
                      ),
                      Expanded(
                        child: MyFloatingCard(
                          height: 300,
                          title: 'Applications',
                          color1: Colors.green[400]!,
                          color2: Colors.green[700]!,
                          onTap: () {
                            context.go('/list');
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MyFloatingCard(
                              height: 150,
                              title: 'Announcements',
                              color1: Colors.grey[700]!,
                              color2: Colors.grey[900]!,
                              onTap: () {
                                debugPrint('Tapped Announcements');
                              },
                            ),
                            MyFloatingCard(
                              height: 150,
                              title: 'Monitoring',
                              color1: Colors.blueAccent,
                              color2: Colors.blue,
                              onTap: () {
                                debugPrint('Tapped Monitoring');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20)
                    ],
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  CustomSliverAppBarDelegate({required this.title});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 计算缩放比例
    double maxExtentValue = maxExtent;
    double minExtentValue = minExtent;
    double progress = (shrinkOffset) / (maxExtentValue - minExtentValue);
    progress = progress.clamp(0.0, 1.0); // 确保progress值在0到1之间

    // 根据进度计算顶部边距，从200逐渐减少到0
    double topPadding = 200.0 - (200.0 * progress);

    return Container(
      color: Theme.of(context).primaryColor,
      height: maxExtentValue,

      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, topPadding, 0.0, 0.0),
        child: Row(
          children: [
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
