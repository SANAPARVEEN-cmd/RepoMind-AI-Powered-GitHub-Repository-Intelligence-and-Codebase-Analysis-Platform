import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CodeHealthAnalysisSection extends StatelessWidget {
  const CodeHealthAnalysisSection({super.key});

  // Illustrative values for the UI prototype.
  static const int overallScore = 82;

  static const List<_HealthMetric> metrics = [
    _HealthMetric(
      title: 'Maintainability',
      score: 85,
      description:
          'Measures how easily developers can understand, modify, '
          'and extend the codebase.',
      icon: Icons.build_outlined,
      color: AppColors.success,
    ),
    _HealthMetric(
      title: 'Readability',
      score: 78,
      description:
          'Evaluates code clarity, naming conventions, formatting, '
          'and consistency.',
      icon: Icons.menu_book_outlined,
      color: AppColors.cyan,
    ),
    _HealthMetric(
      title: 'Complexity',
      score: 72,
      description:
          'Highlights functions and components that may be difficult '
          'to understand or maintain.',
      icon: Icons.account_tree_outlined,
      color: AppColors.warning,
    ),
    _HealthMetric(
      title: 'Code Duplication',
      score: 90,
      description:
          'Estimates how much repeated code exists and where reusable '
          'components could help.',
      icon: Icons.copy_all_outlined,
      color: AppColors.primaryLight,
    ),
  ];

  static const List<_HealthIssue> issues = [
    _HealthIssue(
      title: 'Critical',
      count: 2,
      color: AppColors.danger,
      description: 'Issues that may cause serious problems.',
    ),
    _HealthIssue(
      title: 'High',
      count: 5,
      color: Color(0xFFFB923C),
      description: 'Issues that should be addressed soon.',
    ),
    _HealthIssue(
      title: 'Medium',
      count: 8,
      color: AppColors.warning,
      description: 'Improvements that can strengthen code quality.',
    ),
    _HealthIssue(
      title: 'Low',
      count: 12,
      color: AppColors.cyan,
      description: 'Minor improvements and cleanup opportunities.',
    ),
  ];

  static const List<_Recommendation> recommendations = [
    _Recommendation(
      title: 'Reduce complex functions',
      description:
          'Break large functions into smaller, focused methods '
          'to make the code easier to understand and test.',
      priority: 'High',
      icon: Icons.functions_rounded,
    ),
    _Recommendation(
      title: 'Improve naming consistency',
      description:
          'Use clear and consistent names for variables, methods, '
          'classes, and files.',
      priority: 'Medium',
      icon: Icons.text_fields_rounded,
    ),
    _Recommendation(
      title: 'Review repeated code',
      description:
          'Identify repeated logic and consider extracting reusable '
          'methods or components.',
      priority: 'Medium',
      icon: Icons.content_copy_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Code Health Analysis',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Understand the quality and maintainability of your codebase.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),

          _buildPrototypeNotice(),

          const SizedBox(height: 20),

          _buildSectionHeading(
            'Overall Code Health',
            'Combined illustrative quality score',
          ),
          const SizedBox(height: 12),
          _buildOverallScore(),

          const SizedBox(height: 24),

          _buildSectionHeading(
            'Quality Metrics',
            'Explore individual quality dimensions',
          ),
          const SizedBox(height: 12),
          ...metrics.map(
            (metric) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _MetricExpansionCard(metric: metric),
            ),
          ),

          const SizedBox(height: 14),

          _buildSectionHeading(
            'Issue Breakdown',
            'Illustrative findings by severity',
          ),
          const SizedBox(height: 12),
          _buildIssueBreakdown(),

          const SizedBox(height: 24),

          _buildSectionHeading(
            'Recommendations',
            'Suggested code quality improvements',
          ),
          const SizedBox(height: 12),
          ...recommendations.map(
            (recommendation) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RecommendationCard(recommendation: recommendation),
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'Prototype analysis · Real results require repository scanning',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildPrototypeNotice() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withOpacity(0.22)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.warning, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'These are sample values for the interface prototype. '
              'RepoMind will calculate actual scores after code analysis '
              'is connected.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallScore() {
    return _HealthPanel(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 360;

          return Row(
            children: [
              SizedBox(
                width: compact ? 82 : 100,
                height: compact ? 82 : 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: overallScore / 100,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.success,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$overallScore',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: compact ? 23 : 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            '/100',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'The sample repository has a good overall '
                      'quality score, with some areas that could '
                      'benefit from improvement.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIssueBreakdown() {
    return _HealthPanel(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Detected issues',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${issues.fold<int>(0, (sum, issue) => sum + issue.count)} total',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...issues.map(
            (issue) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _IssueRow(issue: issue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _HealthMetric {
  final String title;
  final int score;
  final String description;
  final IconData icon;
  final Color color;

  const _HealthMetric({
    required this.title,
    required this.score,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _HealthIssue {
  final String title;
  final int count;
  final Color color;
  final String description;

  const _HealthIssue({
    required this.title,
    required this.count,
    required this.color,
    required this.description,
  });
}

class _Recommendation {
  final String title;
  final String description;
  final String priority;
  final IconData icon;

  const _Recommendation({
    required this.title,
    required this.description,
    required this.priority,
    required this.icon,
  });
}

class _MetricExpansionCard extends StatelessWidget {
  final _HealthMetric metric;

  const _MetricExpansionCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 15),
        iconColor: AppColors.primaryLight,
        collapsedIconColor: AppColors.textMuted,
        leading: Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: metric.color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(metric.icon, color: metric.color, size: 19),
        ),
        title: Text(
          metric.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: metric.score / 100,
                    minHeight: 5,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(metric.color),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${metric.score}/100',
                style: TextStyle(
                  color: metric.color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              metric.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 9),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sample metric · Actual score pending analysis',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _IssueRow extends StatelessWidget {
  final _HealthIssue issue;

  const _IssueRow({required this.issue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(color: issue.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                issue.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                issue.description,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${issue.count}',
          style: TextStyle(
            color: issue.color,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final _Recommendation recommendation;

  const _RecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final isHighPriority = recommendation.priority == 'High';
    final priorityColor = isHighPriority ? AppColors.warning : AppColors.cyan;

    return _HealthPanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              recommendation.icon,
              color: AppColors.primaryLight,
              size: 19,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  recommendation.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${recommendation.priority} priority',
                    style: TextStyle(
                      color: priorityColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
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

class _HealthPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _HealthPanel({
    required this.child,
    this.padding = const EdgeInsets.all(17),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
