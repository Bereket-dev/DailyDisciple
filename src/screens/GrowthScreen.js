import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Badge, ProgressBar } from '../components/ui';

const GrowthScreen = ({ navigation }) => {
  const stats = [
    { label: 'Sermons', value: '12', color: colors.secondary },
    { label: 'Actions', value: '28', color: colors.success },
    { label: 'Streak', value: '7', color: colors.accent },
    { label: 'Prayers', value: '34', color: colors.primary },
  ];

  const weeklyData = [
    { day: 'Mon', completed: 4, total: 5 },
    { day: 'Tue', completed: 5, total: 5 },
    { day: 'Wed', completed: 3, total: 5 },
    { day: 'Thu', completed: 5, total: 5 },
    { day: 'Fri', completed: 4, total: 5 },
    { day: 'Sat', completed: 2, total: 5 },
    { day: 'Sun', completed: 4, total: 5 },
  ];

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Growth Dashboard</Text>
        <Badge label="THIS WEEK" />
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Overview Stats */}
        <View style={styles.section}>
          <View style={styles.statsGrid}>
            {stats.map((stat, idx) => (
              <Card key={idx} style={styles.statCard}>
                <Text style={[styles.statValue, { color: stat.color }]}>
                  {stat.value}
                </Text>
                <Text style={styles.statLabel}>{stat.label}</Text>
              </Card>
            ))}
          </View>
        </View>

        {/* Weekly Consistency */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Weekly Consistency</Text>
          <Card style={styles.consistencyCard}>
            <View style={styles.weekChart}>
              {weeklyData.map((day, idx) => (
                <View key={idx} style={styles.dayColumn}>
                  <View style={styles.barContainer}>
                    <View
                      style={[
                        styles.bar,
                        {
                          height: `${(day.completed / day.total) * 100}%`,
                          backgroundColor:
                            day.completed === day.total
                              ? colors.success
                              : colors.secondary,
                        },
                      ]}
                    />
                  </View>
                  <Text style={styles.dayLabel}>{day.day}</Text>
                </View>
              ))}
            </View>
          </Card>
        </View>

        {/* Spiritual Growth Insights */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Spiritual Growth Insights</Text>
          {[
            {
              title: 'Consistency Improvement',
              value: '↑ 23%',
              desc: 'up from last week',
              color: colors.success,
            },
            {
              title: 'Most Active Day',
              value: 'Sunday',
              desc: 'Average 5 actions',
              color: colors.secondary,
            },
            {
              title: 'Action Completion',
              value: '87%',
              desc: 'of assigned actions',
              color: colors.accent,
            },
          ].map((insight, idx) => (
            <Card key={idx} style={styles.insightCard}>
              <View style={styles.insightHeader}>
                <View>
                  <Text style={styles.insightTitle}>{insight.title}</Text>
                  <Text style={styles.insightDesc}>{insight.desc}</Text>
                </View>
                <Text style={[styles.insightValue, { color: insight.color }]}>
                  {insight.value}
                </Text>
              </View>
            </Card>
          ))}
        </View>

        {/* Completed Actions */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Recently Completed</Text>
          {[
            { action: 'Read Psalm 23', date: 'Yesterday' },
            { action: 'Evening Prayer', date: '2 days ago' },
            { action: 'Bible Study', date: '3 days ago' },
          ].map((item, idx) => (
            <Card key={idx} style={styles.completedCard}>
              <View style={styles.completedRow}>
                <Text style={styles.checkmark}>✓</Text>
                <View style={{ flex: 1 }}>
                  <Text style={styles.completedAction}>{item.action}</Text>
                  <Text style={styles.completedDate}>{item.date}</Text>
                </View>
                <TouchableOpacity>
                  <Text style={styles.moreIcon}>›</Text>
                </TouchableOpacity>
              </View>
            </Card>
          ))}
        </View>

        {/* Growth Milestones */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Milestones</Text>
          {[
            {
              title: '7 Day Streak',
              status: 'achieved',
              date: 'Last week',
            },
            {
              title: '10 Sermons Completed',
              status: 'in progress',
              date: '10 of 10',
            },
            {
              title: '50 Actions Completed',
              status: 'in progress',
              date: '28 of 50',
            },
          ].map((milestone, idx) => (
            <Card
              key={idx}
              style={[
                styles.milestoneCard,
                milestone.status === 'achieved' && styles.milestoneAchieved,
              ]}
            >
              <View style={styles.milestoneContent}>
                <View>
                  <Text style={styles.milestoneTitle}>{milestone.title}</Text>
                  <Text style={styles.milestoneDate}>{milestone.date}</Text>
                </View>
                {milestone.status === 'achieved' && (
                  <Badge label="✓ ACHIEVED" variant="success" />
                )}
              </View>
              {milestone.status === 'in progress' && (
                <ProgressBar
                  progress={
                    milestone.title === '10 Sermons Completed' ? 1 : 0.56
                  }
                  height={8}
                />
              )}
            </Card>
          ))}
        </View>

        {/* Prayer Activity */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Prayer Activity</Text>
          <Card style={styles.prayerCard}>
            <View style={styles.prayerRow}>
              <View>
                <Text style={styles.prayerCount}>34</Text>
                <Text style={styles.prayerLabel}>Prayers This Month</Text>
              </View>
              <View style={styles.prayerRight}>
                <Text style={styles.prayerAverage}>4.9</Text>
                <Text style={styles.prayerAverageLabel}>per week</Text>
              </View>
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
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
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
  section: {
    marginBottom: spacing.xl,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.md,
  },
  statsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.md,
  },
  statCard: {
    flex: 1,
    minWidth: '45%',
    alignItems: 'center',
    paddingVertical: spacing.lg,
  },
  statValue: {
    ...typography.h2,
    fontWeight: '700',
    marginBottom: spacing.xs,
  },
  statLabel: {
    ...typography.caption,
    color: colors.textLight,
  },
  consistencyCard: {
    backgroundColor: '#F9F6F3',
    paddingVertical: spacing.lg,
  },
  weekChart: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    justifyContent: 'space-around',
    height: 120,
  },
  dayColumn: {
    alignItems: 'center',
    flex: 1,
    gap: spacing.sm,
  },
  barContainer: {
    width: 24,
    height: 100,
    backgroundColor: colors.border,
    borderRadius: borderRadius.sm,
    justifyContent: 'flex-end',
    overflow: 'hidden',
  },
  bar: {
    width: '100%',
  },
  dayLabel: {
    ...typography.caption,
    color: colors.textLight,
  },
  insightCard: {
    marginBottom: spacing.md,
  },
  insightHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
  },
  insightTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  insightDesc: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  insightValue: {
    ...typography.h3,
    fontWeight: '700',
  },
  completedCard: {
    marginBottom: spacing.md,
  },
  completedRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.md,
  },
  checkmark: {
    fontSize: 20,
    color: colors.success,
    fontWeight: '700',
  },
  completedAction: {
    ...typography.body,
    color: colors.text,
    fontWeight: '500',
  },
  completedDate: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  moreIcon: {
    ...typography.h3,
    color: colors.secondary,
  },
  milestoneCard: {
    marginBottom: spacing.md,
    backgroundColor: colors.surface,
  },
  milestoneAchieved: {
    backgroundColor: '#F0FDF4',
  },
  milestoneContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: spacing.md,
  },
  milestoneTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  milestoneDate: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  prayerCard: {
    backgroundColor: '#FFF9F0',
  },
  prayerRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  prayerCount: {
    ...typography.h2,
    color: colors.secondary,
    fontWeight: '700',
  },
  prayerLabel: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  prayerRight: {
    alignItems: 'flex-end',
  },
  prayerAverage: {
    ...typography.h3,
    color: colors.secondary,
    fontWeight: '700',
  },
  prayerAverageLabel: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
});

export default GrowthScreen;
