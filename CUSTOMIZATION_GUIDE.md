# 🎨 Customization Guide for Krishna Portfolio

## 1. Personal Information

### File: `lib/config/constants/constants.dart`

Replace these with your actual information:

```dart
const String kOwnerName = 'Krishna';
const String kOwnerFullTitle = 'Civil Engineering Student';
const String kOwnerInstitution = 'IOE Purwanchal Campus, Dharan';
const String kOwnerEmail = 'krishna.civil@gmail.com';  // ← Change this
const String kOwnerPhone = '+977 9812345678';          // ← Change this

// Social Media Links
const String kGithubUrl = 'https://github.com/krishna-username';
const String kLinkedInUrl = 'https://linkedin.com/in/krishna-username';
const String kFacebookUrl = 'https://facebook.com/krishna.username';
const String kInstagramUrl = 'https://instagram.com/krishna.username';
```

## 2. About Me Section

### File: `lib/ui/about_me/about_me.dart`

Find the `_buildContent` method and update the text:

```dart
Text(
  'A passionate Civil Engineering student at IOE Purwanchal Campus, Dharan, '
  'dedicated to creating innovative solutions for modern infrastructure challenges.',
  // ↑ Replace with your story
),
```

Add your achievements, interests, and goals!

## 3. Skills Section

### File: `lib/ui/skills/my_skills.dart`

In the `_getSkillsList()` method, customize your skills:

```dart
Skill(
  title: 'Your Skill Category',           // e.g., 'Concrete Technology'
  icon: Icons.analytics,                  // Choose an icon
  color: AppColors.primaryBlue,           // Pick a color
  items: [
    'Specific Skill 1',                   // e.g., 'Mix Design'
    'Specific Skill 2',                   // e.g., 'Quality Testing'
    'Specific Skill 3',
    'Specific Skill 4',
  ],
),
```

Example Civil Engineering skills to include:
- Structural Analysis (STAAD Pro, ETABS, SAP 2000)
- CAD & Design (AutoCAD, Revit, SketchUp)
- Surveying (Total Station, GPS, Leveling)
- Project Management (MS Project, Primavera)
- Geotechnical Engineering
- Transportation Engineering
- Water Resources
- Environmental Engineering

## 4. Blog Posts

### File: `lib/data/models/blog_post.dart`

Add more blog posts in the `getSamplePosts()` method:

```dart
BlogPost(
  id: '4',  // ← Make unique
  title: 'My Internship Experience at [Company Name]',
  excerpt: 'What I learned during my summer internship...',
  content: '''
# My Internship Experience

## Introduction
During my internship at [Company], I worked on...

## Key Learnings
1. **Project Planning**: I learned how to...
2. **Site Management**: Understanding real-world challenges...

## Conclusion
This experience taught me...
  ''',
  imageUrl: 'assets/blog/internship.jpg',
  author: 'Krishna',
  publishedDate: DateTime(2024, 3, 1),
  tags: ['Internship', 'Experience', 'Learning'],
  readTimeMinutes: 6,
),
```

Blog post ideas:
- "My Journey to IOE: From Dreams to Reality"
- "Understanding Earthquake Resistant Design in Nepal"
- "Sustainable Construction Practices for Nepal"
- "Campus Life at IOE Purwanchal"
- "Top 5 Software Every Civil Engineer Should Know"
- "My Final Year Project: [Project Name]"

## 5. Projects Section (To Be Added)

Create a new file: `lib/data/models/project.dart`

```dart
class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String category; // 'structural', 'water', 'transportation', etc.
  
  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.category,
  });
}
```

Example projects:
- "Design of Multi-Story Building with Seismic Analysis"
- "Bridge Design and Analysis"
- "Water Supply System for Rural Area"
- "Traffic Management System Design"
- "Green Building Design Project"

## 6. Color Scheme

### File: `lib/config/theme/app_colors.dart`

Want a different look? Change the colors:

```dart
// Option 1: Green & Blue (Eco-friendly theme)
static const Color primaryBlue = Color(0xFF2E7D32);  // Green
static const Color accentOrange = Color(0xFF1976D2); // Blue

// Option 2: Professional Dark
static const Color primaryBlue = Color(0xFF263238);  // Dark Gray
static const Color accentOrange = Color(0xFFFF5722); // Deep Orange

// Option 3: Modern Purple
static const Color primaryBlue = Color(0xFF673AB7);  // Purple
static const Color accentOrange = Color(0xFFFFB300); // Amber
```

Use [Material Color Tool](https://material.io/resources/color/) to pick colors!

## 7. Typography

### File: `lib/config/theme/themes.dart`

After adding fonts, change the font family:

```dart
ThemeData createLightTheme() {
  const String fontFamily = 'YourFontName';  // ← Change this
  // ...
}
```

Google Fonts recommendations:
- **Modern**: Inter, Poppins, Montserrat
- **Professional**: Roboto, Open Sans, Lato
- **Elegant**: Playfair Display, Merriweather

## 8. Add Your Photos

### Profile Picture
1. Take/choose a professional photo
2. Resize to 800x800 pixels (square)
3. Save as: `assets/images/profile.jpg`

### Blog Images
- Save blog images as: `assets/blog/blog-title.jpg`
- Recommended size: 1200x675 (16:9 ratio)

### Project Images
- Save as: `assets/projects/project-name.jpg`
- Recommended size: 1200x800

## 9. Contact Form Setup

### Option A: Formspree (Free, Easy)
1. Go to [formspree.io](https://formspree.io)
2. Sign up (free)
3. Create a new form
4. Copy your form ID (looks like: `xyzabc123`)
5. Update `lib/data/message_sender_api.dart`:

```dart
static const String _apiEndpoint = 'https://formspree.io/f/xyzabc123';
```

### Option B: EmailJS (Alternative)
1. Go to [emailjs.com](https://www.emailjs.com/)
2. Follow similar setup
3. Update API endpoint accordingly

## 10. Add Resume Download

Create a button in the About or Contact section:

```dart
CustomElevatedButton(
  text: 'Download Resume',
  icon: Icons.download,
  onPressed: () async {
    const url = 'assets/resume/krishna-resume.pdf';
    // Use url_launcher to download
  },
),
```

## Quick Checklist

- [ ] Updated personal information in constants.dart
- [ ] Customized About Me section
- [ ] Added my own skills
- [ ] Written at least 3 blog posts
- [ ] Added profile picture
- [ ] Set up contact form
- [ ] Updated social media links
- [ ] Changed colors to match my style (optional)
- [ ] Added custom fonts (optional)
- [ ] Added projects section (optional)

## Need Inspiration?

Check out these portfolio examples:
- [Behance - Engineering Portfolios](https://www.behance.net/search/projects?search=civil%20engineering%20portfolio)
- [Dribbble - Portfolio Designs](https://dribbble.com/search/portfolio)

---

Remember: Start simple, then enhance! You can always add more features later.

Happy customizing! 🎨✨
