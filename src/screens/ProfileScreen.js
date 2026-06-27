import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Switch,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Badge } from '../components/ui';

const ProfileScreen = ({ navigation }) => {
  const [darkMode, setDarkMode] = useState(false);
  const [notifications, setNotifications] = useState(true);

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Profile</Text>
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Profile Card */}
        <Card style={styles.profileCard}>
          <View style={styles.profileHeader}>
            <View style={styles.avatar}>
              <Text style={styles.avatarText}>S</Text>
            </View>
            <View style={{ flex: 1 }}>
              <Text style={styles.profileName}>Sarah Johnson</Text>
              <Text style={styles.profileEmail}>sarah@example.com</Text>
              <Badge label="MEMBER SINCE 2024" variant="accent" />
            </View>
          </View>
        </Card>

        {/* Faith Journey Stats */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Faith Journey</Text>
          <View style={styles.statsGrid}>
            <Card style={styles.statItem}>
              <Text style={styles.statValue}>52</Text>
              <Text style={styles.statName}>Sermons</Text>
            </Card>
            <Card style={styles.statItem}>
              <Text style={styles.statValue}>156</Text>
              <Text style={styles.statName}>Notes</Text>
            </Card>
            <Card style={styles.statItem}>
              <Text style={styles.statValue}>89</Text>
              <Text style={styles.statName}>Actions</Text>
            </Card>
          </View>
        </View>

        {/* Achievement Badges */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Achievements</Text>
          <View style={styles.badgesContainer}>
            {[
              { icon: '🔥', label: 'Week Warrior' },
              { icon: '📖', label: 'Scripture Master' },
              { icon: '✍️', label: 'Journal Keeper' },
              { icon: '🎯', label: 'Action Taker' },
            ].map((badge, idx) => (
              <View key={idx} style={styles.badgeBox}>
                <Text style={styles.badgeIcon}>{badge.icon}</Text>
                <Text style={styles.badgeLabel}>{badge.label}</Text>
              </View>
            ))}
          </View>
        </View>

        {/* Preferences */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Preferences</Text>

          {/* Theme */}
          <Card style={styles.settingCard}>
            <View style={styles.settingRow}>
              <View>
                <Text style={styles.settingLabel}>Dark Mode</Text>
                <Text style={styles.settingDesc}>Easier on the eyes</Text>
              </View>
              <Switch
                value={darkMode}
                onValueChange={setDarkMode}
                trackColor={{ false: colors.border, true: colors.secondary }}
                thumbColor={darkMode ? colors.primary : colors.textLight}
              />
            </View>
          </Card>

          {/* Notifications */}
          <Card style={styles.settingCard}>
            <View style={styles.settingRow}>
              <View>
                <Text style={styles.settingLabel}>Notifications</Text>
                <Text style={styles.settingDesc}>Daily reminders & updates</Text>
              </View>
              <Switch
                value={notifications}
                onValueChange={setNotifications}
                trackColor={{ false: colors.border, true: colors.secondary }}
                thumbColor={
                  notifications ? colors.primary : colors.textLight
                }
              />
            </View>
          </Card>

          {/* Reminder Time */}
          <TouchableOpacity>
            <Card style={styles.settingCard}>
              <View style={styles.settingRow}>
                <View>
                  <Text style={styles.settingLabel}>Reminder Time</Text>
                  <Text style={styles.settingDesc}>Morning at 7:00 AM</Text>
                </View>
                <Text style={styles.settingArrow}>›</Text>
              </View>
            </Card>
          </TouchableOpacity>
        </View>

        {/* Account */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Account</Text>

          {[
            { icon: '🔐', label: 'Change Password', arrow: true },
            { icon: '📋', label: 'Privacy Policy', arrow: true },
            { icon: '⚖️', label: 'Terms of Service', arrow: true },
            { icon: '💬', label: 'Contact Support', arrow: true },
          ].map((item, idx) => (
            <TouchableOpacity key={idx}>
              <Card style={styles.accountItem}>
                <View style={styles.accountRow}>
                  <Text style={styles.accountIcon}>{item.icon}</Text>
                  <Text style={styles.accountLabel}>{item.label}</Text>
                  {item.arrow && (
                    <Text style={styles.accountArrow}>›</Text>
                  )}
                </View>
              </Card>
            </TouchableOpacity>
          ))}
        </View>

        {/* About */}
        <View style={styles.section}>
          <Card style={styles.aboutCard}>
            <Text style={styles.aboutTitle}>Daily Disciple</Text>
            <Text style={styles.aboutVersion}>Version 1.0.0</Text>
            <Text style={styles.aboutText}>
              Transform your faith through daily reflections and spiritual growth
              tracking.
            </Text>
          </Card>
        </View>

        {/* Logout */}
        <TouchableOpacity style={styles.logoutButton}>
          <Text style={styles.logoutText}>Log Out</Text>
        </TouchableOpacity>

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
  profileCard: {
    marginBottom: spacing.xl,
    backgroundColor: 'linear-gradient(135deg, #FFF9F0 0%, #F9F6F3 100%)',
  },
  profileHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.lg,
  },
  avatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    ...shadows.md,
  },
  avatarText: {
    ...typography.h2,
    color: colors.primary,
    fontWeight: '700',
  },
  profileName: {
    ...typography.h3,
    color: colors.text,
  },
  profileEmail: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
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
    gap: spacing.md,
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: spacing.lg,
  },
  statValue: {
    ...typography.h2,
    color: colors.secondary,
    fontWeight: '700',
  },
  statName: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  badgesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.md,
  },
  badgeBox: {
    width: '48%',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    paddingVertical: spacing.lg,
    alignItems: 'center',
    ...shadows.sm,
  },
  badgeIcon: {
    fontSize: 32,
    marginBottom: spacing.sm,
  },
  badgeLabel: {
    ...typography.caption,
    color: colors.text,
    fontWeight: '600',
    textAlign: 'center',
  },
  settingCard: {
    marginBottom: spacing.md,
    paddingVertical: spacing.md,
  },
  settingRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  settingLabel: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  settingDesc: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  settingArrow: {
    ...typography.h3,
    color: colors.secondary,
  },
  accountItem: {
    marginBottom: spacing.md,
  },
  accountRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.md,
  },
  accountIcon: {
    fontSize: 20,
  },
  accountLabel: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
    flex: 1,
  },
  accountArrow: {
    ...typography.h3,
    color: colors.secondary,
  },
  aboutCard: {
    backgroundColor: '#F9F6F3',
    alignItems: 'center',
    marginBottom: spacing.lg,
  },
  aboutTitle: {
    ...typography.h3,
    color: colors.text,
    fontWeight: '700',
  },
  aboutVersion: {
    ...typography.caption,
    color: colors.secondary,
    marginTop: spacing.xs,
  },
  aboutText: {
    ...typography.bodySmall,
    color: colors.textLight,
    textAlign: 'center',
    marginTop: spacing.md,
    lineHeight: 20,
  },
  logoutButton: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    paddingVertical: spacing.lg,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: colors.border,
    marginBottom: spacing.xl,
  },
  logoutText: {
    ...typography.body,
    color: colors.text,
    fontWeight: '700',
  },
});

export default ProfileScreen;
