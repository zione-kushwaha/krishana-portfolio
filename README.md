# Krishna Portfolio Website

A modern, responsive portfolio website built with Flutter for Krishna, a Civil Engineering student at IOE Purwanchal Campus, Dharan.

## ✨ Features

### 🎨 Design & UI
- **Modern & Professional**: Civil engineering-themed color palette (Blueprint Blue, Safety Orange, Steel Gray)
- **Fully Responsive**: Optimized for desktop, tablet, and mobile devices
- **Smooth Animations**: Animated text, transitions, and hover effects
- **Glass Morphism**: Modern UI effects and gradients
- **Custom Components**: Reusable animated widgets

### 📱 Sections
1. **Home/Welcome**: Eye-catching hero section with animated titles
2. **About Me**: Professional introduction and academic background
3. **Skills**: Interactive skill cards showcasing technical expertise
4. **Projects**: Showcase of engineering projects (ready to be populated)
5. **Blog**: Full-featured blog with Markdown support
6. **Contact**: Contact form with validation and social media links

### 🚀 Technical Features
- **State Management**: Provider pattern for clean architecture
- **Responsive Framework**: Custom responsive utilities for all screen sizes
- **Form Validation**: Professional contact form with validation
- **Blog System**: Markdown-based blog with detailed view
- **Service Locator**: Dependency injection with GetIt
- **Clean Architecture**: Organized folder structure

## 📁 Project Structure

```
lib/
├── config/
│   ├── constants/
│   │   ├── asset_paths.dart      # Asset path constants
│   │   ├── constants.dart         # App-wide constants
│   │   └── navigation_tags.dart   # Navigation section tags
│   └── theme/
│       ├── app_colors.dart        # Color palette
│       ├── text_theme.dart        # Typography
│       └── themes.dart            # App theme
├── data/
│   ├── models/
│   │   └── blog_post.dart         # Blog post model
│   ├── message_sender_api.dart    # Contact form API
│   └── url_handler.dart           # URL launching utilities
├── provider/
│   ├── current_tag_notifier.dart  # Navigation state
│   └── message_sender_notifier.dart # Form state
├── responsive/
│   ├── src/
│   │   ├── constants.dart         # Breakpoints
│   │   ├── extensions.dart        # Helper extensions
│   │   ├── screen.dart            # Screen inherited widget
│   │   ├── screen_data.dart       # Screen data model
│   │   └── screen_type.dart       # Screen type enum
│   └── responsive.dart            # Barrel export
├── ui/
│   ├── about_me/
│   │   └── about_me.dart          # About section
│   ├── blog/
│   │   ├── blog_detail.dart       # Blog post detail page
│   │   └── blog_section.dart      # Blog list section
│   ├── contact/
│   │   └── contact_me.dart        # Contact form
│   ├── navigation/
│   │   ├── home_appbar.dart       # App bar
│   │   └── home_drawer.dart       # Mobile drawer
│   ├── skills/
│   │   └── my_skills.dart         # Skills section
│   ├── widgets/
│   │   ├── animated_title_text.dart
│   │   ├── animated_underline_text.dart
│   │   ├── auto_tagged_item.dart
│   │   ├── custom_elevated_button.dart
│   │   └── tagged_list_view.dart
│   ├── home.dart                  # Main home screen
│   └── home_welcome.dart          # Hero section
├── krishna_portfolio_app.dart     # App root widget
├── main.dart                      # App entry point
└── service_locator.dart           # Dependency injection
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- VS Code or Android Studio

### Installation

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the app**:
   ```bash
   flutter run -d chrome  # For web
   flutter run -d windows # For Windows desktop
   flutter run            # For connected mobile device
   ```

## 🎨 Customization Guide

### 1. Personal Information
Edit `lib/config/constants/constants.dart`:
```dart
const String kOwnerName = 'Your Name';
const String kOwnerEmail = 'your.email@example.com';
const String kOwnerPhone = '+977 98XXXXXXXX';
const String kGithubUrl = 'https://github.com/yourusername';
// ... other social links
```

### 2. Profile Image
1. Add your image to `assets/images/profile.jpg`
2. Update `lib/ui/home_welcome.dart` (search for "TODO: Replace with actual image")

### 3. About Me Content
Edit `lib/ui/about_me/about_me.dart` to update your bio and information.

### 4. Skills
Modify the skills list in `lib/ui/skills/my_skills.dart`:
```dart
List<Skill> _getSkillsList() {
  return [
    Skill(
      title: 'Your Skill Category',
      icon: Icons.your_icon,
      color: AppColors.yourColor,
      items: ['Skill 1', 'Skill 2', ...],
    ),
    // ... more skills
  ];
}
```

### 5. Blog Posts
Add blog posts in `lib/data/models/blog_post.dart`:
```dart
BlogPost(
  id: 'unique-id',
  title: 'Your Blog Title',
  excerpt: 'Short description...',
  content: '''# Your Markdown Content...''',
  imageUrl: 'assets/blog/your-image.jpg',
  author: 'Your Name',
  publishedDate: DateTime(2024, 1, 1),
  tags: ['Tag1', 'Tag2'],
  readTimeMinutes: 5,
),
```

### 6. Contact Form API
Update `lib/data/message_sender_api.dart`:
- Replace `YOUR_FORM_ID` with your Formspree or similar service ID
- Or implement your own backend API

### 7. Colors & Theme
Customize colors in `lib/config/theme/app_colors.dart`:
```dart
static const Color primaryBlue = Color(0xFF1976D2);
static const Color accentOrange = Color(0xFFFF6F00);
// ... modify as needed
```

## 📦 Assets Setup

Create these folders and add your assets:
```
assets/
├── images/
│   ├── profile.jpg        # Your profile photo
│   └── logo.png           # Optional logo
├── icons/                 # SVG icons (optional)
├── blog/                  # Blog post images
└── fonts/                 # Custom fonts
    ├── Poppins-Regular.ttf
    ├── Poppins-Medium.ttf
    ├── Poppins-SemiBold.ttf
    ├── Poppins-Bold.ttf
    ├── Montserrat-Regular.ttf
    └── Montserrat-Bold.ttf
