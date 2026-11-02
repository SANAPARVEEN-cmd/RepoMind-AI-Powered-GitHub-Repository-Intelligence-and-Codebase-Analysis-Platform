import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class RepositoryStructureTab extends StatefulWidget {
  final String repositoryName;

  const RepositoryStructureTab({super.key, required this.repositoryName});

  @override
  State<RepositoryStructureTab> createState() => _RepositoryStructureTabState();
}

class _RepositoryStructureTabState extends State<RepositoryStructureTab> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  final Set<String> _expandedFolders = {'lib', 'lib/core', 'lib/features'};

  // Temporary repository structure.
  // Later, this will come from the GitHub API.
  final List<_TreeNode> _repositoryTree = [
    _TreeNode.folder(
      name: 'lib',
      path: 'lib',
      children: [
        _TreeNode.folder(
          name: 'core',
          path: 'lib/core',
          children: [
            _TreeNode.folder(
              name: 'constants',
              path: 'lib/core/constants',
              children: [
                _TreeNode.file(
                  name: 'app_colors.dart',
                  path: 'lib/core/constants/app_colors.dart',
                ),
                _TreeNode.file(
                  name: 'app_theme.dart',
                  path: 'lib/core/constants/app_theme.dart',
                ),
              ],
            ),
            _TreeNode.folder(
              name: 'widgets',
              path: 'lib/core/widgets',
              children: [
                _TreeNode.file(
                  name: 'app_card.dart',
                  path: 'lib/core/widgets/app_card.dart',
                ),
              ],
            ),
          ],
        ),
        _TreeNode.folder(
          name: 'features',
          path: 'lib/features',
          children: [
            _TreeNode.folder(
              name: 'dashboard',
              path: 'lib/features/dashboard',
              children: [
                _TreeNode.folder(
                  name: 'presentation',
                  path: 'lib/features/dashboard/presentation',
                  children: [
                    _TreeNode.file(
                      name: 'dashboard_screen.dart',
                      path: 'lib/features/dashboard/presentation/dashboard_screen.dart',
                    ),
                    _TreeNode.file(
                      name: 'repository_overview_screen.dart',
                      path: 'lib/features/dashboard/presentation/repository_overview_screen.dart',
                    ),
                  ],
                ),
              ],
            ),
            _TreeNode.folder(
              name: 'analysis',
              path: 'lib/features/analysis',
              children: [
                _TreeNode.folder(
                  name: 'presentation',
                  path: 'lib/features/analysis/presentation',
                  children: [
                    _TreeNode.file(
                      name: 'analysis_progress_screen.dart',
                      path: 'lib/features/analysis/presentation/analysis_progress_screen.dart',
                    ),
                    _TreeNode.file(
                      name: 'repository_structure_tab.dart',
                      path: 'lib/features/analysis/presentation/repository_structure_tab.dart',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        _TreeNode.file(name: 'main.dart', path: 'lib/main.dart'),
      ],
    ),
    _TreeNode.folder(
      name: 'assets',
      path: 'assets',
      children: [
        _TreeNode.folder(name: 'images', path: 'assets/images', children: []),
        _TreeNode.folder(name: 'icons', path: 'assets/icons', children: []),
      ],
    ),
    _TreeNode.folder(
      name: 'test',
      path: 'test',
      children: [
        _TreeNode.file(name: 'widget_test.dart', path: 'test/widget_test.dart'),
      ],
    ),
    _TreeNode.file(name: 'pubspec.yaml', path: 'pubspec.yaml'),
    _TreeNode.file(name: 'README.md', path: 'README.md'),
    _TreeNode.file(
      name: 'analysis_options.yaml',
      path: 'analysis_options.yaml',
    ),
    _TreeNode.file(name: '.gitignore', path: '.gitignore'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _countFiles(List<_TreeNode> nodes) {
    int count = 0;

    for (final node in nodes) {
      if (node.isFolder) {
        count += _countFiles(node.children);
      } else {
        count++;
      }
    }

    return count;
  }

  int _countFolders(List<_TreeNode> nodes) {
    int count = 0;

    for (final node in nodes) {
      if (node.isFolder) {
        count++;
        count += _countFolders(node.children);
      }
    }

    return count;
  }

  bool _matchesSearch(_TreeNode node) {
    if (_searchQuery.isEmpty) return true;

    if (node.name.toLowerCase().contains(_searchQuery.toLowerCase())) {
      return true;
    }

    if (node.isFolder) {
      return node.children.any(_matchesSearch);
    }

    return false;
  }

  List<Widget> _buildTree(List<_TreeNode> nodes, {int depth = 0}) {
    final visibleNodes = nodes.where(_matchesSearch).toList();

    return visibleNodes.expand((node) {
      final isExpanded = _expandedFolders.contains(node.path);

      final widgets = <Widget>[_buildTreeItem(node, depth, isExpanded)];

      if (node.isFolder && isExpanded) {
        widgets.addAll(_buildTree(node.children, depth: depth + 1));
      }

      return widgets;
    }).toList();
  }

  Widget _buildTreeItem(_TreeNode node, int depth, bool isExpanded) {
    final icon = node.isFolder
        ? (isExpanded ? Icons.folder_open_rounded : Icons.folder_rounded)
        : _getFileIcon(node.name);

    final iconColor = node.isFolder
        ? const Color(0xFFFBBF24)
        : _getFileColor(node.name);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (node.isFolder) {
            setState(() {
              if (isExpanded) {
                _expandedFolders.remove(node.path);
              } else {
                _expandedFolders.add(node.path);
              }
            });
          } else {
            _showFileDetails(node);
          }
        },
        borderRadius: BorderRadius.circular(9),
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.0 + (depth * 20),
            right: 12,
            top: 11,
            bottom: 11,
          ),
          child: Row(
            children: [
              if (node.isFolder)
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_right_rounded,
                  color: AppColors.textMuted,
                  size: 19,
                )
              else
                const SizedBox(width: 19),

              const SizedBox(width: 5),

              Icon(icon, color: iconColor, size: 19),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  node.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: node.isFolder
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: node.isFolder
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),

              if (node.isFolder)
                Text(
                  '${node.children.length}',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFileIcon(String name) {
    final extension = name.contains('.')
        ? name.split('.').last.toLowerCase()
        : '';

    switch (extension) {
      case 'dart':
        return Icons.code_rounded;
      case 'js':
      case 'jsx':
      case 'ts':
      case 'tsx':
        return Icons.javascript_rounded;
      case 'py':
        return Icons.terminal_rounded;
      case 'json':
      case 'yaml':
      case 'yml':
        return Icons.data_object_rounded;
      case 'md':
        return Icons.description_outlined;
      case 'html':
        return Icons.language_rounded;
      case 'css':
        return Icons.palette_outlined;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'svg':
        return Icons.image_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _getFileColor(String name) {
    final extension = name.contains('.')
        ? name.split('.').last.toLowerCase()
        : '';

    switch (extension) {
      case 'dart':
        return AppColors.cyan;
      case 'js':
      case 'jsx':
      case 'ts':
      case 'tsx':
        return const Color(0xFFFBBF24);
      case 'py':
        return const Color(0xFF60A5FA);
      case 'md':
        return AppColors.success;
      case 'json':
      case 'yaml':
      case 'yml':
        return AppColors.primaryLight;
      default:
        return AppColors.textMuted;
    }
  }

  void _showFileDetails(_TreeNode node) {
    final extension = node.name.contains('.')
        ? node.name.split('.').last.toUpperCase()
        : 'FILE';

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getFileIcon(node.name),
                    color: _getFileColor(node.name),
                    size: 27,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      node.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _detailRow('File type', extension),
              const SizedBox(height: 13),
              _detailRow('Full path', node.path),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceInput,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.cyan,
                      size: 17,
                    ),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'File content preview will be added '
                        'when GitHub API integration is ready.',
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
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 11),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalFiles = _countFiles(_repositoryTree);
    final totalFolders = _countFolders(_repositoryTree);

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Header
        const Text(
          'Repository Structure',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          widget.repositoryName,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),

        const SizedBox(height: 20),

        // Statistics
        Row(
          children: [
            Expanded(
              child: _StructureStat(
                icon: Icons.insert_drive_file_outlined,
                value: '$totalFiles',
                label: 'Files',
                color: AppColors.cyan,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StructureStat(
                icon: Icons.folder_outlined,
                value: '$totalFolders',
                label: 'Folders',
                color: const Color(0xFFFBBF24),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StructureStat(
                icon: Icons.account_tree_outlined,
                value: '3',
                label: 'Root items',
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Search
        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Search folders and files...',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                : null,
          ),
        ),

        const SizedBox(height: 18),

        // Tree heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'File Explorer',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _expandedFolders
                    ..clear()
                    ..addAll(['lib', 'lib/core', 'lib/features']);
                });
              },
              icon: const Icon(Icons.unfold_more_rounded, size: 16),
              label: const Text('Reset tree', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Tree container
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.folder_copy_outlined,
                      color: AppColors.primaryLight,
                      size: 17,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.repositoryName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Text(
                      'MOCK DATA',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 9,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: AppColors.border, height: 1),

              const SizedBox(height: 6),

              ..._buildTree(_repositoryTree),

              if (_repositoryTree.where(_matchesSearch).isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No matching files or folders found.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'Prototype note: This structure is sample data. '
          'Real folders and files will be loaded from the selected '
          'GitHub repository in the backend integration module.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _TreeNode {
  final String name;
  final String path;
  final bool isFolder;
  final List<_TreeNode> children;

  const _TreeNode.folder({
    required this.name,
    required this.path,
    required this.children,
  }) : isFolder = true;

  const _TreeNode.file({required this.name, required this.path})
    : isFolder = false,
      children = const [];
}

class _StructureStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StructureStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
