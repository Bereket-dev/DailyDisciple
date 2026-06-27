import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Badge, ScriptureCard, ProgressBar } from '../components/ui';

const HomeScreen = ({ navigation }) => {
  const hour = new Date().getHours();
  const greeting =
    hour < 12 ? 'Good Morning' : hour < 18 ? 'Good Afternoon' : 'Good Evening';

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={styles.header}>
        <View>
          <Text style={styles.greeting}>{greeting}, Sarah</Text>
          <Text style={styles.subheader}>Ready to grow today?</Text>
        </View>
        <TouchableOpacity style={styles.profileButton}>
          <Text style={styles.profileInitial}>S</Text>
        </TouchableOpacity>
      </View>

      {/* Today's Scripture */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Today's Scripture</Text>
        <ScriptureCard
          text="For I know the plans I have for you, declares the Lord, plans for welfare and not for evil, to give you a future and a hope."
          reference="Jeremiah 29:11"
        />
      </View>

      {/* Daily Reflection */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Daily Reflection</Text>
        <Card style={styles.reflectionCard}>
          <View style={styles.reflectionHeader}>
            <Text style={styles.reflectionTitle}>What are you grateful for today?</Text>
            <Badge label="NEW" variant="success" />
          </View>
          <Text style={styles.reflectionPlaceholder}>
            Tap to write your gratitude...
          </Text>
        </Card>
      </View>

      {/* Recent Sermon */}
      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionTitle}>Continue Sermon Notes</Text>
          <TouchableOpacity>
            <Text style={styles.seeAll}>See All</Text>
          </TouchableOpacity>
        </View>
        <Card onPress={() => navigation.navigate('SermonNotes')}>
          <View style={styles.sermonContent}>
            <View>
              <Badge label="IN PROGRESS" />
              <Text style={styles.sermonTitle}>
                Building Faith in Uncertain Times
              </Text>
              <Text style={styles.sermonMeta}>Pastor John • 45 min ago</Text>
            </View>
            <Text style={styles.sermonProgress}>60%</Text>
          </View>
          <View style={{ marginTop: spacing.md }}>
            <ProgressBar progress={0.6} />
          </View>
        </Card>
      </Card>

      {/* Spiritual Growth */}
      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionTitle}>Spiritual Growth</Text>
        </View>
        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>12</Text>
            <Text style={styles.statLabel}>Sermons</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>28</Text>
            <Text style={styles.statLabel}>Actions Done</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>7</Text>
            <Text style={styles.statLabel}>Day Streak</Text>
          </View>
        </View>
      </View>

      {/* Upcoming Action Steps */}
      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <Text style={styles.sectionTitle}>Upcoming Action Steps</Text>
          <TouchableOpacity>
            <Text style={styles.seeAll}>View All</Text>
          </TouchableOpacity>
        </View>
        {[
          { task: 'Read: Psalm 23', date: 'Today' },
          { task: 'Pray for family', date: 'Tomorrow' },
        ].map((item, idx) => (
          <Card key={idx} style={styles.actionCard}>
            <View style={styles.actionRow}>
              <View style={styles.checkbox} />
              <View style={{ flex: 1 }}>
                <Text style={styles.actionText}>{item.task}</Text>
                <Text style={styles.actionDate}>{item.date}</Text>
              </View>
              <Text style={styles.actionIcon}>→</Text>
            </View>
          </Card>
        ))}
      </View>

      <View style={{ height: spacing.xl }} />
    </ScrollView>
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
    alignItems: 'flex-start',
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
    paddingBottom: spacing.md,
  },
  greeting: {
    ...typography.h2,
    color: colors.text,
    marginBottom: spacing.xs,
  },
  subheader: {
    ...typography.bodySmall,
    color: colors.textLight,
  },
  profileButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    ...shadows.md,
  },
  profileInitial: {
    ...typography.h3,
    color: colors.primary,
  },
  section: {
    paddingHorizontal: spacing.lg,
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
  seeAll: {
    ...typography.bodySmall,
    color: colors.secondary,
    fontWeight: '600',
  },
  reflectionCard: {
    backgroundColor: '#FFF9F5',
  },
  reflectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: spacing.md,
  },
  reflectionTitle: {
    ...typography.body,
    color: colors.text,
    flex: 1,
    fontWeight: '600',
  },
  reflectionPlaceholder: {
    ...typography.bodySmall,
    color: colors.textLight,
  },
  sermonContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
  },
  sermonTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
    marginTop: spacing.sm,
    marginBottom: spacing.xs,
  },
  sermonMeta: {
    ...typography.caption,
    color: colors.textLight,
  },
  sermonProgress: {
    ...typography.h3,
    color: colors.secondary,
    fontWeight: '700',
  },
  statsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    gap: spacing.md,
  },
  statCard: {
    flex: 1,
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    paddingVertical: spacing.lg,
    alignItems: 'center',
    ...shadows.sm,
  },
  statNumber: {
    ...typography.h2,
    color: colors.secondary,
    fontWeight: '700',
  },
  statLabel: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  actionCard: {
    paddingVertical: spacing.md,
    marginBottom: spacing.sm,
  },
  actionRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.md,
  },
  checkbox: {
    width: 20,
    height: 20,
    borderRadius: 6,
    borderWidth: 2,
    borderColor: colors.secondary,
  },
  actionText: {
    ...typography.body,
    color: colors.text,
    fontWeight: '500',
  },
  actionDate: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  actionIcon: {
    ...typography.body,
    color: colors.secondary,
  },
});

export default HomeScreen;
