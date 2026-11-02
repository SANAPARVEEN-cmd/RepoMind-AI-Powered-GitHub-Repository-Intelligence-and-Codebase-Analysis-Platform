import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';

class DocumentationScreen extends StatefulWidget {
  final String repositoryName;

  const DocumentationScreen({super.key, required this.repositoryName});

  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  int _selectedIndex = 0;
  bool _sidebarOpen = false;

  final List<_DocumentationItem> _items = [
    _DocumentationItem(
      title: 'README',
      subtitle: 'Project introduction and setup',
      icon: Icons.menu_book_outlined,
    ),
    _DocumentationItem(
      title: 'File Documentation',
      subtitle: 'Understand source files',
      icon: Icons.folder_open_outlined,
    ),
    _DocumentationItem(
      title: 'Classes & Functions',
      subtitle: 'Code elements and methods',
      icon: Icons.data_object,
    ),
    _DocumentationItem(
      title: 'API Reference',
      subtitle: 'Endpoints and responses',
      icon: Icons.api_outlined,
    ),
    _DocumentationItem(
      title: 'Architecture Guide',
      subtitle: 'Project structure and flow',
      icon: Icons.account_tree_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: MediaQuery.of(context).size.width < 850
          ? Drawer(
              backgroundColor: AppColors.surface,
              child: SafeArea(child: _buildSidebar()),
            )
          : null,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: MediaQuery.of(context).size.width < 850
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
        title: Text(
          widget.repositoryName,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Copy documentation',
            onPressed: _copyCurrentDocumentation,
            icon: const Icon(
              Icons.copy_outlined,
              color: AppColors.textSecondary,
              size: 19,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 850;

            return Row(
              children: [
                if (isDesktop) SizedBox(width: 255, child: _buildSidebar()),
                Expanded(child: _buildContent()),
              ],
            );
          },
        ),
      ),
    );
  }

  // DOCUMENTATION SIDEBAR

  Widget _buildSidebar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.menu_book_outlined,
                        color: AppColors.primaryLight,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Text(
                        'Documentation',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  widget.repositoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 22, 20, 10),
            child: Text(
              'DOCUMENTATION',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final selected = _selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });

                      if (MediaQuery.of(context).size.width < 850) {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withValues(alpha: 0.13)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(9),
                        border: selected
                            ? Border.all(
                                color: AppColors.primary.withValues(
                                  alpha: 0.25,
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 19,
                            color: selected
                                ? AppColors.primaryLight
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: selected
                                        ? AppColors.primaryLight
                                        : AppColors.textPrimary,
                                    fontSize: 12,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.subtitle,
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.primaryLight,
                              size: 17,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceInput,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: AppColors.primaryLight,
                    size: 17,
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Generated by RepoMind AI',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MAIN DOCUMENTATION CONTENT

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageHeader(),
        const Divider(height: 1, color: AppColors.border),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 950),
                child: _buildSelectedContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageHeader() {
    final item = _items[_selectedIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 14,
                ),
                SizedBox(width: 5),
                Text(
                  'Generated',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildReadme();
      case 1:
        return _buildPlaceholder(
          'File Documentation',
          'Explore individual files and understand their responsibilities.',
          Icons.folder_open_outlined,
        );
      case 2:
        return _buildPlaceholder(
          'Classes & Functions',
          'Explore classes, methods, parameters and return types.',
          Icons.data_object,
        );
      case 3:
        return _buildPlaceholder(
          'API Reference',
          'Explore API endpoints, request parameters and responses.',
          Icons.api_outlined,
        );
      case 4:
        return _buildPlaceholder(
          'Architecture Guide',
          'Understand the architecture and communication between components.',
          Icons.account_tree_outlined,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // README VIEWER

  Widget _buildReadme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoBanner(
          'Project documentation',
          'A guide to understanding, installing and using this repository.',
        ),
        const SizedBox(height: 22),
        _markdownHeading('# ${widget.repositoryName}'),
        const SizedBox(height: 10),
        const Text(
          'An AI-powered platform for analyzing GitHub repositories, '
          'understanding code quality and generating useful insights.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 25),
        _markdownHeading('## Features'),
        const SizedBox(height: 12),
        _bullet('Repository structure exploration'),
        _bullet('Code health analysis'),
        _bullet('Technical debt detection'),
        _bullet('Architecture analysis'),
        _bullet('AI-powered repository insights'),
        _bullet('Automated documentation generation'),
        const SizedBox(height: 25),
        _markdownHeading('## Technologies Used'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _technologyChip('Flutter'),
            _technologyChip('Dart'),
            _technologyChip('Python'),
            _technologyChip('Django REST Framework'),
          ],
        ),
        const SizedBox(height: 25),
        _markdownHeading('## Getting Started'),
        const SizedBox(height: 12),
        const Text(
          'Follow these steps to set up the project locally.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _codeBlock('flutter pub get'),
        const SizedBox(height: 10),
        _codeBlock('flutter run'),
        const SizedBox(height: 25),
        _markdownHeading('## Project Structure'),
        const SizedBox(height: 12),
        _codeBlock(
          'lib/\n'
          ' ├── core/\n'
          ' ├── features/\n'
          ' │    ├── dashboard/\n'
          ' │    ├── analysis/\n'
          ' │    └── documentation/\n'
          ' └── main.dart',
        ),
        const SizedBox(height: 25),
        _markdownHeading('## License'),
        const SizedBox(height: 10),
        const Text(
          'This project is currently using sample documentation. '
          'The final license information will be taken from the actual repository.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),
        _buildInfoBanner(
          'Prototype documentation',
          'This content is illustrative and will be replaced with '
              'documentation generated from the actual repository.',
        ),
      ],
    );
  }

  // PLACEHOLDER FOR UPCOMING SECTIONS

  Widget _buildPlaceholder(String title, String description, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 55),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 30),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'This section will be implemented next.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // REUSABLE UI COMPONENTS

  Widget _markdownHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 19,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _technologyChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
      ),
    );
  }

  Widget _codeBlock(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceInput,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.border),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          color: AppColors.cyan,
          fontSize: 12,
          height: 1.7,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildInfoBanner(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.info, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
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

  // COPY README

  Future<void> _copyCurrentDocumentation() async {
    if (_selectedIndex != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Documentation content is not available yet.'),
        ),
      );
      return;
    }

    final content =
        '''
# ${widget.repositoryName}

An AI-powered platform for analyzing GitHub repositories.

## Features
- Repository structure exploration
- Code health analysis
- Technical debt detection
- Architecture analysis
- AI-powered repository insights

## Technologies
Flutter, Dart, Python, Django REST Framework

## Getting Started
flutter pub get
flutter run
''';

    await Clipboard.setData(ClipboardData(text: content));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('README copied successfully!')),
    );
  }
}

class _DocumentationItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _DocumentationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
