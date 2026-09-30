import 'package:flutter/material.dart';

import '../../dashboard/presentation/repository_overview_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class AnalysisProgressScreen extends StatelessWidget {
  final String repositoryUrl;

  const AnalysisProgressScreen({super.key, required this.repositoryUrl});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(repositoryUrl);
    final repositoryName = uri.pathSegments.length >= 2
        ? '${uri.pathSegments[0]}/${uri.pathSegments[1]}'
        : 'GitHub Repository';

    return Scaffold(
      appBar: AppBar(title: const Text('Repository Analysis')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.auto_awesome_rounded,
              size: 54,
              color: AppColors.primaryLight,
            ),

            const SizedBox(height: 20),

            const Text(
              'Preparing your insights',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              repositoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Analysis Pipeline',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildStage(
                    Icons.check_circle,
                    'Repository URL validated',
                    true,
                  ),

                  _buildStage(
                    Icons.pending_outlined,
                    'Fetching repository metadata',
                    false,
                  ),

                  _buildStage(
                    Icons.folder_outlined,
                    'Exploring repository structure',
                    false,
                  ),

                  _buildStage(
                    Icons.code_rounded,
                    'Detecting technologies',
                    false,
                  ),

                  _buildStage(
                    Icons.psychology_outlined,
                    'Generating AI insights',
                    false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.25)),
              ),
              child: const Text(
                'UI prototype: Repository analysis will be '
                'connected to the backend in a later module.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStage(IconData icon, String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: completed ? AppColors.success : AppColors.textMuted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: completed
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ),
          if (completed)
            const Icon(Icons.check, color: AppColors.success, size: 18),
        ],
      ),
    );
  }
}
