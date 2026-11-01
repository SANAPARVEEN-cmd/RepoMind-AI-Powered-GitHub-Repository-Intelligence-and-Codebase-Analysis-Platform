import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class RecentRepositoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String technologies;
  final String health;
  final IconData icon;

  const RecentRepositoryCard({
    super.key,
    required this.name,
    required this.description,
    required this.technologies,
    required this.health,
    this.icon = Icons.folder_copy_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repository information
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.18),
                  ),
                ),
                child: Icon(icon, color: AppColors.primaryLight, size: 21),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
                size: 21,
              ),
            ],
          ),

          const SizedBox(height: 17),

          // Technology labels
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: technologies
                .split(',')
                .map((technology) => technology.trim())
                .where((technology) => technology.isNotEmpty)
                .map(
                  (technology) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      technology,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 16),

          Divider(color: AppColors.border, height: 1),

          const SizedBox(height: 13),

          // Code health information
          Row(
            children: [
              const Icon(
                Icons.monitor_heart_outlined,
                color: AppColors.success,
                size: 16,
              ),

              const SizedBox(width: 7),

              const Expanded(
                child: Text(
                  'Code health',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Text(
                health,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),

              const SizedBox(width: 5),

              const Text(
                '●',
                style: TextStyle(color: AppColors.success, fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
