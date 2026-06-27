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

const SermonNotesScreen = ({ navigation }) => {
  const [activeTab, setActiveTab] = useState('notes');
  const [notes, setNotes] = useState('');

  const tabs = ['notes', 'scripture', 'points', 'quotes'];
  const tabLabels = {
    notes: 'Notes',
    scripture: 'Scripture',
    points: 'Key Points',
    quotes: 'Quotes',
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity onPress={() => navigation.goBack()}>
          <Text style={styles.backButton}>←</Text>
        </TouchableOpacity>
        <View>
          <Text style={styles.title}>Sermon Notes</Text>
          <Text style={styles.meta}>Building Faith in Uncertain Times</Text>
        </View>
        <TouchableOpacity>
          <Text style={styles.moreButton}>⋯</Text>
        </TouchableOpacity>
      </View>

      {/* Tab Navigation */}
      <View style={styles.tabs}>
        {tabs.map((tab) => (
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
              {tabLabels[tab]}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Content */}
      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {activeTab === 'notes' && (
          <View style={styles.section}>
            <View style={styles.sermonMeta}>
              <Badge label="Pastor John Smith" />
              <Text style={styles.metaText}>Sunday, June 23, 2026</Text>
            </View>

            <TextInput
              style={styles.notesInput}
              placeholder="Add your notes here..."
              placeholderTextColor={colors.textLight}
              multiline
              value={notes}
              onChangeText={setNotes}
            />

            <View style={styles.toolsSection}>
              <Text style={styles.toolsTitle}>Quick Tools</Text>
              <View style={styles.toolsGrid}>
                {['🎤 Voice Note', '📷 Photo', '🏷️ Tag', '📂 Category'].map(
                  (tool, idx) => (
                    <TouchableOpacity key={idx} style={styles.toolButton}>
                      <Text style={styles.toolText}>{tool}</Text>
                    </TouchableOpacity>
                  )
                )}
              </View>
            </View>
          </View>
        )}

        {activeTab === 'scripture' && (
          <View style={styles.section}>
            <Text style={styles.subsectionTitle}>Add Scripture References</Text>
            {[
              { ref: 'Jeremiah 29:11', text: 'For I know the plans I have for you' },
              { ref: 'Psalm 23:1', text: 'The Lord is my shepherd' },
            ].map((item, idx) => (
              <Card key={idx} style={styles.scriptureItem}>
                <Text style={styles.scriptureRef}>{item.ref}</Text>
                <Text style={styles.scriptureText}>"{item.text}"</Text>
              </Card>
            ))}
            <Button label="+ Add Scripture" variant="secondary" size="sm" />
          </View>
        )}

        {activeTab === 'points' && (
          <View style={styles.section}>
            <Text style={styles.subsectionTitle}>Main Takeaways</Text>
            {[
              'Faith is a process, not a destination',
              'Trust is built through trials',
              'God is present in our uncertainties',
            ].map((point, idx) => (
              <Card key={idx} style={styles.pointCard}>
                <View style={styles.pointRow}>
                  <View style={styles.pointNumber}>{idx + 1}</View>
                  <Text style={styles.pointText}>{point}</Text>
                </View>
              </Card>
            ))}
            <Button label="+ Add Key Point" variant="secondary" size="sm" />
          </View>
        )}

        {activeTab === 'quotes' && (
          <View style={styles.section}>
            <Text style={styles.subsectionTitle}>Memorable Quotes</Text>
            {[
              '"Faith is not about having all the answers, its about trusting the One who does."',
              '"Growth happens at the edge of our comfort zone."',
            ].map((quote, idx) => (
              <Card key={idx} style={styles.quoteCard}>
                <Text style={styles.quoteText}>{quote}</Text>
              </Card>
            ))}
            <Button label="+ Add Quote" variant="secondary" size="sm" />
          </View>
        )}

        <View style={{ height: spacing.xl }} />
      </ScrollView>

      {/* Footer Actions */}
      <View style={styles.footer}>
        <Button label="Save & Reflect" variant="primary" />
      </View>
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
  moreButton: {
    fontSize: 24,
    color: colors.textLight,
    marginLeft: spacing.md,
  },
  title: {
    ...typography.h3,
    color: colors.text,
  },
  meta: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.xs,
  },
  tabs: {
    flexDirection: 'row',
    backgroundColor: colors.surface,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
    paddingHorizontal: spacing.lg,
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
  section: {
    marginBottom: spacing.lg,
  },
  sermonMeta: {
    marginBottom: spacing.lg,
  },
  metaText: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.sm,
  },
  notesInput: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.lg,
    height: 200,
    textAlignVertical: 'top',
    ...typography.body,
    color: colors.text,
    marginBottom: spacing.lg,
    ...shadows.sm,
  },
  toolsSection: {
    marginBottom: spacing.lg,
  },
  toolsTitle: {
    ...typography.bodySmall,
    color: colors.text,
    fontWeight: '600',
    marginBottom: spacing.md,
  },
  toolsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.md,
  },
  toolButton: {
    flex: 1,
    minWidth: '45%',
    backgroundColor: colors.surface,
    borderRadius: borderRadius.md,
    paddingVertical: spacing.md,
    alignItems: 'center',
    ...shadows.sm,
  },
  toolText: {
    ...typography.bodySmall,
    color: colors.primary,
    fontWeight: '600',
  },
  subsectionTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.lg,
  },
  scriptureItem: {
    marginBottom: spacing.md,
    backgroundColor: '#FFF9F0',
  },
  scriptureRef: {
    ...typography.caption,
    color: colors.secondary,
    fontWeight: '700',
  },
  scriptureText: {
    ...typography.bodySmall,
    color: colors.text,
    marginTop: spacing.xs,
    fontStyle: 'italic',
  },
  pointCard: {
    marginBottom: spacing.md,
  },
  pointRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: spacing.md,
  },
  pointNumber: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    ...typography.bodySmall,
    fontWeight: '700',
    color: colors.primary,
  },
  pointText: {
    ...typography.body,
    color: colors.text,
    flex: 1,
  },
  quoteCard: {
    marginBottom: spacing.md,
    backgroundColor: '#F3F0ED',
    borderLeftWidth: 4,
    borderLeftColor: colors.secondary,
  },
  quoteText: {
    ...typography.body,
    color: colors.text,
    fontStyle: 'italic',
  },
  footer: {
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.lg,
    backgroundColor: colors.surface,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
});

export default SermonNotesScreen;
