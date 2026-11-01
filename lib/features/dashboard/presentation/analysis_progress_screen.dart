import 'package:flutter/material.dart';

import '../../dashboard/presentation/repository_overview_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class AnalysisProgressScreen extends StatelessWidget {
  final String repositoryUrl;

  const AnalysisProgressScreen({super.key, required this.repositoryUrl});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(repositoryUrl);

    final repositoryName = uri != null && uri.pathSegments.length >= 2
        ? '${uri.pathSegments[0]}/${uri.pathSegments[1]}'
        : 'GitHub Repository';

    return Scaffold(
      appBar: AppBar(title: const Text('Repository Analysis')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),

            // Header
            Center(
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.25),
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 34,
                  color: AppColors.primaryLight,
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Your repository is ready',
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

            const SizedBox(height: 24),

            // Prototype status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cyan.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cyan.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.cyan,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Prototype mode — backend analysis is not '
                      'connected yet.',
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

            const SizedBox(height: 24),

            // Analysis pipeline
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Analysis Pipeline',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Preview',
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildStage(
                    icon: Icons.check_circle_rounded,
                    title: 'Repository URL validated',
                    subtitle: 'URL format check passed',
                    status: _StageStatus.completed,
                    isLast: false,
                  ),

                  _buildStage(
                    icon: Icons.cloud_download_outlined,
                    title: 'Fetching repository metadata',
                    subtitle: 'GitHub API integration pending',
                    status: _StageStatus.pending,
                    isLast: false,
                  ),

                  _buildStage(
                    icon: Icons.folder_open_outlined,
                    title: 'Exploring repository structure',
                    subtitle: 'File and folder analysis pending',
                    status: _StageStatus.pending,
                    isLast: false,
                  ),

                  _buildStage(
                    icon: Icons.code_rounded,
                    title: 'Detecting technologies',
                    subtitle: 'Technology detection pending',
                    status: _StageStatus.pending,
                    isLast: false,
                  ),

                  _buildStage(
                    icon: Icons.psychology_outlined,
                    title: 'Generating AI insights',
                    subtitle: 'AI integration pending',
                    status: _StageStatus.pending,
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Repository URL
            const Text(
              'Repository URL',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceInput,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: SelectableText(
                repositoryUrl,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Preview overview button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepositoryOverviewScreen(
                        repositoryUrl: repositoryUrl,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.analytics_outlined),
                label: const Text('Preview Repository Overview'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back to Dashboard'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStage({
    required IconData icon,
    required String title,
    required String subtitle,
    required _StageStatus status,
    required bool isLast,
  }) {
    final bool completed = status == _StageStatus.completed;

    final Color statusColor = completed
        ? AppColors.success
        : AppColors.textMuted;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            completed ? Icons.check_circle_rounded : icon,
            color: statusColor,
            size: 22,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: completed
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          if (completed)
            const Icon(Icons.check_rounded, color: AppColors.success, size: 18)
          else
            const Text(
              'Pending',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
        ],
      ),
    );
  }
}

enum _StageStatus { completed, pending }
