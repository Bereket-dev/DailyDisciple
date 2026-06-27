import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput as RNTextInput,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Card, Button, Badge } from '../components/ui';

const JournalScreen = ({ navigation }) => {
  const [activeTab, setActiveTab] = useState('all');
  const [searchText, setSearchText] = useState('');

  const entries = [
    {
      id: 1,
      type: 'reflection',
      date: 'June 26, 2026',
      title: 'My Faith Journey',
      excerpt:
        'Today I realized how much God has brought me through. Even in uncertain times, His presence is constant...',
    },
    {
      id: 2,
      type: 'gratitude',
      date: 'June 25, 2026',
      title: 'Things I\'m Grateful For',
      excerpt:
        'I'm grateful for my family, my church community, and the opportunity to grow spiritually.',
    },
    {
      id: 3,
      type: 'prayer',
      date: 'June 24, 2026',
      title: 'Prayer for Strength',
      excerpt:
        'Lord, give me strength to face the challenges ahead. Help me trust Your plan...',
    },
    {
      id: 4,
      type: 'reflection',
      date: 'June 23, 2026',
      title: 'Sunday Sermon Reflection',
      excerpt:
        'The sermon on faith has given me a new perspective on trials and growth.',
    },
  ];

  const filteredEntries = entries.filter((entry) => {
    const matchesTab = activeTab === 'all' || entry.type === activeTab;
    const matchesSearch = entry.title
      .toLowerCase()
      .includes(searchText.toLowerCase());
    return matchesTab && matchesSearch;
  });

  const getTypeColor = (type) => {
    switch (type) {
      case 'reflection':
        return colors.accent;
      case 'gratitude':
        return colors.success;
      case 'prayer':
        return colors.secondary;
      default:
        return colors.border;
    }
  };

  const getTypeLabel = (type) => {
    switch (type) {
      case 'reflection':
        return 'Reflection';
      case 'gratitude':
        return 'Gratitude';
      case 'prayer':
        return 'Prayer';
      default:
        return 'Entry';
    }
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Journal</Text>
        <TouchableOpacity style={styles.addButton}>
          <Text style={styles.addButtonText}>+</Text>
        </TouchableOpacity>
      </View>

      {/* Search Bar */}
      <View style={styles.searchContainer}>
        <RNTextInput
          style={styles.searchInput}
          placeholder="Search entries..."
          placeholderTextColor={colors.textLight}
          value={searchText}
          onChangeText={setSearchText}
        />
      </View>

      {/* Tabs */}
      <View style={styles.tabs}>
        {['all', 'reflection', 'gratitude', 'prayer'].map((tab) => (
          <TouchableOpacity
            key={tab}
            onPress={() => setActiveTab(tab)}
            style={[styles.tab, activeTab === tab && styles.tabActive]}
          >
            <Text
              style={[
                styles.tabLabel,
                activeTab === tab && styles.tabLabelActive,
              ]}
            >
              {tab === 'all' ? 'All' : getTypeLabel(tab)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Entries List */}
      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {filteredEntries.length > 0 ? (
          filteredEntries.map((entry) => (
            <Card
              key={entry.id}
              style={styles.entryCard}
              onPress={() => navigation.navigate('JournalDetail', { entry })}
            >
              <View style={styles.entryHeader}>
                <View
                  style={[
                    styles.typeIndicator,
                    { backgroundColor: getTypeColor(entry.type) },
                  ]}
                />
                <View style={{ flex: 1 }}>
                  <Text style={styles.entryTitle}>{entry.title}</Text>
                  <Text style={styles.entryDate}>{entry.date}</Text>
                </View>
                <Badge label={getTypeLabel(entry.type)} />
              </View>
              <Text style={styles.entryExcerpt} numberOfLines={2}>
                {entry.excerpt}
              </Text>
            </Card>
          ))
        ) : (
          <View style={styles.emptyState}>
            <Text style={styles.emptyIcon}>📔</Text>
            <Text style={styles.emptyTitle}>No entries yet</Text>
            <Text style={styles.emptyText}>
              Start your spiritual journey by creating your first entry.
            </Text>
          </View>
        )}

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
  addButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: colors.secondary,
    alignItems: 'center',
    justifyContent: 'center',
    ...shadows.md,
  },
  addButtonText: {
    fontSize: 24,
    color: colors.surface,
    fontWeight: '600',
  },
  searchContainer: {
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.md,
    paddingBottom: spacing.md,
    backgroundColor: colors.surface,
  },
  searchInput: {
    backgroundColor: colors.background,
    borderRadius: borderRadius.lg,
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.md,
    ...typography.body,
    color: colors.text,
  },
  tabs: {
    flexDirection: 'row',
    paddingHorizontal: spacing.lg,
    backgroundColor: colors.surface,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  tab: {
    flex: 1,
    paddingVertical: spacing.md,
    alignItems: 'center',
    borderBottomWidth: 2,
    borderBottomColor: 'transparent',
  },
  tabActive: {
    borderBottomColor: colors.secondary,
  },
  tabLabel: {
    ...typography.caption,
    color: colors.textLight,
    fontWeight: '600',
  },
  tabLabelActive: {
    color: colors.primary,
  },
  content: {
    flex: 1,
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.lg,
  },
  entryCard: {
    marginBottom: spacing.lg,
  },
  entryHeader: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: spacing.md,
    gap: spacing.md,
  },
  typeIndicator: {
    width: 4,
    height: 24,
    borderRadius: 2,
    marginTop: spacing.xs,
  },
  entryTitle: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  entryDate: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  entryExcerpt: {
    ...typography.bodySmall,
    color: colors.textLight,
    lineHeight: 20,
    marginLeft: spacing.lg + 4,
  },
  emptyState: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: spacing.xl * 2,
  },
  emptyIcon: {
    fontSize: 56,
    marginBottom: spacing.lg,
  },
  emptyTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.md,
  },
  emptyText: {
    ...typography.bodySmall,
    color: colors.textLight,
    textAlign: 'center',
  },
});

export default JournalScreen;
