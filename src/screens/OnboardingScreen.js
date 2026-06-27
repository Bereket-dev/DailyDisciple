import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  Animated,
  Dimensions,
} from 'react-native';
import { colors, spacing, typography, borderRadius, shadows } from '../theme';
import { Button } from './ui';

const { width } = Dimensions.get('window');

const OnboardingScreen = ({ navigation }) => {
  const [activeSlide, setActiveSlide] = useState(0);
  const scrollViewRef = React.useRef(null);

  const slides = [
    {
      icon: '📖',
      title: 'Take Notes',
      description: 'Capture sermon insights with our rich note editor',
    },
    {
      icon: '💭',
      title: 'Reflect',
      description: 'Understand lessons with AI-powered reflections',
    },
    {
      icon: '⚡',
      title: 'Apply',
      description: 'Create actionable steps for your spiritual journey',
    },
    {
      icon: '📈',
      title: 'Grow',
      description: 'Track your progress and celebrate your faith growth',
    },
  ];

  const handleScroll = (e) => {
    const slide = Math.round(e.nativeEvent.contentOffset.x / width);
    setActiveSlide(slide);
  };

  return (
    <View style={styles.container}>
      <ScrollView
        ref={scrollViewRef}
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        onScroll={handleScroll}
        scrollEventThrottle={32}
      >
        {slides.map((slide, idx) => (
          <View key={idx} style={styles.slide}>
            <View style={styles.illustration}>
              <Text style={styles.icon}>{slide.icon}</Text>
            </View>
            <Text style={styles.title}>{slide.title}</Text>
            <Text style={styles.description}>{slide.description}</Text>
          </View>
        ))}
      </ScrollView>

      <View style={styles.bottomSection}>
        <View style={styles.dots}>
          {slides.map((_, idx) => (
            <View
              key={idx}
              style={[
                styles.dot,
                idx === activeSlide && styles.dotActive,
              ]}
            />
          ))}
        </View>

        <Button
          label={activeSlide === slides.length - 1 ? 'Get Started' : 'Next'}
          variant="primary"
          onPress={() => {
            if (activeSlide === slides.length - 1) {
              navigation.replace('MainApp');
            } else {
              scrollViewRef.current?.scrollTo({
                x: (activeSlide + 1) * width,
                animated: true,
              });
            }
          }}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  slide: {
    width,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: spacing.lg,
  },
  illustration: {
    width: 120,
    height: 120,
    borderRadius: 60,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.xl,
    ...shadows.lg,
  },
  icon: {
    fontSize: 56,
  },
  title: {
    ...typography.h2,
    color: colors.text,
    marginBottom: spacing.md,
    textAlign: 'center',
  },
  description: {
    ...typography.body,
    color: colors.textLight,
    textAlign: 'center',
    lineHeight: 24,
  },
  bottomSection: {
    paddingHorizontal: spacing.lg,
    paddingBottom: spacing.xl,
    paddingTop: spacing.md,
  },
  dots: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: spacing.lg,
  },
  dot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: colors.border,
    marginHorizontal: spacing.sm,
  },
  dotActive: {
    backgroundColor: colors.secondary,
    width: 24,
  },
});

export default OnboardingScreen;
