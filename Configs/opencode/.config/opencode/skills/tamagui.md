---
description: Tamagui UI component props quick-reference for React Native + Expo. Activate when working on Tamagui UI components, layouts, or styling in mobile/** files.
---

# Tamagui Props Reference

Quick-reference for Tamagui v1.126.18 (Sulong Kalinga mobile app).

> **Rule**: Always use Tamagui components over raw React Native equivalents.
> - `XStack` / `YStack` / `ZStack` instead of `View`
> - `Text` from Tamagui instead of RN `Text`
> - `Button`, `Input`, `Card`, `Sheet`, `Dialog` from Tamagui
> - **Always** `defaultTheme="light"` — no dark mode support in this project

---

## 1. Non-Style Props

- `animation` (string)
- `animateOnly` (string[])
- `theme`, `themeInverse`, `themeShallow` (theme control)
- `forceStyle` (`'hover' | 'press' | 'focus' | 'focusVisible'`)
- `hitSlop` (number | Insets)
- `group` (boolean | string)
- `componentName` (string)
- **Web-only**: `className`, `disableClassName`, `tag`
- `debug` (boolean | `'verbose' | 'break'`)
- `untilMeasured` (`'hide' | 'show'`)
- `disableOptimization` (boolean)
- `tabIndex`, `role`
- `asChild` (`boolean | 'except-style' | 'except-style-web' | 'web'`)
- `passThrough` (boolean)

---

## 2. Style Props

### 2.1 Layout & Flexbox
```
width, height, minWidth, minHeight, maxWidth, maxHeight, aspectRatio,
flex, flexDirection, flexGrow, flexShrink, flexBasis,
alignItems, justifyContent, alignSelf, alignContent
```

### 2.2 Spacing
```
margin, marginX, marginY, marginTop, marginBottom, marginLeft, marginRight,
padding, paddingX, paddingY, paddingTop, paddingBottom, paddingLeft, paddingRight
```

### 2.3 Border & Background
```
borderWidth, borderColor, borderRadius, borderStyle,
backgroundColor, backgroundImage, backgroundSize, backgroundRepeat, backgroundPosition
```

### 2.4 Typography
```
fontSize, fontWeight, fontFamily, lineHeight, letterSpacing, textAlign, color
```

### 2.5 Shadow & Elevation
```
shadowColor, shadowOffset, shadowOpacity, shadowRadius, elevation
```

---

## 3. Transform Props
```
x, y, perspective, scale, scaleX, scaleY, skewX, skewY, matrix,
rotate, rotateX, rotateY, rotateZ
```

---

## 4. Pseudo-State Props
```
hoverStyle, pressStyle, focusStyle, focusVisibleStyle,
disabledStyle, enterStyle, exitStyle
```

---

## 5. Media, Theme, Platform & Group Queries

- **Media**: `$sm`, `$md`, `$lg`
- **Themes**: `$theme-light`, `$theme-dark`
- **Platform**: `$platform-ios`, `$platform-android`, `$platform-web`
- **Group**: `$group-hover`, `$group-press`, `$group-focus`, `$group-{name}-hover`

---

## 6. Component-Specific Props

### Button
- `size`, `variant`, `disabled`
- `icon`, `iconAfter`, `scaleIcon`, `scaleSpace`
- `noTextWrap`, `circular`, `unstyled`

### Switch
- `size`, `checked` / `defaultChecked`
- `onCheckedChange`, `disabled`, `native`, `unstyled`

### Input & TextArea
- `size`, `placeholder`, `value` / `defaultValue`, `onChangeText`
- All style props apply

### Stack (XStack, YStack, ZStack)
- `gap`, `space`, `alignItems`, `justifyContent`, `flex`

### Select
- `defaultValue`, `value`, `onValueChange`
- `<Select.Trigger>`, `<Select.Content>`, `<Select.Item>`

### Form
- `onSubmit`
- `<Form.Trigger>`, `<Form.Field>`, `<Form.Message>`
- `defaultValue`, `disabled`

---

## 7. Common Patterns (Sulong Kalinga)

```tsx
// Standard screen layout
<YStack flex={1} backgroundColor="$background" padding="$4">
  <XStack alignItems="center" gap="$2">
    <Text fontSize="$6" fontWeight="bold">Title</Text>
  </XStack>
</YStack>

// Pressable card
<Card
  pressStyle={{ opacity: 0.85, scale: 0.98 }}
  onPress={handlePress}
  padding="$4"
  borderRadius="$4"
  backgroundColor="white"
  borderWidth={1}
  borderColor="$borderColor"
>
  ...
</Card>

// Full-width primary button
<Button
  width="100%"
  backgroundColor="$blue10"
  color="white"
  pressStyle={{ opacity: 0.85 }}
  onPress={handleAction}
  disabled={isLoading}
  disabledStyle={{ opacity: 0.5 }}
>
  {isLoading ? <Spinner /> : 'Submit'}
</Button>

// Platform-specific style
<XStack
  padding="$3"
  $platform-ios={{ paddingTop: '$5' }}
  $platform-android={{ paddingTop: '$3' }}
>
```
