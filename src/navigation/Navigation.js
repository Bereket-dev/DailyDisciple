import React from 'react';
import { Text } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { colors } from '../theme';

import OnboardingScreen from '../screens/OnboardingScreen';
import HomeScreen from '../screens/HomeScreen';
import SermonNotesScreen from '../screens/SermonNotesScreen';
import ReflectionScreen from '../screens/ReflectionScreen';
import ActionsScreen from '../screens/ActionsScreen';
import JournalScreen from '../screens/JournalScreen';
import GrowthScreen from '../screens/GrowthScreen';
import ProfileScreen from '../screens/ProfileScreen';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

const screenOptions = {
  headerShown: false,
  cardStyle: { backgroundColor: colors.background },
};

const tabBarOptions = {
  activeTintColor: colors.primary,
  inactiveTintColor: colors.textLight,
  labelStyle: { fontSize: 12, fontWeight: '600', marginTop: 2 },
  style: {
    backgroundColor: colors.surface,
    borderTopColor: colors.border,
    borderTopWidth: 1,
    paddingBottom: 4,
    paddingTop: 4,
    height: 64,
  },
};

const MainTabs = () => (
  <Tab.Navigator screenOptions={tabBarOptions}>
    <Tab.Screen
      name="Home"
      component={HomeScreen}
      options={{
        tabBarLabel: 'Home',
        tabBarIcon: ({ color }) => <Text style={{ color, fontSize: 20 }}>🏠</Text>,
      }}
    />
    <Tab.Screen
      name="SermonNotes"
      component={SermonNotesScreen}
      options={{
        tabBarLabel: 'Notes',
        tabBarIcon: ({ color }) => <Text style={{ color, fontSize: 20 }}>📝</Text>,
      }}
    />
    <Tab.Screen
      name="Actions"
      component={ActionsScreen}
      options={{
        tabBarLabel: 'Actions',
        tabBarIcon: ({ color }) => <Text style={{ color, fontSize: 20 }}>⚡</Text>,
      }}
    />
    <Tab.Screen
      name="Journal"
      component={JournalScreen}
      options={{
        tabBarLabel: 'Journal',
        tabBarIcon: ({ color }) => <Text style={{ color, fontSize: 20 }}>📔</Text>,
      }}
    />
    <Tab.Screen
      name="Profile"
      component={ProfileScreen}
      options={{
        tabBarLabel: 'Profile',
        tabBarIcon: ({ color }) => <Text style={{ color, fontSize: 20 }}>👤</Text>,
      }}
    />
  </Tab.Navigator>
);

export const Navigation = () => (
  <NavigationContainer>
    <Stack.Navigator screenOptions={screenOptions}>
      <Stack.Screen name="Onboarding" component={OnboardingScreen} />
      <Stack.Screen name="MainApp" component={MainTabs} />
      <Stack.Screen name="Reflection" component={ReflectionScreen} />
      <Stack.Screen name="Growth" component={GrowthScreen} />
    </Stack.Navigator>
  </NavigationContainer>
);
