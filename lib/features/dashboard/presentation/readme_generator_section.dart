import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';

class ReadmeGeneratorSection extends StatefulWidget {
  const ReadmeGeneratorSection({super.key});

  @override
  State<ReadmeGeneratorSection> createState() => _ReadmeGeneratorSectionState();
}

class _ReadmeGeneratorSectionState extends State<ReadmeGeneratorSection> {
  final _projectNameController = TextEditingController(text: 'RepoMind');

  final _descriptionController = TextEditingController(
    text: 'An AI-powered GitHub repository analysis platform.',
  );

  final _featuresController = TextEditingController(
    text:
        'Repository Structure Explorer\n'
        'Code Health Analysis\n'
        'Technical Debt Detection\n'
        'AI-powered Repository Insights',
  );

  final _technologiesController = TextEditingController(
    text: 'Flutter, Dart, Python, Django REST Framework',
  );

  String _selectedLicense = 'MIT';
  bool _generated = false;

  String _readmeContent = '';

  @override
  void initState() {
    super.initState();
    _generateReadme();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _descriptionController.dispose();
    _featuresController.dispose();
    _technologiesController.dispose();
    super.dispose();
  }

  void _generateReadme() {
    final name = _projectNameController.text.trim();
    final description = _descriptionController.text.trim();

    final features = _featuresController.text
        .split('\n')
        .where((item) => item.trim().isNotEmpty)
        .toList();

    final technologies = _technologiesController.text.trim();

    setState(() {
      _readmeContent =
          '''
# $name

$description

## Features

${features.map((feature) => '- $feature').join('\n')}

## Technologies Used

$technologies

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. Clone the repository.
2. Navigate to the project directory.
3. Install dependencies:

\`\`\`bash
flutter pub get
\`\`\`

4. Run the application:

\`\`\`bash
flutter run
\`\`\`

## License

This project is licensed under the $_selectedLicense License.
''';

      _generated = true;
    });
  }

  Future<void> _copyReadme() async {
    await Clipboard.setData(ClipboardData(text: _readmeContent));

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('README copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildGeneratorForm(),
        const SizedBox(height: 24),
        _buildPreviewHeader(),
        const SizedBox(height: 12),
        _buildMarkdownPreview(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.description_outlined,
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
                    'README Generator',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Create professional project documentation',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 15),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Prototype mode: documentation is generated from your inputs.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratorForm() {
    return _panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Project Information'),
          const SizedBox(height: 16),
          _fieldLabel('Project Name'),
          const SizedBox(height: 7),
          _textField(
            controller: _projectNameController,
            hint: 'Enter project name',
          ),
          const SizedBox(height: 15),
          _fieldLabel('Project Description'),
          const SizedBox(height: 7),
          _textField(
            controller: _descriptionController,
            hint: 'Describe your project',
            maxLines: 3,
          ),
          const SizedBox(height: 15),
          _fieldLabel('Key Features'),
          const SizedBox(height: 7),
          _textField(
            controller: _featuresController,
            hint: 'Enter each feature on a new line',
            maxLines: 5,
          ),
          const SizedBox(height: 15),
          _fieldLabel('Technologies'),
          const SizedBox(height: 7),
          _textField(
            controller: _technologiesController,
            hint: 'Flutter, Dart, Python...',
            maxLines: 2,
          ),
          const SizedBox(height: 15),
          _fieldLabel('License'),
          const SizedBox(height: 7),
          DropdownButtonFormField<String>(
            value: _selectedLicense,
            dropdownColor: AppColors.surfaceElevated,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
            decoration: _inputDecoration('Select license'),
            items: ['MIT', 'Apache 2.0', 'GPL 3.0', 'BSD 3-Clause']
                .map(
                  (license) =>
                      DropdownMenuItem(value: license, child: Text(license)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedLicense = value);
              }
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _generateReadme,
              icon: const Icon(Icons.auto_awesome, size: 17),
              label: const Text('Generate README'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewHeader() {
    return Row(
      children: [
        Expanded(child: _sectionTitle('Markdown Preview')),
        OutlinedButton.icon(
          onPressed: _generated ? _copyReadme : null,
          icon: const Icon(Icons.copy, size: 15),
          label: const Text('Copy'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            side: const BorderSide(color: AppColors.border),
            textStyle: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkdownPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceInput,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: SelectableText(
        _readmeContent,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.8,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      filled: true,
      fillColor: AppColors.surfaceInput,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
      ),
    );
  }
}
