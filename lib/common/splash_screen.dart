import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/router.dart';
import '../core/app_colors.dart';
import '../core/user_role.dart';
import 'widgets/tower_backdrop.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _features = [
    _Feature(
      icon: Icons.cell_tower_rounded,
      lead: 'Every site.\n',
      highlight: 'Every task.',
      body: 'Monitor tower health and alarms, and move work orders from assignment to sign-off.',
      points: [
        _Point(Icons.monitor_heart_outlined, 'Site health & alarms', 'Power, fuel and uptime per site'),
        _Point(Icons.assignment_outlined, 'Work order tracking', 'From assignment to sign-off'),
        _Point(Icons.timer_outlined, 'SLA monitoring', 'Automatic escalation before breach'),
      ],
    ),
    _Feature(
      icon: Icons.engineering_rounded,
      lead: 'Built for\n',
      highlight: 'the field.',
      body: 'GPS check-in, digital checklists and photo evidence — even without a signal.',
      points: [
        _Point(Icons.my_location_outlined, 'Verified check-in', 'GPS-confirmed site attendance'),
        _Point(Icons.fact_check_outlined, 'Digital checklists', 'Step-by-step with photo evidence'),
        _Point(Icons.cloud_sync_outlined, 'Offline ready', 'Syncs automatically when back online'),
      ],
    ),
    _Feature(
      icon: Icons.insights_rounded,
      lead: 'Real-time\n',
      highlight: 'insight.',
      body: 'KPIs, alerts and approvals for everyone from technician to head office.',
      points: [
        _Point(Icons.notifications_active_outlined, 'Critical alerts', 'Pushed the moment they happen'),
        _Point(Icons.approval_outlined, 'Unified approvals', 'Requests and sign-offs in one inbox'),
        _Point(Icons.bar_chart_rounded, 'Operational reports', 'Sites, fleet and stock at a glance'),
      ],
    ),
  ];

  int get _pageCount => _features.length + 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const TowerBackdrop(),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (page) => setState(() => _page = page),
                      children: [
                        const _IntroPage(),
                        for (final feature in _features) _FeaturePage(feature: feature),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _PageDots(count: _pageCount, current: _page, onTap: _goTo),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: FilledButton(
                      onPressed: () => context.go(RouteNames.roleSelection),
                      child: const Text('Get Started'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.lead,
    required this.highlight,
    required this.body,
    required this.points,
  });

  final IconData icon;
  final String lead;
  final String highlight;
  final String body;
  final List<_Point> points;
}

class _Point {
  const _Point(this.icon, this.title, this.caption);

  final IconData icon;
  final String title;
  final String caption;
}

/// Page 1: brand, tagline and the six roles.
class _IntroPage extends StatelessWidget {
  const _IntroPage();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Spacer(flex: 3),
          Icon(Icons.wifi_rounded, size: 64, color: AppColors.accentBlue),
          Text(
            'TMS',
            style: TextStyle(
              fontSize: 64,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Telecom Management System',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 36),
          _Headline(lead: 'Manage. Monitor.\nOptimize. ', highlight: 'Anywhere.'),
          Spacer(flex: 4),
          _GlassPanel(child: _RoleGrid()),
        ],
      ),
    );
  }
}

/// Pages 2–4: one capability each.
class _FeaturePage extends StatelessWidget {
  const _FeaturePage({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(flex: 3),
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(feature.icon, size: 52, color: Colors.white),
          ),
          const SizedBox(height: 32),
          _Headline(lead: feature.lead, highlight: feature.highlight, fontSize: 32),
          const SizedBox(height: 16),
          ConstrainedBox(
            // Keep the copy clear of the tower silhouettes at the edges.
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              feature.body,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Spacer(flex: 4),
          _GlassPanel(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  for (var i = 0; i < feature.points.length; i++) ...[
                    if (i > 0)
                      Divider(
                        height: 1,
                        indent: 56,
                        color: Colors.white.withValues(alpha: 0.14),
                      ),
                    _PointRow(point: feature.points[i]),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PointRow extends StatelessWidget {
  const _PointRow({required this.point});

  final _Point point;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            ),
            child: Icon(point.icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  point.caption,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.lead, required this.highlight, this.fontSize = 24});

  final String lead;
  final String highlight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: lead,
        children: [
          TextSpan(
            text: highlight,
            style: const TextStyle(color: AppColors.primary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        height: 1.3,
        fontWeight: fontSize > 24 ? FontWeight.w700 : FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _RoleGrid extends StatelessWidget {
  const _RoleGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      childAspectRatio: 1.35,
      children: [for (final role in UserRole.values) _RoleBadge(role: role)],
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: role.color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 2),
          ),
          child: Icon(role.icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          role.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current, required this.onTap});

  final int count;
  final int current;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Semantics(
            button: true,
            selected: i == current,
            label: 'Page ${i + 1} of $count',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  width: i == current ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == current
                        ? AppColors.accentBlue
                        : Colors.white.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
