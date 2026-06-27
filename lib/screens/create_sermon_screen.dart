import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sermon_note.dart';
import '../widgets/app_widgets.dart';
import '../providers/sermon_provider.dart';

class CreateSermonScreen extends ConsumerStatefulWidget {
  const CreateSermonScreen({super.key});

  @override
  ConsumerState<CreateSermonScreen> createState() => _CreateSermonScreenState();
}

class _CreateSermonScreenState extends ConsumerState<CreateSermonScreen> {
  late TextEditingController titleCtrl;
  late TextEditingController dateCtrl;
  late TextEditingController topicCtrl;
  late TextEditingController preacherCtrl;
  late TextEditingController notesCtrl;
  late TextEditingController scriptureCtrl;
  late TextEditingController keyPointsCtrl;
  late TextEditingController quotesCtrl;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    dateCtrl = TextEditingController(text: DateTime.now().toString().split(' ')[0]);
    topicCtrl = TextEditingController();
    preacherCtrl = TextEditingController();
    notesCtrl = TextEditingController();
    scriptureCtrl = TextEditingController();
    keyPointsCtrl = TextEditingController();
    quotesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    dateCtrl.dispose();
    topicCtrl.dispose();
    preacherCtrl.dispose();
    notesCtrl.dispose();
    scriptureCtrl.dispose();
    keyPointsCtrl.dispose();
    quotesCtrl.dispose();
    super.dispose();
  }

  void _saveSermon() {
    final now = DateTime.now();
    final note = SermonNote(
      id: DateTime.now().millisecondsSinceEpoch,
      title: titleCtrl.text,
      date: dateCtrl.text,
      sermonTopic: topicCtrl.text,
      preacher: preacherCtrl.text,
      notes: notesCtrl.text,
      scripture: scriptureCtrl.text,
      keyPoints: keyPointsCtrl.text,
      quotes: quotesCtrl.text,
      createdAt: now,
      updatedAt: now,
    );

    ref.read(sermonNotesStateProvider.notifier).addSermonNote(note);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sermon Note'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Sermon Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateCtrl,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: preacherCtrl,
              decoration: const InputDecoration(labelText: 'Preacher Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: topicCtrl,
              decoration: const InputDecoration(labelText: 'Sermon Topic'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesCtrl,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: scriptureCtrl,
              decoration: const InputDecoration(labelText: 'Scripture References'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: keyPointsCtrl,
              decoration: const InputDecoration(labelText: 'Key Points'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quotesCtrl,
              decoration: const InputDecoration(labelText: 'Quotes'),
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Save Sermon',
              onPressed: _saveSermon,
            ),
          ],
        ),
      ),
    );
  }
}
