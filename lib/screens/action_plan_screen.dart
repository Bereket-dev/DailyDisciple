import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../models/action_plan.dart';
import '../providers/action_provider.dart';
import '../constants/theme.dart';

class ActionPlanScreen extends ConsumerStatefulWidget {
  const ActionPlanScreen({super.key});

  @override
  ConsumerState<ActionPlanScreen> createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends ConsumerState<ActionPlanScreen> {
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    final actionPlans = ref.watch(actionPlansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Action Plan'),
        elevation: 0,
      ),
      body: actionPlans.when(
        data: (actions) {
          final incomplete = actions.where((a) => !a.isCompleted).toList();
          final completed = actions.where((a) => a.isCompleted).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pending', style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Text(
                                '${incomplete.length}',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppTheme.primaryNavy,
                                ),
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
                              Text('Completed', style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Text(
                                '${completed.length}',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppTheme.successGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (incomplete.isEmpty && completed.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: EmptyState(
                      icon: '✨',
                      title: 'No Actions Yet',
                      subtitle: 'Create actions from your sermon notes',
                    ),
                  ),
                if (incomplete.isNotEmpty) ...[
                  SectionHeader(title: 'Pending Actions'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: incomplete.length,
                    itemBuilder: (context, index) {
                      final action = incomplete[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: AppCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {
                                  final updated = action.copyWith(isCompleted: true);
                                  ref.read(actionPlansStateProvider.notifier).updateActionPlan(updated);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(action.title, style: Theme.of(context).textTheme.bodyLarge),
                                    const SizedBox(height: 8),
                                    BadgeWidget(label: action.category),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                if (completed.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        Text('Completed Actions', style: Theme.of(context).textTheme.headlineSmall),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => showCompleted = !showCompleted),
                          child: Text(
                            showCompleted ? 'Hide' : 'Show',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.primaryNavy,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showCompleted)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: completed.length,
                      itemBuilder: (context, index) {
                        final action = completed[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: AppCard(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (value) {
                                    final updated = action.copyWith(isCompleted: false);
                                    ref.read(actionPlansStateProvider.notifier).updateActionPlan(updated);
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        action.title,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      BadgeWidget(
                                        label: action.category,
                                        backgroundColor: AppTheme.successGreen,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryNavy,
        onPressed: () => _showAddActionDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddActionDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String category = 'Personal';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Action'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Action Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final now = DateTime.now();
              final action = ActionPlan(
                id: DateTime.now().millisecondsSinceEpoch,
                title: titleCtrl.text,
                description: descCtrl.text,
                category: category,
                sermonNoteId: 0,
                createdAt: now,
                updatedAt: now,
              );
              ref.read(actionPlansStateProvider.notifier).addActionPlan(action);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
