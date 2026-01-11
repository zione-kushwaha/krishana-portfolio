# Krishna Portfolio - Quick Setup Guide

## 🚀 Quick Start (5 minutes)

### 1. Install Dependencies (Already Done!)
```bash
flutter pub get
```

### 2. Run the App
```bash
# For web (recommended for testing)
flutter run -d chrome

# For Windows desktop
flutter run -d windows

# For mobile device (connect via USB)
flutter run
```

### 3. Next Steps - Customize Your Portfolio

#### A. Update Personal Information (5 min)
File: `lib/config/constants/constants.dart`
- Change name, email, phone
- Update social media links

#### B. Download & Add Fonts (Optional - 10 min)
1. Download from Google Fonts:
   - [Poppins](https://fonts.google.com/specimen/Poppins) - Download Regular, Medium, SemiBold, Bold
   - [Montserrat](https://fonts.google.com/specimen/Montserrat) - Download Regular, Bold

2. Place TTF files in: `assets/fonts/`

3. Uncomment font section in `pubspec.yaml`

4. Run: `flutter pub get`

#### C. Add Your Profile Picture (5 min)
1. Add your photo as: `assets/images/profile.jpg`
2. Edit `lib/ui/home_welcome.dart` line ~130
3. Uncomment the Image.asset section

#### D. Customize Content (15-30 min)
- **About Me**: Edit `lib/ui/about_me/about_me.dart`
- **Skills**: Edit `lib/ui/skills/my_skills.dart`
- **Blog Posts**: Add in `lib/data/models/blog_post.dart`

#### E. Setup Contact Form (Optional - 15 min)
1. Create account at [Formspree.io](https://formspree.io) (free)
2. Get your form ID
3. Update `lib/data/message_sender_api.dart` line 7

## 📱 Testing Checklist

- [ ] App runs without errors
- [ ] All sections load properly
- [ ] Navigation works (click menu items)
- [ ] Contact form validates inputs
- [ ] Blog posts open correctly
- [ ] Responsive on mobile (resize browser)

## 🎨 Color Customization

Want different colors? Edit `lib/config/theme/app_colors.dart`

Current theme:
- Primary: Blueprint Blue (#1976D2)
- Accent: Safety Orange (#FF6F00)
- Background: White with light gray sections

## 📦 Build for Production

### Web
```bash
flutter build web --release
# Output in: build/web/
```

### Windows
```bash
flutter build windows --release
# Output in: build/windows/runner/Release/
```

### Android APK
```bash
flutter build apk --release
# Output in: build/app/outputs/flutter-apk/
```

## ❓ Troubleshooting

### "Font not found" error
- Comment out fonts section in pubspec.yaml (already done)
- Or download and add fonts to assets/fonts/

### "Image not found" error
- Add placeholder images to assets/images/
- Or images will show as placeholders (icons)

### App won't run
```bash
flutter clean
flutter pub get
flutter run
```

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design](https://material.io/design)
- [Google Fonts](https://fonts.google.com/)

## 🆘 Need Help?

Check the detailed README.md for:
- Complete project structure
- All customization options
- Deployment guides
- Feature explanations

---

**Time to First Run**: ~2 minutes ⚡
**Time to Full Customization**: ~1-2 hours 🎨

Good luck with your portfolio, Krishna! 🎓🏗️
