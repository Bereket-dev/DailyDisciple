import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Button, Badge } from '../components/ui';

const ReflectionScreen = ({ navigation }) => {
  const [savedReflection, setSavedReflection] = useState(false);
  const [answers, setAnswers] = useState({});

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity onPress={() => navigation.goBack()}>
          <Text style={styles.backButton}>←</Text>
        </TouchableOpacity>
        <Text style={styles.title}>AI Reflection</Text>
        <View style={{ width: 24 }} />
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Sermon Summary */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Sermon Summary</Text>
            <Badge label="AI GENERATED" variant="accent" />
          </View>
          <Card style={styles.summaryCard}>
            <Text style={styles.summaryText}>
              Pastor John explored how faith develops through challenging seasons
              of uncertainty. The sermon emphasized that trust is not built through
              comfortable circumstances but through encountering God's faithfulness
              in difficult times.
            </Text>
          </Card>
        </View>

        {/* Main Lessons */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Main Lessons Learned</Text>
          {[
            {
              title: 'Faith is a Process',
              desc: 'Trust develops gradually through experience',
            },
            {
              title: 'God is Constant',
              desc: 'His presence remains even when circumstances change',
            },
            {
              title: 'Trials Build Character',
              desc: 'Challenges refine our faith and develop perseverance',
            },
          ].map((lesson, idx) => (
            <Card key={idx} style={styles.lessonCard}>
              <View style={styles.lessonHeader}>
                <View style={styles.lessonNumber}>{idx + 1}</View>
                <View style={{ flex: 1 }}>
                  <Text style={styles.lessonTitle}>{lesson.title}</Text>
                  <Text style={styles.lessonDesc}>{lesson.desc}</Text>
                </View>
              </View>
            </Card>
          ))}
        </View>

        {/* Reflection Questions */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Reflection Questions</Text>
          {[
            'When have you experienced God\'s faithfulness in uncertain times?',
            'How can this sermon message apply to your current situation?',
            'What specific action can you take to deepen your trust in God?',
          ].map((question, idx) => (
            <Card key={idx} style={styles.questionCard}>
              <View style={styles.questionHeader}>
                <Text style={styles.questionNumber}>Q{idx + 1}</Text>
                <Text style={styles.questionText}>{question}</Text>
              </View>
              <TextInput
                style={styles.answerInput}
                placeholder="Your reflection..."
                placeholderTextColor={colors.textLight}
                multiline
                value={answers[idx] || ''}
                onChangeText={(text) => setAnswers({ ...answers, [idx]: text })}
              />
            </Card>
          ))}
        </View>

        {/* Practical Applications */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Practical Life Applications</Text>
          {[
            'Journal about a time when God came through for you',
            'Share this message with someone who needs encouragement',
            'Pray daily for someone facing uncertainty',
          ].map((app, idx) => (
            <Card key={idx} style={styles.appCard}>
              <View style={styles.appRow}>
                <View style={styles.appNumber}>{idx + 1}</View>
                <Text style={styles.appText}>{app}</Text>
              </View>
            </Card>
          ))}
        </View>

        {/* Prayer Suggestion */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Prayer Suggestion</Text>
          <Card style={styles.prayerCard}>
            <Text style={styles.prayerText}>
              "Father, help me trust You completely, even when I can't see the
              path ahead. Remind me of Your faithfulness in my past and give me
              courage for my future. May this week be a time of deepening faith."
            </Text>
          </Card>
        </View>

        {/* Generate Action Plan */}
        <View style={styles.section}>
          <Button
            label="Generate Action Plan"
            variant="primary"
            onPress={() => setSavedReflection(true)}
          />
          {savedReflection && (
            <Card style={styles.successCard}>
              <Text style={styles.successText}>✓ Reflection saved!</Text>
              <Text style={styles.successSubtext}>
                Your action plan is ready in the Actions tab
              </Text>
            </Card>
          )}
        </View>

        <View style={{ height: spacing.xl }} />
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.md,
    backgroundColor: colors.surface,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  backButton: {
    fontSize: 24,
    color: colors.primary,
    marginRight: spacing.md,
  },
  title: {
    ...typography.h3,
    color: colors.text,
    flex: 1,
  },
  content: {
    flex: 1,
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  section: {
    marginBottom: spacing.xl,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.text,
  },
  summaryCard: {
    backgroundColor: '#F9F6F3',
  },
  summaryText: {
    ...typography.body,
    color: colors.text,
    lineHeight: 24,
  },
  lessonCard: {
    marginBottom: spacing.md,
  },
  lessonHeader: {
    flexDirection: 'row',
    gap: spacing.md,
  },
  lessonNumber: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: colors.secondary,
    alignItems: 'center',
    justifyContent: 'center',
    ...typography.bodySmall,
    fontWeight: '700',
    color: colors.surface,
  },
  lessonTitle: {
    ...typography.bodySmall,
    color: colors.text,
    fontWeight: '700',
  },
  lessonDesc: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  questionCard: {
    marginBottom: spacing.md,
  },
  questionHeader: {
    flexDirection: 'row',
    gap: spacing.md,
    marginBottom: spacing.md,
  },
  questionNumber: {
    ...typography.caption,
    color: colors.secondary,
    fontWeight: '700',
  },
  questionText: {
    ...typography.body,
    color: colors.text,
    flex: 1,
  },
  answerInput: {
    backgroundColor: colors.background,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    minHeight: 60,
    ...typography.bodySmall,
    color: colors.text,
  },
  appCard: {
    marginBottom: spacing.md,
  },
  appRow: {
    flexDirection: 'row',
    gap: spacing.md,
    alignItems: 'flex-start',
  },
  appNumber: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    ...typography.caption,
    fontWeight: '700',
    color: colors.primary,
  },
  appText: {
    ...typography.body,
    color: colors.text,
    flex: 1,
  },
  prayerCard: {
    backgroundColor: '#FFF9F0',
    borderLeftWidth: 4,
    borderLeftColor: colors.secondary,
  },
  prayerText: {
    ...typography.body,
    color: colors.text,
    lineHeight: 24,
    fontStyle: 'italic',
  },
  successCard: {
    backgroundColor: '#F0FDF4',
    marginTop: spacing.lg,
  },
  successText: {
    ...typography.body,
    color: colors.success,
    fontWeight: '700',
  },
  successSubtext: {
    ...typography.bodySmall,
    color: colors.success,
    marginTop: spacing.xs,
    opacity: 0.8,
  },
});

export default ReflectionScreen;
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.md,
    backgroundColor: colors.surface,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  backButton: {
    fontSize: 24,
    color: colors.primary,
    marginRight: spacing.md,
  },
  title: {
    ...typography.h3,
    color: colors.text,
    flex: 1,
  },
  content: {
    flex: 1,
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  section: {
    marginBottom: spacing.xl,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.text,
  },
  summaryCard: {
    backgroundColor: '#F9F6F3',
  },
  summaryText: {
    ...typography.body,
    color: colors.text,
    lineHeight: 24,
  },
  lessonCard: {
    marginBottom: spacing.md,
  },
  lessonHeader: {
    flexDirection: 'row',
    gap: spacing.md,
  },
  lessonNumber: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: colors.secondary,
    alignItems: 'center',
    justifyContent: 'center',
    ...typography.bodySmall,
    fontWeight: '700',
    color: colors.surface,
  },
  lessonTitle: {
    ...typography.bodySmall,
    color: colors.text,
    fontWeight: '700',
  },
  lessonDesc: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  questionCard: {
    marginBottom: spacing.md,
  },
  questionHeader: {
    flexDirection: 'row',
    gap: spacing.md,
    marginBottom: spacing.md,
  },
  questionNumber: {
    ...typography.caption,
    color: colors.secondary,
    fontWeight: '700',
  },
  questionText: {
    ...typography.body,
    color: colors.text,
    flex: 1,
  },
  answerInput: {
    backgroundColor: colors.background,
    borderRadius: borderRadius.md,
    padding: spacing.md,
    minHeight: 60,
    ...typography.bodySmall,
    color: colors.text,
  },
  appCard: {
    marginBottom: spacing.md,
  },
  appRow: {
    flexDirection: 'row',
    gap: spacing.md,
    alignItems: 'flex-start',
  },
  appNumber: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    ...typography.caption,
    fontWeight: '700',
    color: colors.primary,
  },
  appText: {
    ...typography.body,
    color: colors.text,
    flex: 1,
  },
  prayerCard: {
    backgroundColor: '#FFF9F0',
    borderLeftWidth: 4,
    borderLeftColor: colors.secondary,
  },
  prayerText: {
    ...typography.body,
    color: colors.text,
    lineHeight: 24,
    fontStyle: 'italic',
  },
  successCard: {
    backgroundColor: '#F0FDF4',
    marginTop: spacing.lg,
  },
  successText: {
    ...typography.body,
    color: colors.success,
    fontWeight: '700',
  },
  successSubtext: {
    ...typography.bodySmall,
    color: colors.success,
    marginTop: spacing.xs,
    opacity: 0.8,
  },
});

export default ReflectionScreen;
