part of "team_screen_route_imple.dart";

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TeamScreenView();
  }
}

class TeamScreenView extends StatefulWidget {
  const TeamScreenView({super.key});

  @override
  State<TeamScreenView> createState() => _TeamScreenViewState();
}

class _TeamScreenViewState extends State<TeamScreenView> {
  // Sample data - in a real app, this would come from a service/repository
  final List<TeamMember> _teamMembers = [
    TeamMember(id: '1', name: 'Rajesh Employee', role: 'Developer'),
    TeamMember(id: '2', name: 'Priya Manager', role: 'Team Lead'),
    TeamMember(id: '3', name: 'Amit Designer', role: 'UI/UX Designer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          _buildAppBar(),
          _buildTeamList(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      backgroundColor: AppColor().backgroundColor,
      title: "My Team",
    );
  }

  Widget _buildTeamList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(),
            Expanded(
              child: ListView.separated(
                itemCount: _teamMembers.length,
                separatorBuilder: (context, index) => vGap(12),
                itemBuilder: (context, index) => _TeamMemberCard(
                  member: _teamMembers[index],
                  onSelect: () => _handleMemberSelection(_teamMembers[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMemberSelection(TeamMember member) {
    print('Selected member: ${member.name}');}
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Write us:",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  final VoidCallback onSelect;

  const _TeamMemberCard({
    required this.member,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 12),
          Expanded(child: _buildMemberInfo()),
          _buildSelectButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey[300],
      child: Text(
        member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildMemberInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          member.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          member.role,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectButton() {
    return CustomButton(
      backgroundColor: AppColor().darkYellowColor,
      onPressed: onSelect,
      text: "Select",
    );
  }
}

// Data model for team members
class TeamMember {
  final String id;
  final String name;
  final String role;

  const TeamMember({
    required this.id,
    required this.name,
    required this.role,
  });
}