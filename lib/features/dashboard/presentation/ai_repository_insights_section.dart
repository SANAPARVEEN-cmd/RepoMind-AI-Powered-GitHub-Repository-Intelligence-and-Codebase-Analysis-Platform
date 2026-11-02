import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class AiRepositoryInsightsSection extends StatefulWidget {
  const AiRepositoryInsightsSection({super.key});

  @override
  State<AiRepositoryInsightsSection> createState() =>
      _AiRepositoryInsightsSectionState();
}

class _AiRepositoryInsightsSectionState
    extends State<AiRepositoryInsightsSection> {
  int selectedTab = 0;
  String selectedPriority = 'All';

  final List<String> tabs = [
    'Summary',
    'Technologies',
    'Recommendations',
    'Risks',
  ];

  final List<_AiRecommendation> recommendations = const [
    _AiRecommendation(
      title: 'Improve error handling',
      description:
          'Introduce consistent exception handling and meaningful error '
          'messages across application modules.',
      reason:
          'Inconsistent error handling can make debugging difficult and '
          'may cause unexpected application behavior.',
      priority: 'High',
      category: 'Code Quality',
      icon: Icons.bug_report_outlined,
    ),
    _AiRecommendation(
      title: 'Optimize database queries',
      description:
          'Review frequently executed queries and consider indexing '
          'where appropriate.',
      reason:
          'Inefficient queries can increase response times as the '
          'application grows.',
      priority: 'High',
      category: 'Performance',
      icon: Icons.speed_rounded,
    ),
    _AiRecommendation(
      title: 'Improve code reusability',
      description:
          'Extract repeated logic into reusable functions and components.',
      reason:
          'Reusable code reduces duplication and makes future changes '
          'easier to maintain.',
      priority: 'Medium',
      category: 'Maintainability',
      icon: Icons.recycling_rounded,
    ),
    _AiRecommendation(
      title: 'Review project documentation',
      description:
          'Keep setup instructions, API descriptions, and contribution '
          'guidelines updated.',
      reason:
          'Clear documentation helps developers understand and contribute '
          'to the project.',
      priority: 'Low',
      category: 'Documentation',
      icon: Icons.menu_book_outlined,
    ),
  ];

  final List<_AiRisk> risks = const [
    _AiRisk(
      title: 'Dependency vulnerabilities',
      description: 'Third-party packages may contain known security issues.',
      severity: 'High',
      action: 'Review dependency versions and run a security audit.',
      icon: Icons.inventory_2_outlined,
    ),
    _AiRisk(
      title: 'Insufficient input validation',
      description:
          'Unvalidated user input may introduce unexpected behavior '
          'or security weaknesses.',
      severity: 'Medium',
      action: 'Validate and sanitize user input at appropriate boundaries.',
      icon: Icons.input_rounded,
    ),
    _AiRisk(
      title: 'Limited automated testing',
      description:
          'Insufficient test coverage may allow regressions to go unnoticed.',
      severity: 'Medium',
      action: 'Introduce unit and integration tests for critical workflows.',
      icon: Icons.science_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),

        const Text(
          'AI Repository Insights',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Understand your repository through intelligent insights '
          'and actionable suggestions.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),
        _buildPrototypeNotice(),

        const SizedBox(height: 20),
        _buildAiHeader(),

        const SizedBox(height: 20),
        _buildTabs(),

        const SizedBox(height: 16),
        _buildSelectedContent(),

        const SizedBox(height: 14),
        const Center(
          child: Text(
            'Illustrative AI insights · Live AI analysis not connected',
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
              'These are sample insights for the UI prototype. '
              'Actual findings will be generated after connecting '
              'repository scanning and the AI service.',
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

  Widget _buildAiHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
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
                      'RepoMind AI Assistant',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Repository intelligence overview',
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
                  'DEMO',
                  style: TextStyle(
                    color: AppColors.warning,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 15),
          const Text(
            'Your repository has several opportunities for improvement. '
            'Explore the insights below to understand potential areas '
            'for better code quality, performance, and maintainability.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Expanded(
                child: _InsightStat(
                  value: '04',
                  label: 'Suggestions',
                  icon: Icons.lightbulb_outline_rounded,
                ),
              ),
              Expanded(
                child: _InsightStat(
                  value: '03',
                  label: 'Potential risks',
                  icon: Icons.shield_outlined,
                ),
              ),
              Expanded(
                child: _InsightStat(
                  value: '04',
                  label: 'Categories',
                  icon: Icons.category_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedTab == index;

            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.18)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primaryLight
                          : AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (selectedTab) {
      case 0:
        return _buildSummary();
      case 1:
        return _buildTechnologies();
      case 2:
        return _buildRecommendations();
      case 3:
        return _buildRisks();
      default:
        return const SizedBox.shrink();
    }
  }

  // --------------------------------------------------
  // SUMMARY TAB
  // --------------------------------------------------

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Repository Summary',
          'AI-generated project explanation',
        ),
        const SizedBox(height: 12),
        _InsightPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.summarize_outlined,
                    color: AppColors.primaryLight,
                    size: 19,
                  ),
                  SizedBox(width: 9),
                  Text(
                    'Project Overview',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'This repository represents a software application '
                'organized into different functional modules. Its '
                'structure can help developers understand the project, '
                'identify important components, and maintain its codebase.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Key observations',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const _BulletPoint(
                text: 'Project modules can be organized by responsibility.',
              ),
              const _BulletPoint(
                text: 'Reusable components can improve maintainability.',
              ),
              const _BulletPoint(
                text: 'Testing and documentation can strengthen reliability.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _sectionHeading('AI Highlights', 'Important areas to explore'),
        const SizedBox(height: 12),
        const _HighlightCard(
          title: 'Code Quality',
          description: 'Review code organization and consistency.',
          icon: Icons.code_rounded,
          color: AppColors.cyan,
        ),
        const SizedBox(height: 9),
        const _HighlightCard(
          title: 'Performance',
          description: 'Look for opportunities to optimize operations.',
          icon: Icons.speed_rounded,
          color: AppColors.success,
        ),
        const SizedBox(height: 9),
        const _HighlightCard(
          title: 'Security',
          description: 'Review input validation and dependencies.',
          icon: Icons.security_outlined,
          color: AppColors.warning,
        ),
      ],
    );
  }

  // --------------------------------------------------
  // TECHNOLOGIES TAB
  // --------------------------------------------------

  Widget _buildTechnologies() {
    const technologies = [
      _TechnologyInsight(
        name: 'Flutter',
        role: 'Application framework',
        explanation:
            'Used to build the application interface and cross-platform UI.',
        icon: Icons.flutter_dash,
        color: AppColors.cyan,
      ),
      _TechnologyInsight(
        name: 'Dart',
        role: 'Programming language',
        explanation:
            'Powers application logic, widgets, and asynchronous operations.',
        icon: Icons.code_rounded,
        color: AppColors.primaryLight,
      ),
      _TechnologyInsight(
        name: 'REST API',
        role: 'Communication layer',
        explanation:
            'Can connect the Flutter application with backend services.',
        icon: Icons.api_rounded,
        color: AppColors.success,
      ),
      _TechnologyInsight(
        name: 'AI Service',
        role: 'Intelligence layer',
        explanation:
            'Can interpret repository information and generate insights.',
        icon: Icons.auto_awesome_rounded,
        color: AppColors.warning,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Technology Insights',
          'Example technologies and their roles',
        ),
        const SizedBox(height: 12),
        ...technologies.map(
          (technology) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _TechnologyCard(technology: technology),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'These are example technologies for the RepoMind prototype, '
          'not an automatically detected repository stack.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // RECOMMENDATIONS TAB
  // --------------------------------------------------

  Widget _buildRecommendations() {
    final filteredRecommendations = recommendations.where((item) {
      return selectedPriority == 'All' || item.priority == selectedPriority;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'AI Recommendations',
          'Actionable suggestions for improvement',
        ),
        const SizedBox(height: 13),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['All', 'High', 'Medium', 'Low'].map((priority) {
              final selected = selectedPriority == priority;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      selectedPriority = priority;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary.withOpacity(0.18)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Text(
                      priority,
                      style: TextStyle(
                        color: selected
                            ? AppColors.primaryLight
                            : AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 14),
        if (filteredRecommendations.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No recommendations found.',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          )
        else
          ...filteredRecommendations.map(
            (recommendation) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RecommendationTile(recommendation: recommendation),
            ),
          ),
      ],
    );
  }

  // --------------------------------------------------
  // RISKS TAB
  // --------------------------------------------------

  Widget _buildRisks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Potential Repository Risks',
          'Areas that may require further investigation',
        ),
        const SizedBox(height: 12),
        ...risks.map(
          (risk) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _RiskTile(risk: risk),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_outlined, color: AppColors.cyan, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'These are example risks, not confirmed security '
                  'vulnerabilities. Actual detection requires dependency '
                  'and source-code analysis.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

class _AiRecommendation {
  final String title;
  final String description;
  final String reason;
  final String priority;
  final String category;
  final IconData icon;

  const _AiRecommendation({
    required this.title,
    required this.description,
    required this.reason,
    required this.priority,
    required this.category,
    required this.icon,
  });
}

class _AiRisk {
  final String title;
  final String description;
  final String severity;
  final String action;
  final IconData icon;

  const _AiRisk({
    required this.title,
    required this.description,
    required this.severity,
    required this.action,
    required this.icon,
  });
}

class _TechnologyInsight {
  final String name;
  final String role;
  final String explanation;
  final IconData icon;
  final Color color;

  const _TechnologyInsight({
    required this.name,
    required this.role,
    required this.explanation,
    required this.icon,
    required this.color,
  });
}

// --------------------------------------------------
// REUSABLE PANEL
// --------------------------------------------------

class _InsightPanel extends StatelessWidget {
  final Widget child;

  const _InsightPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

// --------------------------------------------------
// INSIGHT STAT
// --------------------------------------------------

class _InsightStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _InsightStat({
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
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 9),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// BULLET POINT
// --------------------------------------------------

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.success,
            size: 15,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
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
}

// --------------------------------------------------
// HIGHLIGHT CARD
// --------------------------------------------------

class _HighlightCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _HighlightCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return _InsightPanel(
      child: Row(
        children: [
          Icon(icon, color: color, size: 21),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
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
// TECHNOLOGY CARD
// --------------------------------------------------

class _TechnologyCard extends StatelessWidget {
  final _TechnologyInsight technology;

  const _TechnologyCard({required this.technology});

  @override
  Widget build(BuildContext context) {
    return _InsightPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: technology.color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(technology.icon, color: technology.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  technology.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  technology.role,
                  style: TextStyle(
                    color: technology.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  technology.explanation,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    height: 1.5,
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
// RECOMMENDATION TILE
// --------------------------------------------------

class _RecommendationTile extends StatelessWidget {
  final _AiRecommendation recommendation;

  const _RecommendationTile({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final priorityColor = recommendation.priority == 'High'
        ? AppColors.danger
        : recommendation.priority == 'Medium'
        ? AppColors.warning
        : AppColors.cyan;

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
        leading: Icon(
          recommendation.icon,
          color: AppColors.primaryLight,
          size: 21,
        ),
        title: Text(
          recommendation.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            recommendation.category,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: priorityColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            recommendation.priority,
            style: TextStyle(
              color: priorityColor,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              recommendation.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Why this matters',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              recommendation.reason,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// RISK TILE
// --------------------------------------------------

class _RiskTile extends StatelessWidget {
  final _AiRisk risk;

  const _RiskTile({required this.risk});

  @override
  Widget build(BuildContext context) {
    final riskColor = risk.severity == 'High'
        ? AppColors.danger
        : AppColors.warning;

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
        leading: Icon(risk.icon, color: riskColor, size: 21),
        title: Text(
          risk.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${risk.severity} severity · Sample risk',
            style: TextStyle(color: riskColor, fontSize: 10),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              risk.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Suggested action',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              risk.action,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
