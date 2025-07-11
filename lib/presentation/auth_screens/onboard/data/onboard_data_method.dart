class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final bool showGetStarted;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    this.showGetStarted = false,
  });
}