```

### Download Fonts
- **Poppins**: [Google Fonts - Poppins](https://fonts.google.com/specimen/Poppins)
- **Montserrat**: [Google Fonts - Montserrat](https://fonts.google.com/specimen/Montserrat)

## 🌐 Deployment

### GitHub Pages (Web)
1. Build for web:
   ```bash
   flutter build web --release
   ```
2. Deploy the `build/web` folder to GitHub Pages

### Windows Desktop
```bash
flutter build windows --release
```

### Android/iOS
```bash
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 🎯 Features to Add

- [ ] Add projects section with project cards
- [ ] Implement scroll-to-section navigation
- [ ] Add actual images for profile and blog posts
- [ ] Set up contact form backend
- [ ] Add project case studies
- [ ] Implement download resume functionality
- [ ] Add more blog posts
- [ ] Add analytics (Google Analytics)
- [ ] Add SEO meta tags for web
- [ ] Add loading animations

## 📝 Dependencies

- **flutter**: UI framework
- **provider**: State management
- **get_it**: Dependency injection
- **hive_flutter**: Local storage
- **http**: HTTP requests
- **url_launcher**: Opening URLs
- **animated_text_kit**: Text animations
- **flutter_markdown**: Markdown rendering
- **toastification**: Toast notifications
- **intl**: Internationalization
- **auto_size_text**: Responsive text

## 🤝 Contributing

This is a personal portfolio project, but suggestions are welcome!

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

**Krishna**
- Civil Engineering Student
- IOE Purwanchal Campus, Dharan
- Email: krishna@example.com

---

Built with ❤️ using Flutter
#   k r i s h a n a - p o r t f o l i o  
 