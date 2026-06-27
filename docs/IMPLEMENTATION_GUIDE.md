# Daily Disciple - Implementation Guide

## Project Structure

```
daily_disciple/
├── src/
│   ├── theme.js                 # Design system (colors, spacing, typography)
│   ├── components/
│   │   └── ui.js               # Reusable UI components
│   ├── screens/
│   │   ├── OnboardingScreen.js
│   │   ├── HomeScreen.js
│   │   ├── SermonNotesScreen.js
│   │   ├── ReflectionScreen.js
│   │   ├── ActionsScreen.js
│   │   ├── JournalScreen.js
│   │   ├── GrowthScreen.js
│   │   └── ProfileScreen.js
│   └── navigation/
│       └── Navigation.js        # Tab and stack navigation setup
├── App.js                       # App entry point
├── app.json                     # Expo configuration
├── package.json
└── DESIGN_SYSTEM.md

```

## Setup Instructions

### 1. Install Dependencies
```bash
npm install
# or
yarn install
```

### 2. Run the App

**For Expo (Development)**
```bash
npm start
# Then press 'a' for Android or 'i' for iOS
```

**For iOS (Native)**
```bash
npm run ios
```

**For Android (Native)**
```bash
npm run android
```

### 3. Build for Production

**iOS Build**
```bash
eas build --platform ios
```

**Android Build**
```bash
eas build --platform android
```

## Core Screens Overview

### 1. Onboarding Screen
- Swipeable cards with 4 steps: Take Notes, Reflect, Apply, Grow
- Dot indicators for progress
- "Get Started" button to enter main app

**Key Features:**
- Smooth horizontal scrolling
- Animated dot indicators
- Inspiring illustrations (emoji-based)

### 2. Home Dashboard
- Personalized greeting based on time of day
- Today's Scripture card
- Daily Reflection prompt
- Recent sermon notes with progress
- Spiritual growth statistics (sermons, actions, streak)
- Upcoming action steps

**Key Features:**
- Dynamic greeting
- Scripture rotation capability
- Quick access to all major features
- Progress visualization

### 3. Sermon Note Taking
- Tabbed interface: Notes, Scripture, Key Points, Quotes
- Rich text editor for notes
- Voice note button placeholder
- Scripture reference management
- Key points list
- Memorable quotes section
- "Save & Reflect" button

**Key Features:**
- Multi-section organization
- Quick tool buttons
- Save with AI reflection flow

### 4. AI Reflection Screen
- AI-generated sermon summary
- Main lessons learned (numbered)
- Reflection questions with answer areas
- Practical life applications
- Prayer suggestion
- Action plan generation button
- Success feedback

**Key Features:**
- Structured reflection prompts
- AI-generated insights
- Actionable recommendations

### 5. Action Steps Screen
- Streak counter (7 days)
- Weekly goals progress
- Today's tasks (checkbox-based)
- Upcoming tasks
- Daily habits tracking (7-day visual)
- Completion tracking

**Key Features:**
- Interactive checkboxes
- Visual streak motivation
- Habit tracking calendar
- Priority indicators

### 6. Journal Screen
- Add new entry button
- Search functionality
- Filtering by type: All, Reflection, Gratitude, Prayer
- Entry card preview with date, type, excerpt
- Type indicators (color-coded)

**Key Features:**
- Multiple journal types
- Search and filter
- Beautiful entry cards
- Date-based organization

### 7. Growth Dashboard
- Quick stats cards (sermons, actions, streak, prayers)
- Weekly consistency chart (bar graph)
- Spiritual growth insights
- Recently completed actions
- Milestone tracking
- Prayer activity statistics

**Key Features:**
- Visual progress tracking
- Weekly consistency chart
- Achievement milestones
- Prayer statistics

### 8. Profile Screen
- User profile card with avatar and stats
- Faith journey statistics
- Achievement badges (4 types)
- Settings with toggles (Dark Mode, Notifications)
- Reminder time setting
- Account management links
- Privacy and terms information
- Log out button

**Key Features:**
- User customization
- Settings management
- Achievement display

## Key Components

### UI Components (`src/components/ui.js`)

1. **Card** - Reusable container with shadow and rounded corners
2. **Button** - Primary/Secondary variants, multiple sizes
3. **Badge** - Label badges for tags and status
4. **ProgressBar** - Visual progress indicator
5. **ScriptureCard** - Special card for scripture verses

### Navigation Structure

- **Stack Navigator**: Handles flow between onboarding and main app
- **Bottom Tab Navigator**: 5 main tabs (Home, Notes, Actions, Journal, Profile)
- **Modal Screens**: Reflection and Growth screens accessible from other screens

## Design Tokens Usage

### Colors
```javascript
import { colors } from './src/theme';
colors.primary      // Deep Navy
colors.secondary    // Gold
colors.accent       // Warm Neutral
colors.success      // Green
colors.border       // Light Gray
```

### Spacing
```javascript
import { spacing } from './src/theme';
spacing.xs  // 8px
spacing.sm  // 12px
spacing.md  // 16px
spacing.lg  // 24px
spacing.xl  // 32px
```

### Typography
```javascript
import { typography } from './src/theme';
typography.h1       // 32px, 700 weight
typography.body     // 16px, 400 weight
typography.caption  // 12px, 500 weight
```

### Shadows
```javascript
import { shadows } from './src/theme';
shadows.sm  // Light shadow
shadows.md  // Medium shadow
shadows.lg  // Heavy shadow
```

## State Management (Future Enhancement)

For production, consider integrating:
- **Redux** or **Zustand** for global state
- **AsyncStorage** for local persistence
- **Firebase** for backend sync

## Backend Integration Points

1. **Sermon Notes** - Save/retrieve from API
2. **AI Reflection** - Call AI service for summaries
3. **User Data** - Sync across devices
4. **Prayer Tracking** - Store and analyze patterns
5. **Authentication** - User login/registration

## Performance Optimization

1. **Lazy Loading** - Load screens on demand
2. **Image Optimization** - Compress assets
3. **Animation Performance** - Use `shouldRasterizeIOS` when needed
4. **Memory** - Clean up listeners and subscriptions

## Testing

### Unit Tests
```bash
npm test
```

### E2E Testing
- Use Detox for native app testing

## Deployment

### iOS App Store
1. Build with `eas build --platform ios`
2. Configure provisioning profiles
3. Submit via App Store Connect

### Google Play Store
1. Build with `eas build --platform android`
2. Create signing key
3. Submit via Google Play Console

## Maintenance

- Update React Native and dependencies regularly
- Monitor performance metrics
- Gather user feedback for UX improvements
- A/B test new features
- Monitor crash reports

## Support & Resources

- [React Native Documentation](https://reactnative.dev)
- [Expo Documentation](https://docs.expo.dev)
- [React Navigation](https://reactnavigation.org)
