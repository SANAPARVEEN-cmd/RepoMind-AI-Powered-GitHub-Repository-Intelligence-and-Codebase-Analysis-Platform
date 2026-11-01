import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';

class RepositoryOverviewScreen extends StatefulWidget {
  final String repositoryUrl;

  const RepositoryOverviewScreen({super.key, required this.repositoryUrl});

  @override
  State<RepositoryOverviewScreen> createState() =>
      _RepositoryOverviewScreenState();
}

class _RepositoryOverviewScreenState extends State<RepositoryOverviewScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  String get repositoryName {
    final uri = Uri.tryParse(widget.repositoryUrl);
    final segments = uri?.pathSegments ?? [];

    if (segments.length >= 2) {
      return '${segments[0]}/${segments[1]}';
    }

    return 'GitHub Repository';
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _copyRepositoryUrl() {
    Clipboard.setData(ClipboardData(text: widget.repositoryUrl));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Repository URL copied'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showMetricDetails(String title, String description) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sample data. Real values will be fetched '
                'through GitHub API integration.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  // Keeps dashboard content centered and prevents
  // excessive stretching on wide desktop screens.
  Widget _buildResponsivePage(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Overview'),
        actions: [
          IconButton(
            onPressed: _copyRepositoryUrl,
            tooltip: 'Copy repository URL',
            icon: const Icon(Icons.copy_rounded),
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryLight,
          indicatorWeight: 3,
          labelColor: AppColors.primaryLight,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(
              icon: Icon(Icons.dashboard_outlined, size: 18),
              text: 'Overview',
            ),
            Tab(
              icon: Icon(Icons.folder_open_outlined, size: 18),
              text: 'Files',
            ),
            Tab(
              icon: Icon(Icons.auto_awesome_outlined, size: 18),
              text: 'Insights',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildResponsivePage(_buildOverviewTab()),
            _buildResponsivePage(_FilesTab()),
            _buildResponsivePage(_InsightsTab()),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // OVERVIEW TAB
  // --------------------------------------------------

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _buildRepositoryHeader(),

        const SizedBox(height: 24),

        _sectionHeading('Repository Metrics', 'Tap a metric to learn more'),

        const SizedBox(height: 12),

        // Responsive metric grid
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 700;

            return GridView.count(
              crossAxisCount: isDesktop ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isDesktop ? 2.0 : 1.65,
              children: [
                _MetricCard(
                  icon: Icons.star_outline_rounded,
                  label: 'Stars',
                  value: '2.4k',
                  color: const Color(0xFFFBBF24),
                  onTap: () => _showMetricDetails(
                    'Stars',
                    'Stars represent how many GitHub users '
                        'have shown interest in this repository.',
                  ),
                ),
                _MetricCard(
                  icon: Icons.call_split_rounded,
                  label: 'Forks',
                  value: '380',
                  color: AppColors.cyan,
                  onTap: () => _showMetricDetails(
                    'Forks',
                    'Forks are copies of a repository that users '
                        'can independently modify.',
                  ),
                ),
                _MetricCard(
                  icon: Icons.visibility_outlined,
                  label: 'Watchers',
                  value: '156',
                  color: AppColors.primaryLight,
                  onTap: () => _showMetricDetails(
                    'Watchers',
                    'Watchers receive notifications about activity '
                        'in a GitHub repository.',
                  ),
                ),
                _MetricCard(
                  icon: Icons.insert_drive_file_outlined,
                  label: 'Files',
                  value: '124',
                  color: AppColors.success,
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 26),

        _sectionHeading('Technology Stack', 'Detected technologies · Sample'),

        const SizedBox(height: 12),

        _Panel(
          child: Wrap(
            spacing: 9,
            runSpacing: 10,
            children: const [
              _TechChip(label: 'Flutter'),
              _TechChip(label: 'Dart'),
              _TechChip(label: 'Firebase'),
              _TechChip(label: 'REST API'),
              _TechChip(label: 'Material UI'),
            ],
          ),
        ),

        const SizedBox(height: 26),

        _sectionHeading('Code Health', 'Illustrative score'),

        const SizedBox(height: 12),

        _buildCodeHealth(),

        const SizedBox(height: 26),

        _sectionHeading('Repository Activity', 'Sample distribution'),

        const SizedBox(height: 12),

        _buildActivity(),

        const SizedBox(height: 26),

        _sectionHeading('Repository Summary', 'Prototype insight'),

        const SizedBox(height: 12),

        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.primaryLight,
                    size: 20,
                  ),
                  SizedBox(width: 9),
                  Text(
                    'AI Overview',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'This section will provide a clear explanation '
                'of the repository purpose, architecture, '
                'technologies and important implementation details.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => _tabController.animateTo(2),
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Explore AI Insights'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRepositoryHeader() {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: AppColors.primaryLight,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repositoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(
                          Icons.public_rounded,
                          color: AppColors.success,
                          size: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'GitHub repository',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _copyRepositoryUrl,
                icon: const Icon(
                  Icons.link_rounded,
                  color: AppColors.textSecondary,
                ),
                tooltip: 'Copy URL',
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppColors.surfaceInput,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.link_rounded,
                  color: AppColors.textMuted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.repositoryUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          const Row(
            children: [
              Icon(Icons.info_outline_rounded, color: AppColors.cyan, size: 15),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Preview dashboard · Sample repository data',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCodeHealth() {
    return _Panel(
      child: Row(
        children: [
          SizedBox(
            height: 92,
            width: 92,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.82,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  backgroundColor: AppColors.border,
                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                ),
                const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '82',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
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

          const SizedBox(width: 20),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good code health',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'A sample score representing code quality, '
                  'maintainability and structure.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
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

  Widget _buildActivity() {
    final activities = [
      ('Dart', 0.65, AppColors.primaryLight),
      ('Kotlin', 0.20, AppColors.cyan),
      ('Swift', 0.10, AppColors.success),
      ('Other', 0.05, AppColors.warning),
    ];

    return _Panel(
      child: Column(
        children: activities.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.$1,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${(item.$2 * 100).round()}%',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: item.$2,
                    minHeight: 7,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(item.$3),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
            fontSize: 16,
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
// FILE EXPLORER TAB
// --------------------------------------------------

class _FilesTab extends StatefulWidget {
  @override
  State<_FilesTab> createState() => _FilesTabState();
}

class _FilesTabState extends State<_FilesTab> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<_RepositoryFile> _files = const [
    _RepositoryFile(
      name: 'README.md',
      description: 'Project documentation',
      category: 'Docs',
      icon: Icons.description_outlined,
    ),
    _RepositoryFile(
      name: 'pubspec.yaml',
      description: 'Dependencies and configuration',
      category: 'Config',
      icon: Icons.settings_outlined,
    ),
    _RepositoryFile(
      name: 'main.dart',
      description: 'Application entry point',
      category: 'Code',
      icon: Icons.code_rounded,
    ),
    _RepositoryFile(
      name: 'app_theme.dart',
      description: 'Application theme configuration',
      category: 'Code',
      icon: Icons.palette_outlined,
    ),
    _RepositoryFile(
      name: 'assets/',
      description: 'Images and static assets',
      category: 'Folder',
      icon: Icons.folder_outlined,
    ),
    _RepositoryFile(
      name: 'analysis_options.yaml',
      description: 'Linting and analysis rules',
      category: 'Config',
      icon: Icons.rule_folder_outlined,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFileDetails(_RepositoryFile file) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(file.icon, color: AppColors.primaryLight, size: 30),
              const SizedBox(height: 14),
              Text(
                file.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                file.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Category: ${file.category}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'File preview will be connected to the GitHub API later.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFiles = _files.where((file) {
      final matchesSearch = file.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      final matchesFilter =
          _selectedFilter == 'All' || file.category == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Repository Explorer',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Search and explore important repository files.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'Search files...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),

        const SizedBox(height: 16),

        Wrap(
          spacing: 8,
          children: ['All', 'Code', 'Docs', 'Config', 'Folder'].map((filter) {
            final selected = _selectedFilter == filter;

            return ChoiceChip(
              label: Text(filter),
              selected: selected,
              onSelected: (_) {
                setState(() => _selectedFilter = filter);
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              labelStyle: TextStyle(
                color: selected
                    ? AppColors.primaryLight
                    : AppColors.textSecondary,
                fontSize: 11,
              ),
              side: BorderSide(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Files and folders',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            Text(
              '${filteredFiles.length} items',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (filteredFiles.isEmpty)
          const _Panel(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No matching files found.',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            ),
          )
        else
          _Panel(
            padding: EdgeInsets.zero,
            child: Column(
              children: filteredFiles.map((file) {
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    onTap: () => _showFileDetails(file),
                    leading: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(
                        file.icon,
                        color: AppColors.primaryLight,
                        size: 19,
                      ),
                    ),
                    title: Text(
                      file.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      file.description,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 20),

        const Text(
          'Showing sample repository files. Live file discovery '
          'will be implemented with GitHub integration.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _RepositoryFile {
  final String name;
  final String description;
  final String category;
  final IconData icon;

  const _RepositoryFile({
    required this.name,
    required this.description,
    required this.category,
    required this.icon,
  });
}

// --------------------------------------------------
// AI INSIGHTS TAB
// --------------------------------------------------

class _InsightsTab extends StatelessWidget {
  const _InsightsTab();

  static const List<_Insight> insights = [
    _Insight(
      title: 'Architecture Overview',
      subtitle: 'Understand how the project is organized',
      icon: Icons.account_tree_outlined,
      content:
          'This section will explain the repository architecture, '
          'major modules, component relationships and application flow.',
    ),
    _Insight(
      title: 'Technology Analysis',
      subtitle: 'Understand the technologies used',
      icon: Icons.memory_rounded,
      content:
          'RepoMind will identify programming languages, frameworks, '
          'libraries and dependencies from repository files.',
    ),
    _Insight(
      title: 'Code Quality',
      subtitle: 'Discover maintainability concerns',
      icon: Icons.health_and_safety_outlined,
      content:
          'This analysis will highlight potential code smells, '
          'complexity, duplication and maintainability concerns.',
    ),
    _Insight(
      title: 'Technical Debt',
      subtitle: 'Identify areas that need improvement',
      icon: Icons.build_circle_outlined,
      content:
          'This section will explain possible technical debt, '
          'outdated dependencies and areas that may require refactoring.',
    ),
    _Insight(
      title: 'Recommendations',
      subtitle: 'Explore suggested improvements',
      icon: Icons.lightbulb_outline_rounded,
      content:
          'RepoMind will provide actionable recommendations to improve '
          'the repository structure, code quality and documentation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'AI Insights',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Explore different dimensions of repository intelligence.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primary.withOpacity(0.25)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.primaryLight,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intelligence Center',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'AI-powered insights will be available after '
                      'backend integration.',
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
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Analysis Categories',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 12),

        ...insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _InsightTile(insight: insight),
          );
        }),
      ],
    );
  }
}

class _Insight {
  final String title;
  final String subtitle;
  final String content;
  final IconData icon;

  const _Insight({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.icon,
  });
}

class _InsightTile extends StatelessWidget {
  final _Insight insight;

  const _InsightTile({required this.insight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 16),
        iconColor: AppColors.primaryLight,
        collapsedIconColor: AppColors.textMuted,
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(insight.icon, color: AppColors.primaryLight, size: 20),
        ),
        title: Text(
          insight.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            insight.subtitle,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              insight.content,
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
              'Prototype content · AI analysis pending',
              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// REUSABLE UI COMPONENTS
// --------------------------------------------------

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 9),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primaryLight,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _Panel({required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
