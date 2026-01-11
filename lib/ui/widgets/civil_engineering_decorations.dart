import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants/asset_paths.dart';
import '../../config/theme/app_colors.dart';

/// Civil Engineering themed decorative background
class CivilEngineeringBackground extends StatelessWidget {
  final Widget child;
  final String? backgroundAsset;
  final double opacity;

  const CivilEngineeringBackground({
    super.key,
    required this.child,
    this.backgroundAsset,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: SvgPicture.asset(
            backgroundAsset ?? AssetPaths.bgConstructionSite,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(1 - opacity),
              BlendMode.lighten,
            ),
          ),
        ),

        // Overlay gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),

        // Content
        child,
      ],
    );
  }
}

/// Fun engineering icons floating animation
class FloatingEngineeringIcons extends StatefulWidget {
  final int numberOfIcons;

  const FloatingEngineeringIcons({super.key, this.numberOfIcons = 8});

  @override
  State<FloatingEngineeringIcons> createState() =>
      _FloatingEngineeringIconsState();
}

class _FloatingEngineeringIconsState extends State<FloatingEngineeringIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> icons = [
    AssetPaths.iconAutocad,
    AssetPaths.iconRevit,
    AssetPaths.iconConstruction,
    AssetPaths.iconStructural,
    AssetPaths.iconDesign,
    AssetPaths.iconAnalysis,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: List.generate(widget.numberOfIcons, (index) {
            final progress =
                (_controller.value + (index / widget.numberOfIcons)) % 1.0;
            final size = MediaQuery.of(context).size;

            return Positioned(
              left: (index % 3) * (size.width / 3) + (progress * 100 - 50),
              top: (index % 4) * (size.height / 4) + (progress * 100 - 50),
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: progress * 6.28,
                  child: SvgPicture.asset(
                    icons[index % icons.length],
                    width: 60 + (index % 3) * 20,
                    height: 60 + (index % 3) * 20,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Animated construction crane decoration
class ConstructionCraneWidget extends StatefulWidget {
  const ConstructionCraneWidget({super.key});

  @override
  State<ConstructionCraneWidget> createState() =>
      _ConstructionCraneWidgetState();
}

class _ConstructionCraneWidgetState extends State<ConstructionCraneWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(200, 300),
          painter: CranePainter(_controller.value),
        );
      },
    );
  }
}

class CranePainter extends CustomPainter {
  final double animation;

  CranePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.vibrantYellow
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Tower
    canvas.drawLine(
      Offset(size.width * 0.5, size.height),
      Offset(size.width * 0.5, size.height * 0.2),
      paint,
    );

    // Arm
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.2),
      paint,
    );

    // Cable (animated)
    final cableX = size.width * (0.3 + animation * 0.4);
    canvas.drawLine(
      Offset(cableX, size.height * 0.2),
      Offset(cableX, size.height * (0.5 + animation * 0.2)),
      Paint()
        ..color = AppColors.accentOrange
        ..strokeWidth = 2,
    );

    // Load
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(cableX, size.height * (0.55 + animation * 0.2)),
        width: 40,
        height: 40,
      ),
      Paint()
        ..color = AppColors.vibrantPurple
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CranePainter oldDelegate) =>
      animation != oldDelegate.animation;
}

/// Construction tool icons banner
class ToolsBanner extends StatelessWidget {
  const ToolsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = ['🔨', '⚒️', '🔧', '🪛', '📐', '📏', '🏗️', '👷'];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue.withOpacity(0.1),
            AppColors.vibrantPurple.withOpacity(0.1),
          ],
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tools.length * 10,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                tools[index % tools.length],
                style: const TextStyle(fontSize: 40),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Blueprint grid pattern overlay
class BlueprintGrid extends StatelessWidget {
  final double opacity;

  const BlueprintGrid({super.key, this.opacity = 0.05});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BlueprintGridPainter(opacity),
      child: Container(),
    );
  }
}

class BlueprintGridPainter extends CustomPainter {
  final double opacity;

  BlueprintGridPainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryBlue.withOpacity(opacity)
      ..strokeWidth = 1;

    const gridSize = 50.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
