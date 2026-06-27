import '../models/sermon_note.dart';
import '../models/action_plan.dart';
import '../models/journal_entry.dart';

class MockData {
  static List<SermonNote> getMockSermonNotes() {
    final now = DateTime.now();
    return [
      SermonNote(
        id: 1,
        title: 'Faith in the Storm',
        date: now.subtract(const Duration(days: 7)).toIso8601String(),
        sermonTopic: 'Trust in God During Trials',
        preacher: 'Pastor John',
        notes: 'God promises to be with us in every storm. Mark 4:35-41 shows how Jesus calmed the storm. Key point: Our faith should be in God, not in our circumstances.',
        scripture: 'Mark 4:35-41, Philippians 4:6-7',
        keyPoints: '1. Fear is natural but faith should override it\n2. Jesus is present in our storms\n3. Peace comes from trust in God',
        quotes: '"Peace I leave with you; my peace I give you." - John 14:27',
        reflectionSummary: 'God is always with us, even in our darkest moments.',
        lessonsLearned: 'I learned that trust is a choice we make daily.',
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
      ),
      SermonNote(
        id: 2,
        title: 'Love Your Neighbor',
        date: now.subtract(const Duration(days: 14)).toIso8601String(),
        sermonTopic: 'The Greatest Commandment',
        preacher: 'Pastor Sarah',
        notes: 'Jesus taught us that the greatest commandment is to love God and love our neighbors as ourselves. This is not just a feeling but an action.',
        scripture: 'Matthew 22:37-40, Luke 10:25-37',
        keyPoints: '1. Love is both a command and a privilege\n2. Our neighbors include everyone\n3. Love requires action, not just emotion',
        quotes: '"By this everyone will know that you are my disciples, if you love one another." - John 13:35',
        createdAt: now.subtract(const Duration(days: 14)),
        updatedAt: now.subtract(const Duration(days: 14)),
      ),
      SermonNote(
        id: 3,
        title: 'Forgiveness and Freedom',
        date: now.subtract(const Duration(days: 21)).toIso8601String(),
        sermonTopic: 'Letting Go of Resentment',
        preacher: 'Pastor Michael',
        notes: 'Forgiveness is not about condoning what was done, but about freeing ourselves from bitterness. When we forgive, we are choosing freedom.',
        scripture: 'Colossians 3:13, Matthew 18:21-35',
        keyPoints: '1. Forgiveness is for our own healing\n2. We must forgive as Christ forgave us\n3. Unforgiveness binds us, forgiveness frees us',
        quotes: '"Forgive us our debts, as we also have forgiven our debtors." - Matthew 6:12',
        createdAt: now.subtract(const Duration(days: 21)),
        updatedAt: now.subtract(const Duration(days: 21)),
      ),
    ];
  }

  static List<ActionPlan> getMockActionPlans() {
    final now = DateTime.now();
    return [
      ActionPlan(
        id: 1,
        title: 'Read Mark 4 Daily',
        description: 'Spend 10 minutes each morning reading and meditating on the Gospel of Mark.',
        sermonNoteId: 1,
        category: 'Daily Discipline',
        isCompleted: false,
        dueDate: now.add(const Duration(days: 7)).millisecondsSinceEpoch,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
      ActionPlan(
        id: 2,
        title: 'Reach out to a neighbor',
        description: 'Call or visit someone who is struggling to show Christ\'s love.',
        sermonNoteId: 2,
        category: 'Outreach',
        isCompleted: true,
        completedDate: now.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      ActionPlan(
        id: 3,
        title: 'Write a forgiveness letter',
        description: 'Write (but don\'t send) a letter forgiving someone who hurt you.',
        sermonNoteId: 3,
        category: 'Personal Growth',
        isCompleted: false,
        dueDate: now.add(const Duration(days: 14)).millisecondsSinceEpoch,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      ActionPlan(
        id: 4,
        title: 'Prayer time extension',
        description: 'Add 5 extra minutes to your daily prayer routine.',
        sermonNoteId: 1,
        category: 'Prayer Life',
        isCompleted: true,
        completedDate: now.millisecondsSinceEpoch,
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now,
      ),
    ];
  }

  static List<JournalEntry> getMockJournalEntries() {
    final now = DateTime.now();
    return [
      JournalEntry(
        id: 1,
        title: 'Gratitude for Today',
        content: 'I\'m grateful for my family, good health, and a job that allows me to serve others. God\'s blessings are abundant.',
        type: 'gratitude',
        mood: 'joyful',
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      JournalEntry(
        id: 2,
        title: 'Reflection on Grace',
        content: 'Today I was reminded that God\'s grace is sufficient for all my needs. Even when I stumble, His mercy is new every morning.',
        type: 'reflection',
        mood: 'peaceful',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      JournalEntry(
        id: 3,
        title: 'Evening Prayer',
        content: 'God, thank you for this day. Please guide my steps tomorrow. Help me to be more patient and loving. Watch over my loved ones.',
        type: 'prayer',
        mood: 'hopeful',
        createdAt: now.subtract(const Duration(days: 1, hours: 8)),
        updatedAt: now.subtract(const Duration(days: 1, hours: 8)),
      ),
      JournalEntry(
        id: 4,
        title: 'Struggle with Pride',
        content: 'I realized today that I acted with pride in a conversation. I need to work on humility and remember that Christ exalts the humble.',
        type: 'reflection',
        mood: 'contemplative',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      JournalEntry(
        id: 5,
        title: 'Thankful for Community',
        content: 'My church family showed me incredible support this week. I\'m thankful for their prayers and encouragement.',
        type: 'gratitude',
        mood: 'grateful',
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  static void initializeMockData() {
    // This would be called at app startup to populate the database with mock data
  }
}
