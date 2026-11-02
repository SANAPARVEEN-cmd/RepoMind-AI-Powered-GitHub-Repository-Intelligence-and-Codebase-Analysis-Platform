import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class TechnicalDebtAnalysisSection extends StatelessWidget {
  const TechnicalDebtAnalysisSection({super.key});

  // Illustrative prototype values.
  static const int debtScore = 72;

  static const List<_DebtSeverity> severities = [
    _DebtSeverity(
      title: 'Critical',
      count: 2,
      color: AppColors.danger,
      description: 'Requires immediate attention.',
    ),
    _DebtSeverity(
      title: 'High',
      count: 5,
      color: Color(0xFFFB923C),
      description: 'Should be addressed soon.',
    ),
    _DebtSeverity(
      title: 'Medium',
      count: 8,
      color: AppColors.warning,
      description: 'Recommended for future improvements.',
    ),
    _DebtSeverity(
      title: 'Low',
      count: 12,
      color: AppColors.cyan,
      description: 'Minor cleanup opportunities.',
    ),
  ];

  static const List<_DebtCategory> categories = [
    _DebtCategory(
      title: 'Code Smells',
      count: 8,
      icon: Icons.warning_amber_rounded,
      description:
          'Patterns in the code that may indicate deeper design or '
          'maintainability problems.',
      color: AppColors.warning,
    ),
    _DebtCategory(
      title: 'Code Duplication',
      count: 6,
      icon: Icons.copy_all_outlined,
      description:
          'Repeated blocks of code that could potentially be replaced '
          'with reusable methods or components.',
      color: AppColors.cyan,
    ),
    _DebtCategory(
      title: 'Outdated Dependencies',
      count: 3,
      icon: Icons.inventory_2_outlined,
      description:
          'Dependencies that may require version updates or compatibility '
          'reviews.',
      color: AppColors.primaryLight,
    ),
    _DebtCategory(
      title: 'Complex Code',
      count: 5,
      icon: Icons.account_tree_outlined,
      description:
          'Functions or components that may be difficult to understand, '
          'test, or maintain.',
      color: AppColors.success,
    ),
  ];

  static const List<_DebtRecommendation> recommendations = [
    _DebtRecommendation(
      title: 'Refactor complex functions',
      description:
          'Split large functions into smaller methods with clear '
          'responsibilities.',
      priority: 'High',
      icon: Icons.functions_rounded,
    ),
    _DebtRecommendation(
      title: 'Remove duplicated logic',
      description: 'Extract repeated code into reusable methods or components.',
      priority: 'High',
      icon: Icons.copy_rounded,
    ),
    _DebtRecommendation(
      title: 'Review dependency versions',
      description:
          'Check available updates and review compatibility before '
          'upgrading packages.',
      priority: 'Medium',
      icon: Icons.system_update_alt_rounded,
    ),
    _DebtRecommendation(
      title: 'Improve code organization',
      description:
          'Group related functionality into clear modules and keep '
          'responsibilities separated.',
      priority: 'Medium',
      icon: Icons.folder_open_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),

        const Text(
          'Technical Debt Analysis',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Identify areas that may require refactoring and maintenance.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),

        _buildPrototypeNotice(),

        const SizedBox(height: 20),

        _sectionHeading(
          'Technical Debt Overview',
          'Illustrative debt assessment',
        ),
        const SizedBox(height: 12),
        _buildDebtScore(),

        const SizedBox(height: 24),

        _sectionHeading('Debt Severity', 'Issues grouped by priority'),
        const SizedBox(height: 12),
        _buildSeverityBreakdown(),

        const SizedBox(height: 24),

        _sectionHeading('Debt Categories', 'Explore potential problem areas'),
        const SizedBox(height: 12),

        ...categories.map(
          (category) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _DebtCategoryCard(category: category),
          ),
        ),

        const SizedBox(height: 14),

        _sectionHeading('Refactoring Opportunities', 'Suggested improvements'),
        const SizedBox(height: 12),

        ...recommendations.map(
          (recommendation) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _DebtRecommendationCard(recommendation: recommendation),
          ),
        ),

        const SizedBox(height: 12),

        const Center(
          child: Text(
            'Prototype analysis · Actual technical debt detection pending',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ),
      ],
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
              'Sample technical debt findings are displayed here. '
              'Real findings will be generated after repository scanning '
              'is implemented.',
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

  Widget _buildDebtScore() {
    return _DebtPanel(
      child: Row(
        children: [
          SizedBox(
            height: 94,
            width: 94,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: debtScore / 100,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  backgroundColor: AppColors.border,
                  valueColor: const AlwaysStoppedAnimation(AppColors.warning),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$debtScore',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 25,
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
                  'Moderate Debt',
                  style: TextStyle(
                    color: AppColors.warning,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Some areas may require attention to improve '
                  'long-term maintainability.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Illustrative score only',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityBreakdown() {
    return _DebtPanel(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Issue distribution',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${severities.fold<int>(0, (sum, item) => sum + item.count)} total',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...severities.map(
            (severity) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _SeverityRow(severity: severity),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title, String subtitle) {
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

// --------------------------------------------------
// DATA MODELS
// --------------------------------------------------

class _DebtSeverity {
  final String title;
  final int count;
  final Color color;
  final String description;

  const _DebtSeverity({
    required this.title,
    required this.count,
    required this.color,
    required this.description,
  });
}

class _DebtCategory {
  final String title;
  final int count;
  final IconData icon;
  final String description;
  final Color color;

  const _DebtCategory({
    required this.title,
    required this.count,
    required this.icon,
    required this.description,
    required this.color,
  });
}

class _DebtRecommendation {
  final String title;
  final String description;
  final String priority;
  final IconData icon;

  const _DebtRecommendation({
    required this.title,
    required this.description,
    required this.priority,
    required this.icon,
  });
}

// --------------------------------------------------
// DEBT CATEGORY CARD
// --------------------------------------------------

class _DebtCategoryCard extends StatelessWidget {
  final _DebtCategory category;

  const _DebtCategoryCard({required this.category});

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
          height: 39,
          width: 39,
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(category.icon, color: category.color, size: 19),
        ),
        title: Text(
          category.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${category.count} sample findings',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textMuted,
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sample findings · Actual detection pending',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// SEVERITY ROW
// --------------------------------------------------

class _SeverityRow extends StatelessWidget {
  final _DebtSeverity severity;

  const _SeverityRow({required this.severity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 9,
          width: 9,
          decoration: BoxDecoration(
            color: severity.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                severity.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                severity.description,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${severity.count}',
          style: TextStyle(
            color: severity.color,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// RECOMMENDATION CARD
// --------------------------------------------------

class _DebtRecommendationCard extends StatelessWidget {
  final _DebtRecommendation recommendation;

  const _DebtRecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final isHigh = recommendation.priority == 'High';
    final priorityColor = isHigh ? AppColors.warning : AppColors.cyan;

    return _DebtPanel(
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

// --------------------------------------------------
// REUSABLE PANEL
// --------------------------------------------------

class _DebtPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _DebtPanel({
    required this.child,
    this.padding = const EdgeInsets.all(16),
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
