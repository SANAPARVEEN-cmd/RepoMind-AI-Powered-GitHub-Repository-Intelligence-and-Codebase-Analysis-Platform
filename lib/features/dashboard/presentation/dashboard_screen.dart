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
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const DashboardHeader(),

              const SizedBox(height: 26),

              _buildArchitectureRadar(),

              const SizedBox(height: 24),

              const RepositoryInputCard(),

              const SizedBox(height: 30),

              _buildSectionTitle(
                'Your Workspace',
                'A snapshot of your activity',
              ),

              const SizedBox(height: 16),

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

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(
                    'Recent Analyses',
                    'Your recently explored codebases',
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

              const SizedBox(height: 14),

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

  Widget _buildArchitectureRadar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.radar_rounded,
                  color: AppColors.primaryLight,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REPOMIND INTELLIGENCE',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Architecture Radar',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.auto_awesome_outlined,
                color: AppColors.primaryLight,
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            'See beyond the code.',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Explore repository structure, technologies, '
            'code health, and architectural insights in one place.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _buildRadarFeature(Icons.account_tree_outlined, 'Structure'),
              const SizedBox(width: 16),
              _buildRadarFeature(Icons.monitor_heart_outlined, 'Code health'),
              const SizedBox(width: 16),
              _buildRadarFeature(Icons.psychology_outlined, 'AI insights'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadarFeature(IconData icon, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: AppColors.primaryLight),
          const SizedBox(height: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
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
