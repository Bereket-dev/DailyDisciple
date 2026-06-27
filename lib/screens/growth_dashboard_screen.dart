import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../providers/sermon_provider.dart';
import '../providers/action_provider.dart';
import '../providers/journal_provider.dart';
import '../constants/theme.dart';

class GrowthDashboardScreen extends ConsumerWidget {
  const GrowthDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sermonNotes = ref.watch(sermonNotesProvider);
    final actions = ref.watch(actionPlansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Growth Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Spiritual Journey',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            
            // Key Metrics
            Text('Key Metrics', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Notes', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        sermonNotes.when(
                          data: (notes) => Text('${notes.length}', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.primaryNavy)),
                          loading: () => const Text('--'),
                          error: (_, __) => const Text('--'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Actions Done', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        actions.when(
                          data: (acts) {
                            final completed = acts.where((a) => a.isCompleted).length;
                            return Text('$completed', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.successGreen));
                          },
                          loading: () => const Text('--'),
                          error: (_, __) => const Text('--'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Progress This Week
            Text('This Week\'s Progress', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Consistency', style: Theme.of(context).textTheme.bodyMedium),
                      Text('75%', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ProgressBar(progress: 0.75),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Milestones
            Text('Recent Milestones', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeWidget(label: '✨ 5-Day Streak', backgroundColor: AppTheme.secondaryGold),
                  const SizedBox(height: 12),
                  BadgeWidget(label: '📝 10 Sermons Captured'),
                  const SizedBox(height: 12),
                  BadgeWidget(label: '✅ 8 Actions Completed'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Breakdown
            Text('Activity Summary', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                return Column(
                  children: [
                    Container(
                      width: 40,
                      height: 80,
                      decoration: BoxDecoration(
                        color: index < 5 ? AppTheme.successGreen : AppTheme.dividerLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(days[index], style: Theme.of(context).textTheme.bodySmall),
                  ],
                );
              }),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
