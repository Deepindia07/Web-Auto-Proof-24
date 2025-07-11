part of 'splash_screen_route_imple.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc()..add(SplashScreenStarted()),
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashScreenCompleted) {
          _navigateToOnboarding();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor().darkCharcoalBlueColor,
        body: Stack(
          children: [
            _buildBackgroundCircles(screenWidth, screenHeight),
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(
                        splashLogo,
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.18,
                        fit: BoxFit.contain,
                        // color: AppColor().darkYellowColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundCircles(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        Positioned(
          top: -screenHeight * 0.018,
          left: screenWidth * 0.16,
          child: Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.6),
            ),
          ),
        ),

        Positioned(
          top: screenHeight * 0.25,
          left: -screenWidth * 0.25,
          child: Container(
            width: screenWidth * 0.65,
            height: screenWidth * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.6),
            ),
          ),
        ),

        Positioned(
          top: -screenHeight * 0.05,
          right: screenWidth * 0.04,
          child: Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.65),
            ),
          ),
        ),

        Positioned(
          top: screenHeight * 0.14,
          right: screenWidth * 0.02,
          child: Container(
            width: screenWidth * 0.04,
            height: screenWidth * 0.04,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.9),
            ),
          ),
        ),

        Positioned(
          bottom: screenHeight * 0.3,
          right: screenWidth * 0.08,
          child: Container(
            width: screenWidth * 0.05,
            height: screenWidth * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.9),
            ),
          ),
        ),

        Positioned(
          bottom: screenHeight * 0.15,
          left: screenWidth * 0.25,
          child: Container(
            width: screenWidth * 0.03,
            height: screenWidth * 0.03,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.9),
            ),
          ),
        ),

        Positioned(
          bottom: screenHeight * 0.06,
          right: -screenWidth * 0.28,
          child: Container(
            width: screenWidth * 0.65,
            height: screenWidth * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor().darkYellowColor.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToOnboarding() {
    context.pushReplacement("/onBoardScreenRoute");
  }
}