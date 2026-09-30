import 'package:flutter/material.dart';

class RepositoryOverviewScreen extends StatelessWidget {
  final String repositoryUrl;

  const RepositoryOverviewScreen({super.key, required this.repositoryUrl});

  String get repositoryName {
    final uri = Uri.tryParse(repositoryUrl);
    final segments = uri?.pathSegments ?? [];

    if (segments.length >= 2) {
      return '${segments[0]}/${segments[1]}';
    }

    return repositoryUrl;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Repository Overview')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Repository header
              _RepositoryHeader(
                repositoryName: repositoryName,
                repositoryUrl: repositoryUrl,
              ),

              const SizedBox(height: 20),

              // Repository metrics
              Text(
                'Repository Metrics',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.star_outline_rounded,
                      label: 'Stars',
                      value: '2.4k',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.call_split_rounded,
                      label: 'Forks',
                      value: '380',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.insert_drive_file_outlined,
                      label: 'Files',
                      value: '124',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Technology stack
              Text(
                'Technology Stack',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const _SectionCard(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _TechnologyChip(label: 'Flutter'),
                    _TechnologyChip(label: 'Dart'),
                    _TechnologyChip(label: 'Firebase'),
                    _TechnologyChip(label: 'REST API'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Code health
              Text(
                'Code Health',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              _SectionCard(
                child: Row(
                  children: [
                    SizedBox(
                      width: 76,
                      height: 76,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: 0.82,
                            strokeWidth: 8,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              primaryColor,
                            ),
                          ),
                          const Center(
                            child: Text(
                              '82',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
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
                            'Good code health',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'This is sample UI data. A real score will be calculated '
                            'after repository analysis is implemented.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
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

              // AI summary
              Text(
                'AI Repository Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const _SectionCard(
                child: Text(
                  'This repository appears to be a mobile application built with '
                  'Flutter and Dart. It includes a modular interface and integrates '
                  'with external services. RepoMind will generate a real summary '
                  'after connecting repository data and AI analysis.',
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.6,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Important files
              Text(
                'Important Files',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const _SectionCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _FileTile(
                      icon: Icons.description_outlined,
                      name: 'README.md',
                      description: 'Project documentation',
                    ),
                    Divider(height: 1, color: Colors.white12),
                    _FileTile(
                      icon: Icons.settings_outlined,
                      name: 'pubspec.yaml',
                      description: 'Dependencies and project configuration',
                    ),
                    Divider(height: 1, color: Colors.white12),
                    _FileTile(
                      icon: Icons.folder_outlined,
                      name: 'lib/',
                      description: 'Main application source code',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Detailed code analysis will be added in a later module.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.auto_awesome_rounded),
                  label: const Text('Explore Detailed Analysis'),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RepositoryHeader extends StatelessWidget {
  final String repositoryName;
  final String repositoryUrl;

  const _RepositoryHeader({
    required this.repositoryName,
    required this.repositoryUrl,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.code_rounded, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repositoryName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Public GitHub repository',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.open_in_new_rounded,
                color: Colors.white54,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            repositoryUrl,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white60, size: 19),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _TechnologyChip extends StatelessWidget {
  final String label;

  const _TechnologyChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _SectionCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF151B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: child,
    );
  }
}

class _FileTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;

  const _FileTile({
    required this.icon,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        name,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(color: Colors.white54, fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white38),
    );
  }
}
