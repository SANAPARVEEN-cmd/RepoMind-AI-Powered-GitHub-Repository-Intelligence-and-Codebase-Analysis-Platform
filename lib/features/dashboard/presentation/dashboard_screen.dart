import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/repository_input_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/recent_repository_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Home', 'History', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHome(),
            _buildPlaceholder(
              Icons.history_rounded,
              'Analysis History',
              'Your analyzed repositories will appear here.',
            ),
            _buildPlaceholder(
              Icons.person_outline_rounded,
              'Your Profile',
              'Account settings will be available here.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const DashboardHeader(),

              const SizedBox(height: 28),

              const RepositoryInputCard(),

              const SizedBox(height: 28),

              const Text(
                'Your Workspace',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              const Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Repositories',
                      value: '12',
                      icon: Icons.folder_copy_outlined,
                      accent: AppColors.primaryLight,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      title: 'Analyses',
                      value: '08',
                      icon: Icons.analytics_outlined,
                      accent: AppColors.cyan,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Analyses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: const Text('View all'),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const RecentRepositoryCard(
                name: 'RepoMind',
                description: 'AI-powered repository intelligence',
                technologies: 'Flutter, Dart, Firebase',
                health: '8.4 / 10',
              ),

              const SizedBox(height: 12),

              const RecentRepositoryCard(
                name: 'Business Nexus',
                description: 'Entrepreneur and investor platform',
                technologies: 'React, JavaScript, Vercel',
                health: '7.9 / 10',
                icon: Icons.business_center_outlined,
              ),

              const SizedBox(height: 20),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(IconData icon, String title, String description) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 54, color: AppColors.primaryLight),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
