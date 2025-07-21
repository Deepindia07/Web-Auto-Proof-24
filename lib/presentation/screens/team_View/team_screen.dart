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
  final List<TeamMember> _teamMembers = [
    TeamMember(id: '1', name: 'Rajesh Employee', role: 'roleDeveloper'),
    TeamMember(id: '2', name: 'Priya Manager', role: 'roleTeamLead'),
    TeamMember(id: '3', name: 'Amit Designer', role: 'roleUIDesigner'),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(localizations),
          Expanded(child: _buildTeamList(localizations))
        ],
      ),
    );
  }

  Widget _buildAppBar(AppLocalizations localizations) {
    return CustomAppBar(
      backgroundColor: AppColor().backgroundColor,
      title: localizations.myTeam,
      largeWidget: InkWell(
        onTap: () {
          context.push(AppRoute.createInspectorView);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          children: [
            Text(
              localizations.addTeam,
              style: MontserratStyles.montserratRegularTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 14,
              ),
            ),
            const Icon(Icons.add_circle_rounded, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamList(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView.separated(
        itemCount: _teamMembers.length,
        separatorBuilder: (context, index) => vGap(4),
        itemBuilder: (context, index) => _TeamMemberCard(
          member: _teamMembers[index],
          onSelect: () => _handleMemberSelection(_teamMembers[index]),
          localizations: localizations,
        ),
      ),
    );
  }

  void _handleMemberSelection(TeamMember member) {
    print('Selected member: ${member.name}');
  }
}

class _TeamMemberCard extends StatelessWidget {
  final TeamMember member;
  final VoidCallback onSelect;
  final AppLocalizations localizations;

  const _TeamMemberCard({
    required this.member,
    required this.onSelect,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(8),
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
      radius: 35,
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
          _getLocalizedRole(member.role),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _getLocalizedRole(String roleKey) {
    switch (roleKey) {
      case 'roleDeveloper':
        return localizations.roleDeveloper;
      case 'roleTeamLead':
        return localizations.roleTeamLead;
      case 'roleUIDesigner':
        return localizations.roleUIDesigner;
      default:
        return roleKey;
    }
  }

  Widget _buildSelectButton() {
    return CustomButton(
      backgroundColor: AppColor().darkYellowColor,
      onPressed: onSelect,
      text: localizations.select,
    );
  }
}
