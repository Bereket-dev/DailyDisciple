import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../constants/theme.dart';
import '../providers/sermon_provider.dart';
import '../providers/action_provider.dart';
import '../providers/journal_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sermonNotes = ref.watch(sermonNotesProvider);
    final actionPlans = ref.watch(incompleteActionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Disciple'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Greeting Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Disciple',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Today\'s verse: "For I know the plans I have for you" - Jeremiah 29:11',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Quick Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📝',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 8),
                          sermonNotes.when(
                            data: (notes) => Text(
                              '${notes.length} Notes',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            loading: () => const Text('--'),
                            error: (_, __) => const Text('--'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sermons captured',
                            style: Theme.of(context).textTheme.bodySmall,
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
                          Text(
                            '✨',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 8),
                          actionPlans.when(
                            data: (actions) => Text(
                              '${actions.length} Tasks',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            loading: () => const Text('--'),
                            error: (_, __) => const Text('--'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pending actions',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Sermons
            SectionHeader(
              title: 'Recent Sermons',
              onViewAll: () => context.push('/home/sermon-notes'),
            ),
            sermonNotes.when(
              data: (notes) {
                if (notes.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: EmptyState(
                      icon: '📝',
                      title: 'No Sermons Yet',
                      subtitle: 'Start capturing your first sermon notes',
                      actionLabel: 'Add Sermon',
                      onAction: () => context.push('/home/sermon-notes/create'),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.take(3).length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: AppCard(
                        onTap: () => context.push('/home/sermon-notes/${note.id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              note.date,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.sermonTopic,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Error loading sermons: $err'),
              ),
            ),
            const SizedBox(height: 24),

            // Action Item
            SectionHeader(
              title: 'Today\'s Actions',
              onViewAll: () => context.push('/home/actions'),
            ),
            actionPlans.when(
              data: (actions) {
                if (actions.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'All caught up! 🎉',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: actions.take(3).length,
                  itemBuilder: (context, index) {
                    final action = actions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Checkbox(
                              value: action.isCompleted,
                              onChanged: (value) {
                                final updated = action.copyWith(isCompleted: value ?? false);
                                ref.read(actionPlansStateProvider.notifier).updateActionPlan(updated);
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.title,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  BadgeWidget(
                                    label: action.category,
                                    backgroundColor: AppTheme.primaryNavy,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Error loading actions: $err'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New Sermon'),
        icon: const Icon(Icons.add),
        backgroundColor: AppTheme.primaryNavy,
        onPressed: () => context.push('/home/sermon-notes/create'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceWhite,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Sermons'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Actions'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              context.push('/home/sermon-notes');
              break;
            case 2:
              context.push('/home/actions');
              break;
            case 3:
              context.push('/home/journal');
              break;
            case 4:
              context.push('/home/profile');
              break;
          }
        },
      ),
    );
  }
}
