import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Badge, ProgressBar } from '../components/ui';

const ActionsScreen = ({ navigation }) => {
  const [completedActions, setCompletedActions] = useState({});

  const toggleAction = (id) => {
    setCompletedActions((prev) => ({
      ...prev,
      [id]: !prev[id],
    }));
  };

  const actions = [
    {
      id: 1,
      task: 'Read Psalm 23',
      sermon: 'Building Faith',
      dueDate: 'Today',
      priority: 'high',
    },
    {
      id: 2,
      task: 'Pray for family members',
      sermon: 'Building Faith',
      dueDate: 'Tomorrow',
      priority: 'high',
    },
    {
      id: 3,
      task: 'Journal reflection',
      sermon: 'Building Faith',
      dueDate: 'This Week',
      priority: 'medium',
    },
    {
      id: 4,
      task: 'Practice meditation',
      sermon: 'Trust in God',
      dueDate: 'This Week',
      priority: 'medium',
    },
  ];

  const completedCount = Object.values(completedActions).filter(Boolean).length;
  const completionPercentage = actions.length ? completedCount / actions.length : 0;

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Action Steps</Text>
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Streak Counter */}
        <Card style={styles.streakCard}>
          <View style={styles.streakContent}>
            <View>
              <Text style={styles.streakNumber}>7</Text>
              <Text style={styles.streakLabel}>Day Streak</Text>
            </View>
            <View style={styles.streakFire}>🔥</View>
          </View>
          <Text style={styles.streakMessage}>Keep going! You're building a habit.</Text>
        </Card>

        {/* Weekly Goals */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Weekly Discipleship Goals</Text>
          <Card style={styles.goalCard}>
            <View style={styles.goalHeader}>
              <View>
                <Text style={styles.goalTitle}>This Week's Progress</Text>
                <Text style={styles.goalMeta}>{completedCount} of {actions.length} completed</Text>
              </View>
              <Text style={styles.goalPercent}>{Math.round(completionPercentage * 100)}%</Text>
            </View>
            <ProgressBar progress={completionPercentage} height={12} />
          </Card>
        </View>

        {/* Today's Tasks */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Today's Tasks</Text>
          {actions
            .filter((a) => a.dueDate === 'Today')
            .map((action) => (
              <Card
                key={action.id}
                style={[
                  styles.actionCard,
                  completedActions[action.id] && styles.actionCardCompleted,
                ]}
              >
                <TouchableOpacity
                  style={styles.actionRow}
                  onPress={() => toggleAction(action.id)}
                >
                  <View
                    style={[
                      styles.checkbox,
                      completedActions[action.id] && styles.checkboxChecked,
                    ]}
                  >
                    {completedActions[action.id] && (
                      <Text style={styles.checkmark}>✓</Text>
                    )}
                  </View>
                  <View style={{ flex: 1 }}>
                    <Text
                      style={[
                        styles.actionTitle,
                        completedActions[action.id] && styles.actionTitleCompleted,
                      ]}
                    >
                      {action.task}
                    </Text>
                    <View style={styles.actionMeta}>
                      <Text style={styles.actionSermon}>{action.sermon}</Text>
                      <Badge
                        label={
                          action.priority === 'high' ? 'PRIORITY' : 'STANDARD'
                        }
                        variant={
                          action.priority === 'high' ? 'success' : 'default'
                        }
                      />
                    </View>
                  </View>
                </TouchableOpacity>
              </Card>
            ))}
        </View>

        {/* Upcoming Tasks */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Upcoming</Text>
          {actions
            .filter((a) => a.dueDate !== 'Today')
            .map((action) => (
              <Card
                key={action.id}
                style={[
                  styles.actionCard,
                  completedActions[action.id] && styles.actionCardCompleted,
                ]}
              >
                <TouchableOpacity
                  style={styles.actionRow}
                  onPress={() => toggleAction(action.id)}
                >
                  <View
                    style={[
                      styles.checkbox,
                      completedActions[action.id] && styles.checkboxChecked,
                    ]}
                  >
                    {completedActions[action.id] && (
                      <Text style={styles.checkmark}>✓</Text>
                    )}
                  </View>
                  <View style={{ flex: 1 }}>
                    <Text
                      style={[
                        styles.actionTitle,
                        completedActions[action.id] && styles.actionTitleCompleted,
                      ]}
                    >
                      {action.task}
                    </Text>
                    <View style={styles.actionMeta}>
                      <Text style={styles.actionDate}>{action.dueDate}</Text>
                      <Text style={styles.actionSermon}>{action.sermon}</Text>
                    </View>
                  </View>
                </TouchableOpacity>
              </Card>
            ))}
        </View>

        {/* Habit Tracking */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Daily Habits</Text>
          <Card style={styles.habitCard}>
            <View style={styles.habitHeader}>
              <Text style={styles.habitTitle}>Scripture Reading</Text>
              <Text style={styles.habitDays}>Mon Tue Wed Thu Fri</Text>
            </View>
            <View style={styles.habitProgress}>
              {[...Array(7)].map((_, idx) => (
                <View
                  key={idx}
                  style={[
                    styles.habitDay,
                    idx < 5 && styles.habitDayComplete,
                  ]}
                />
              ))}
            </View>
          </Card>
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
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.md,
    backgroundColor: colors.surface,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  title: {
    ...typography.h2,
    color: colors.text,
  },
  content: {
    flex: 1,
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  streakCard: {
    backgroundColor: '#FFF9F0',
    marginBottom: spacing.xl,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  streakContent: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    gap: spacing.lg,
  },
  streakNumber: {
    ...typography.h2,
    color: colors.secondary,
    fontWeight: '700',
  },
  streakLabel: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  streakFire: {
    fontSize: 32,
  },
  streakMessage: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.md,
  },
  section: {
    marginBottom: spacing.xl,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.md,
  },
  goalCard: {
    backgroundColor: '#F9F6F3',
  },
  goalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: spacing.md,
  },
  goalTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  goalMeta: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  goalPercent: {
    ...typography.h3,
    color: colors.secondary,
    fontWeight: '700',
  },
  actionCard: {
    marginBottom: spacing.md,
    backgroundColor: colors.surface,
  },
  actionCardCompleted: {
    backgroundColor: '#F0FDF4',
  },
  actionRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: spacing.md,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 6,
    borderWidth: 2,
    borderColor: colors.secondary,
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: spacing.xs,
  },
  checkboxChecked: {
    backgroundColor: colors.success,
    borderColor: colors.success,
  },
  checkmark: {
    color: colors.surface,
    fontWeight: '700',
  },
  actionTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  actionTitleCompleted: {
    color: colors.textLight,
    textDecorationLine: 'line-through',
  },
  actionMeta: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.sm,
    marginTop: spacing.xs,
    flexWrap: 'wrap',
  },
  actionDate: {
    ...typography.caption,
    color: colors.textLight,
  },
  actionSermon: {
    ...typography.caption,
    color: colors.secondary,
    fontWeight: '600',
  },
  habitCard: {
    backgroundColor: '#F9F6F3',
  },
  habitHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.md,
  },
  habitTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  habitDays: {
    ...typography.caption,
    color: colors.textLight,
  },
  habitProgress: {
    flexDirection: 'row',
    gap: spacing.md,
  },
  habitDay: {
    flex: 1,
    height: 40,
    borderRadius: borderRadius.md,
    backgroundColor: colors.border,
  },
  habitDayComplete: {
    backgroundColor: colors.success,
  },
});

export default ActionsScreen;
