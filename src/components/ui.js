import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';

export const Card = ({ children, style, onPress }) => (
  <TouchableOpacity
    disabled={!onPress}
    onPress={onPress}
    style={[styles.card, onPress && styles.touchable, style]}
  >
    {children}
  </TouchableOpacity>
);

export const Button = ({ label, onPress, variant = 'primary', size = 'md' }) => (
  <TouchableOpacity
    style={[
      styles.button,
      variant === 'primary' && styles.buttonPrimary,
      variant === 'secondary' && styles.buttonSecondary,
      size === 'sm' && styles.buttonSm,
      size === 'lg' && styles.buttonLg,
    ]}
    onPress={onPress}
  >
    <Text
      style={[
        styles.buttonText,
        variant === 'primary' && styles.buttonTextPrimary,
      ]}
    >
      {label}
    </Text>
  </TouchableOpacity>
);

export const Badge = ({ label, variant = 'default' }) => (
  <View
    style={[
      styles.badge,
      variant === 'success' && styles.badgeSuccess,
      variant === 'accent' && styles.badgeAccent,
    ]}
  >
    <Text style={styles.badgeText}>{label}</Text>
  </View>
);

export const ProgressBar = ({ progress = 0.65, height = 8 }) => (
  <View style={[styles.progressContainer, { height }]}>
    <View
      style={[
        styles.progressFill,
        { height, width: `${progress * 100}%` },
      ]}
    />
  </View>
);

export const ScriptureCard = ({ text, reference }) => (
  <Card style={styles.scriptureCard}>
    <Text style={styles.scriptureText}>"{text}"</Text>
    <Text style={styles.scriptureReference}>{reference}</Text>
  </Card>
);

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderRadius: borderRadius.lg,
    padding: spacing.lg,
    marginBottom: spacing.md,
    ...shadows.md,
  },
  touchable: {
    opacity: 0.9,
  },
  button: {
    paddingHorizontal: spacing.lg,
    paddingVertical: spacing.md,
    borderRadius: borderRadius.md,
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonPrimary: {
    backgroundColor: colors.primary,
  },
  buttonSecondary: {
    backgroundColor: colors.accent,
  },
  buttonSm: {
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
  },
  buttonLg: {
    paddingHorizontal: spacing.xl,
    paddingVertical: spacing.lg,
  },
  buttonText: {
    ...typography.bodySmall,
    fontWeight: '600',
    color: colors.surface,
  },
  buttonTextPrimary: {
    color: colors.surface,
  },
  badge: {
    backgroundColor: colors.accent,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.xs,
    borderRadius: borderRadius.sm,
    alignSelf: 'flex-start',
  },
  badgeSuccess: {
    backgroundColor: colors.success,
  },
  badgeAccent: {
    backgroundColor: colors.secondary,
  },
  badgeText: {
    ...typography.caption,
    color: colors.primary,
    fontWeight: '600',
  },
  progressContainer: {
    backgroundColor: colors.border,
    borderRadius: borderRadius.sm,
    overflow: 'hidden',
  },
  progressFill: {
    backgroundColor: colors.secondary,
    borderRadius: borderRadius.sm,
  },
  scriptureCard: {
    backgroundColor: '#FFF9F0',
    borderLeftWidth: 4,
    borderLeftColor: colors.secondary,
  },
  scriptureText: {
    ...typography.body,
    color: colors.text,
    marginBottom: spacing.sm,
    fontStyle: 'italic',
  },
  scriptureReference: {
    ...typography.caption,
    color: colors.textLight,
    fontWeight: '600',
  },
});
