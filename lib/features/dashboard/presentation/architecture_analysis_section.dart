import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ArchitectureAnalysisSection extends StatelessWidget {
  const ArchitectureAnalysisSection({super.key});

  static const List<_ArchitectureLayer> layers = [
    _ArchitectureLayer(
      title: 'Presentation Layer',
      subtitle: 'Screens, widgets and user interactions',
      files: 'lib/features/',
      icon: Icons.desktop_windows_outlined,
      color: AppColors.primaryLight,
    ),
    _ArchitectureLayer(
      title: 'Business Logic Layer',
      subtitle: 'Application rules and state management',
      files: 'Providers / BLoCs / Controllers',
      icon: Icons.account_tree_outlined,
      color: AppColors.cyan,
    ),
    _ArchitectureLayer(
      title: 'Data Layer',
      subtitle: 'Models, repositories and data access',
      files: 'Models / Repositories',
      icon: Icons.storage_outlined,
      color: AppColors.success,
    ),
    _ArchitectureLayer(
      title: 'Services Layer',
      subtitle: 'External APIs and supporting services',
      files: 'API / Authentication / Utilities',
      icon: Icons.cloud_outlined,
      color: AppColors.warning,
    ),
  ];

  static const List<_ArchitecturePattern> patterns = [
    _ArchitecturePattern(
      title: 'Layered Architecture',
      status: 'Likely',
      description:
          'The application separates presentation, business logic, '
          'and data responsibilities into different layers.',
      color: AppColors.success,
    ),
    _ArchitecturePattern(
      title: 'Feature-based Structure',
      status: 'Observed in sample',
      description:
          'Related functionality is grouped into feature folders, '
          'making modules easier to organize and maintain.',
      color: AppColors.cyan,
    ),
    _ArchitecturePattern(
      title: 'Clean Architecture',
      status: 'Not confirmed',
      description:
          'Requires further inspection of dependency direction, '
          'domain boundaries, and use-case organization.',
      color: AppColors.warning,
    ),
  ];

  static const List<_ArchitectureRecommendation> recommendations = [
    _ArchitectureRecommendation(
      title: 'Maintain clear layer boundaries',
      description:
          'Keep UI components separate from business rules and data access.',
      priority: 'High',
      icon: Icons.layers_outlined,
    ),
    _ArchitectureRecommendation(
      title: 'Use repository abstractions',
      description:
          'Centralize data operations to make the application easier '
          'to test and maintain.',
      priority: 'Medium',
      icon: Icons.folder_copy_outlined,
    ),
    _ArchitectureRecommendation(
      title: 'Reduce module dependencies',
      description:
          'Avoid unnecessary direct dependencies between unrelated features.',
      priority: 'Medium',
      icon: Icons.device_hub_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),

        const Text(
          'Architecture Analysis',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Understand how the project is structured and how its '
          'components work together.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),
        _buildPrototypeNotice(),

        const SizedBox(height: 22),
        _sectionHeading(
          'Architecture Overview',
          'Illustrative architecture classification',
        ),
        const SizedBox(height: 12),
        _buildOverview(),

        const SizedBox(height: 24),
        _sectionHeading(
          'Architecture Layers',
          'Explore the responsibilities of each layer',
        ),
        const SizedBox(height: 12),
        ...layers.map(
          (layer) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _LayerCard(layer: layer),
          ),
        ),

        const SizedBox(height: 14),
        _sectionHeading(
          'Component Relationships',
          'Illustrative application flow',
        ),
        const SizedBox(height: 12),
        _buildArchitectureFlow(),

        const SizedBox(height: 24),
        _sectionHeading(
          'Architecture Patterns',
          'Potential patterns used in the project',
        ),
        const SizedBox(height: 12),
        ...patterns.map(
          (pattern) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _PatternCard(pattern: pattern),
          ),
        ),

        const SizedBox(height: 14),
        _sectionHeading(
          'Architecture Recommendations',
          'Suggested structural improvements',
        ),
        const SizedBox(height: 12),
        ...recommendations.map(
          (recommendation) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _RecommendationCard(recommendation: recommendation),
          ),
        ),

        const SizedBox(height: 12),
        const Center(
          child: Text(
            'Prototype analysis · Actual architecture detection pending',
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
              'This section displays sample architecture information. '
              'Actual project structure and patterns will be detected '
              'after repository scanning is implemented.',
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

  Widget _buildOverview() {
    return _ArchitecturePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_tree_rounded,
                  color: AppColors.primaryLight,
                  size: 24,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Layered Architecture',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Illustrative classification',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Sample',
                  style: TextStyle(
                    color: AppColors.warning,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 15),
          const Row(
            children: [
              Expanded(
                child: _OverviewStat(
                  value: '4',
                  label: 'Layers',
                  icon: Icons.layers_outlined,
                ),
              ),
              Expanded(
                child: _OverviewStat(
                  value: '3',
                  label: 'Patterns',
                  icon: Icons.schema_outlined,
                ),
              ),
              Expanded(
                child: _OverviewStat(
                  value: '3',
                  label: 'Suggestions',
                  icon: Icons.lightbulb_outline_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureFlow() {
    return _ArchitecturePanel(
      child: Column(
        children: [
          _FlowNode(
            title: 'Presentation',
            subtitle: 'Screens and UI',
            icon: Icons.desktop_windows_outlined,
            color: AppColors.primaryLight,
          ),
          _flowArrow(),
          _FlowNode(
            title: 'Business Logic',
            subtitle: 'Application rules',
            icon: Icons.settings_suggest_outlined,
            color: AppColors.cyan,
          ),
          _flowArrow(),
          _FlowNode(
            title: 'Data Layer',
            subtitle: 'Models and repositories',
            icon: Icons.storage_outlined,
            color: AppColors.success,
          ),
          _flowArrow(),
          _FlowNode(
            title: 'External Services',
            subtitle: 'APIs and integrations',
            icon: Icons.cloud_outlined,
            color: AppColors.warning,
          ),
          const SizedBox(height: 12),
          const Text(
            'Conceptual flow only — actual dependencies may differ.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _flowArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Icon(
        Icons.arrow_downward_rounded,
        color: AppColors.textMuted,
        size: 19,
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

class _ArchitectureLayer {
  final String title;
  final String subtitle;
  final String files;
  final IconData icon;
  final Color color;

  const _ArchitectureLayer({
    required this.title,
    required this.subtitle,
    required this.files,
    required this.icon,
    required this.color,
  });
}

class _ArchitecturePattern {
  final String title;
  final String status;
  final String description;
  final Color color;

  const _ArchitecturePattern({
    required this.title,
    required this.status,
    required this.description,
    required this.color,
  });
}

class _ArchitectureRecommendation {
  final String title;
  final String description;
  final String priority;
  final IconData icon;

  const _ArchitectureRecommendation({
    required this.title,
    required this.description,
    required this.priority,
    required this.icon,
  });
}

// --------------------------------------------------
// REUSABLE PANEL
// --------------------------------------------------

class _ArchitecturePanel extends StatelessWidget {
  final Widget child;

  const _ArchitecturePanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

// --------------------------------------------------
// OVERVIEW STAT
// --------------------------------------------------

class _OverviewStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _OverviewStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 18),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// ARCHITECTURE LAYER CARD
// --------------------------------------------------

class _LayerCard extends StatelessWidget {
  final _ArchitectureLayer layer;

  const _LayerCard({required this.layer});

  @override
  Widget build(BuildContext context) {
    return _ArchitecturePanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: layer.color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(layer.icon, color: layer.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  layer.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  layer.subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  layer.files,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
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
// ARCHITECTURE FLOW NODE
// --------------------------------------------------

class _FlowNode extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _FlowNode({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
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
// ARCHITECTURE PATTERN CARD
// --------------------------------------------------

class _PatternCard extends StatelessWidget {
  final _ArchitecturePattern pattern;

  const _PatternCard({required this.pattern});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        iconColor: AppColors.primaryLight,
        collapsedIconColor: AppColors.textMuted,
        title: Text(
          pattern.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            pattern.status,
            style: TextStyle(
              color: pattern.color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              pattern.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// RECOMMENDATION CARD
// --------------------------------------------------

class _RecommendationCard extends StatelessWidget {
  final _ArchitectureRecommendation recommendation;

  const _RecommendationCard({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final isHigh = recommendation.priority == 'High';
    final priorityColor = isHigh ? AppColors.warning : AppColors.cyan;

    return _ArchitecturePanel(
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
