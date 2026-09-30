import 'package:flutter/material.dart';

import '../../dashboard/presentation/analysis_progress_screen.dart';

class RepositoryInputCard extends StatefulWidget {
  const RepositoryInputCard({super.key});

  @override
  State<RepositoryInputCard> createState() => _RepositoryInputCardState();
}

class _RepositoryInputCardState extends State<RepositoryInputCard> {
  final TextEditingController _urlController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  bool _isValidGitHubUrl(String value) {
    final uri = Uri.tryParse(value.trim());

    if (uri == null) return false;

    final isGitHubHost =
        uri.host == 'github.com' || uri.host == 'www.github.com';

    final hasRepositoryPath =
        uri.pathSegments.length >= 2 &&
        uri.pathSegments[0].isNotEmpty &&
        uri.pathSegments[1].isNotEmpty;

    return (uri.scheme == 'https' || uri.scheme == 'http') &&
        isGitHubHost &&
        hasRepositoryPath;
  }

  Future<void> _analyzeRepository() async {
    final url = _urlController.text.trim();

    if (url.isEmpty) {
      _showMessage('Please enter a GitHub repository URL.');
      return;
    }

    if (!_isValidGitHubUrl(url)) {
      _showMessage(
        'Enter a valid GitHub repository URL, '
        'for example: https://github.com/flutter/flutter',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Small delay for visual feedback during this UI prototype.
    await Future.delayed(const Duration(milliseconds: 250));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisProgressScreen(repositoryUrl: url),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? const Color(0xFF151B2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analyze a Repository',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Paste a public GitHub repository URL to get started.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.60),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _analyzeRepository(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'https://github.com/username/repository',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.35),
                fontSize: 13,
              ),
              prefixIcon: Icon(
                Icons.link_rounded,
                color: Colors.white.withValues(alpha: 0.55),
              ),
              filled: true,
              fillColor: const Color(0xFF0D1324),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 17,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: _isLoading ? null : _analyzeRepository,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.bolt_rounded, size: 20),
              label: Text(
                _isLoading ? 'Preparing analysis...' : 'Analyze Repository',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: colorScheme.primary.withValues(
                  alpha: 0.55,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: Colors.white.withValues(alpha: 0.45),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'UI prototype: repository analysis is not connected yet.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
