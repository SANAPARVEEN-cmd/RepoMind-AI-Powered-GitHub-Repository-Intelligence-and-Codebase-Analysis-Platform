import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
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

    final host = uri.host.toLowerCase();

    final isGitHubHost = host == 'github.com' || host == 'www.github.com';

    final hasRepositoryPath =
        uri.pathSegments.length >= 2 &&
        uri.pathSegments[0].isNotEmpty &&
        uri.pathSegments[1].isNotEmpty;

    return (uri.scheme == 'https' || uri.scheme == 'http') &&
        isGitHubHost &&
        uri.userInfo.isEmpty &&
        hasRepositoryPath;
  }

  Future<void> _analyzeRepository() async {
    if (_isLoading) return;

    final url = _urlController.text.trim();

    if (url.isEmpty) {
      _showMessage('Please enter a GitHub repository URL.');
      return;
    }

    if (!_isValidGitHubUrl(url)) {
      _showMessage('Please enter a valid GitHub repository URL.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Temporary delay for UI prototype.
    await Future.delayed(const Duration(milliseconds: 500));

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card heading
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: AppColors.primaryLight,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analyze a Repository',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Start exploring any public GitHub repository.',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Input label
          const Text(
            'GITHUB REPOSITORY URL',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 9),

          // GitHub URL input
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _analyzeRepository(),
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'https://github.com/owner/repository',
              hintStyle: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.link_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _urlController,
                builder: (context, value, child) {
                  if (value.text.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return IconButton(
                    tooltip: 'Clear URL',
                    onPressed: _isLoading ? null : () => _urlController.clear(),
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                  );
                },
              ),
              filled: true,
              fillColor: AppColors.surfaceInput,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Analyze button
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
                  : const Icon(Icons.arrow_forward_rounded, size: 19),
              label: Text(
                _isLoading ? 'Preparing analysis...' : 'Analyze Repository',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Privacy and prototype information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Prototype mode: actual repository analysis '
                  'will be connected through the backend.',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.5,
                    color: AppColors.textMuted,
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
