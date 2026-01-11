/// Asset paths for images, icons, and other resources
class AssetPaths {
  AssetPaths._();

  // Base paths
  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
  static const String _blog = 'assets/blog';
  static const String _projects = 'assets/projects';
  static const String _backgrounds = 'assets/images/backgrounds';
  static const String _patterns = 'assets/images/patterns';
  static const String _decorations = 'assets/images/decorations';

  // Legacy paths (keep for compatibility)
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String projectsPath = 'assets/projects/';
  static const String blogPath = 'assets/blog/';

  // ========== PROFILE & PERSONAL ==========
  /// Main profile picture - Add your professional headshot
  /// Recommended: 800x800px, PNG with transparent background or circular crop
  static const String profileImage = '$_images/profile.svg';

  // ========== BACKGROUND IMAGES ==========
  static const String bgGeometric1 = '$_backgrounds/geometric_1.svg';
  static const String bgWave = '$_backgrounds/wave.svg';
  static const String bgBlob = '$_backgrounds/blob.svg';
  static const String bgBlueprint = '$_backgrounds/blueprint.svg';
  static const String bgGridPattern = '$_backgrounds/grid.svg';
  static const String bgConstructionSite =
      '$_backgrounds/construction_site.svg';
  static const String bgConstructionFun = '$_backgrounds/construction_fun.svg';
  static const String bgSmartCity = '$_backgrounds/smart_city.svg';

  // ========== PATTERN & DECORATIONS ==========
  static const String patternDots = '$_patterns/dots.svg';
  static const String patternLines = '$_patterns/lines.svg';
  static const String patternGrid = '$_patterns/grid.svg';
  static const String patternHexagon = '$_patterns/hexagon.svg';
  static const String decoFloatingCircles =
      '$_decorations/floating_circles.svg';
  static const String decoWaves = '$_decorations/waves.svg';
  static const String decoShapes = '$_decorations/shapes.svg';

  // ========== SKILL ICONS ==========
  static const String iconFlutter = '$_icons/flutter.svg';
  static const String iconDart = '$_icons/dart.svg';
  static const String iconAutocad = '$_icons/autocad.svg';
  static const String iconRevit = '$_icons/revit.svg';
  static const String iconStaadPro = '$_icons/staadpro.svg';
  static const String iconCivil3D = '$_icons/civil3d.svg';
  static const String iconPython = '$_icons/python.svg';
  static const String iconExcel = '$_icons/excel.svg';
  static const String iconGit = '$_icons/git.svg';
  static const String iconStructural = '$_icons/structural.svg';
  static const String iconConstruction = '$_icons/construction.svg';
  static const String iconDesign = '$_icons/design.svg';
  static const String iconAnalysis = '$_icons/analysis.svg';

  // ========== PROJECT IMAGES ==========
  static const String project1Thumb = '$_projects/project_1/thumbnail.svg';
  static const String project1Detail1 = '$_projects/project_1/detail_1.jpg';
  static const String project1Detail2 = '$_projects/project_1/detail_2.jpg';
  static const String project2Thumb = '$_projects/project_2/thumbnail.svg';
  static const String project2Detail1 = '$_projects/project_2/detail_1.jpg';
  static const String project3Thumb = '$_projects/project_3/thumbnail.svg';
  static const String project3Detail1 = '$_projects/project_3/detail_1.jpg';

  // ========== SOCIAL MEDIA ICONS ==========
  static const String emailIcon = '$_icons/email.svg';
  static const String phoneIcon = '$_icons/phone.svg';
  static const String locationIcon = '$_icons/location.svg';
  static const String githubIcon = '$_icons/github.svg';
  static const String linkedinIcon = '$_icons/linkedin.svg';
  static const String twitterIcon = '$_icons/twitter.svg';
  static const String instagramIcon = '$_icons/instagram.svg';
  static const String whatsappIcon = '$_icons/whatsapp.svg';
  static const String facebookIcon = '$_icons/facebook.svg';

  // ========== LOGO & BRANDING ==========
  static const String logoImage = '$_images/logo.svg';
  static const String nepalFlag = '$_images/nepal_flag.svg';

  // ========== ILLUSTRATIONS ==========
  static const String illuEngineering =
      '$_images/illustrations/engineering.svg';
  static const String illuInnovation = '$_images/illustrations/innovation.svg';
  static const String illuTeamwork = '$_images/illustrations/teamwork.svg';
  static const String illuSuccess = '$_images/illustrations/success.svg';
  static const String illuEmpty = '$_images/illustrations/empty_state.svg';

  // ========== BLOG ==========
  static const String blogDefaultThumb = '$_blog/default_thumbnail.jpg';

  // ========== CERTIFICATES ==========
  static const String certFolder = '$_images/certificates';
  static const String cert1 = '$certFolder/certificate_1.jpg';
  static const String cert2 = '$certFolder/certificate_2.jpg';
  static const String cert3 = '$certFolder/certificate_3.jpg';
}

/// Placeholder URLs for development
class WebAssets {
  WebAssets._();

  static const String profilePlaceholder =
      'https://scontent.fbir1-1.fna.fbcdn.net/v/t39.30808-6/499871741_2118104532019548_2879260451781288263_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=XIocgKKPYTMQ7kNvwHHIebc&_nc_oc=AdmySIDhVBwOECe2P3SGidCwVjsOyNpLOaD6R1YJZQUzZxD2lhoKQp_pyhrHdJ6m8nM&_nc_zt=23&_nc_ht=scontent.fbir1-1.fna&_nc_gid=cb7EUIuJuYtucXeyvpjbjQ&oh=00_AfoAQ8FL4FUN7a91qzVPvxzwtfAgkjr_IKxcEVxcVFUNxA&oe=69698C86';
  static const String heroPlaceholder =
      'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=1920&h=1080&fit=crop';
  static const String codingBackground =
      'https://images.ctfassets.net/qyg0c6wmz8bn/2OlyjXEnTKJNdcTHXqOM37/396416a701cd017132778e72015d578a/what-is-civil-engineering.jpg';
  static const String engineeringDeskBackground =
      'assets/image.png';
  static const String projectPlaceholder =
      'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=1200&h=800&fit=crop';
  static const String engineeringBg =
      'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=1920&h=1080&fit=crop';
}
