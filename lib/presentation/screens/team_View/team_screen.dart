part of "team_screen_route_imple.dart";

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamScreenBloc(apiRepository: AuthenticationApiCall())..add(LoadTeamMembers()),
      child: const TeamScreenView(),
    );
  }
}

class TeamScreenView extends StatefulWidget {
  const TeamScreenView({super.key});

  @override
  State<TeamScreenView> createState() => _TeamScreenViewState();
}

class _TeamScreenViewState extends State<TeamScreenView> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false; // Add local loading state

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context.read<TeamScreenBloc>().add(LoadMoreTeamMembers());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger when 90% scrolled
  }

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
    return BlocConsumer<TeamScreenBloc, TeamScreenState>(
      listener: (context, state) {
        // Reset loading state when load more completes
        if (state is TeamScreenLoaded && _isLoadingMore) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      },
      builder: (context, state) {
        if (state is TeamScreenLoading) {
          // Only show loading indicator for initial load
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TeamScreenError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<TeamScreenBloc>().add(LoadTeamMembers());
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is TeamScreenLoaded) {
          if (state.teamMembers.isEmpty && !_isLoadingMore) {
            return Center(
              child: Text(
                'No team members found',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          // Remove duplicates by using Set with unique identifier
          final uniqueMembers = <Datum>[];
          final seenIds = <String>{};

          for (final member in state.teamMembers) {
            final memberId = member.inspectorId?.toString() ?? '${member.email}_${member.firstName}_${member.lastName}';
            if (!seenIds.contains(memberId)) {
              seenIds.add(memberId);
              uniqueMembers.add(member);
            }
          }

          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer<void>();
              context.read<TeamScreenBloc>().add(LoadTeamMembers(isRefresh: true));

              // Wait for the refresh to complete
              final subscription = context.read<TeamScreenBloc>().stream.listen((newState) {
                if (newState is TeamScreenLoaded || newState is TeamScreenError) {
                  if (!completer.isCompleted) {
                    completer.complete();
                  }
                }
              });

              await completer.future;
              subscription.cancel();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView.separated(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(), // Ensure pull-to-refresh works
                itemCount: uniqueMembers.length + (_isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => vGap(12),
                itemBuilder: (context, index) {
                  if (index == uniqueMembers.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return _TeamMemberCard(
                    key: ValueKey(uniqueMembers[index].inspectorId ?? uniqueMembers[index].email), // Add unique key
                    member: uniqueMembers[index],
                    onSelect: () => _handleMemberSelection(uniqueMembers[index]),
                    localizations: localizations,
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void _handleMemberSelection(Datum member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InspectorProfileView(member: member),
      ),
    );
    print('Selected member: ${member.firstName} ${member.lastName}');
    // Add your selection logic here
  }
}

class _TeamMemberCard extends StatelessWidget {
  final Datum member;
  final VoidCallback onSelect;
  final AppLocalizations localizations;

  const _TeamMemberCard({
    super.key, // Make sure key is properly handled
    required this.member,
    required this.onSelect,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                InspectorProfileView(member: member),
          ),
        );
      },
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black),
      child: Row(
        children: [
          _buildAvatar(member),
          const SizedBox(width: 12),
          Expanded(child: _buildMemberInfo(member)),
          _buildSelectButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar(Datum data) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.grey[300],
      backgroundImage: data.profileImage != null && data.profileImage.toString().isNotEmpty
          ? NetworkImage(data.profileImage.toString())
          : const AssetImage(userIcon) as ImageProvider,
    );
  }

  Widget _buildMemberInfo(Datum data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${data.firstName ?? ''} ${data.lastName ?? ''}".trim(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _getLocalizedRole(data.role ?? ''),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          data.email ?? '',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
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
      text: "View",
    );
  }
}


/// Inspector profile
///

class InspectorProfileView extends StatefulWidget {
  final Datum member;

  const InspectorProfileView({super.key, required this.member});

  @override
  State<InspectorProfileView> createState() => _InspectorProfileViewState();
}

class _InspectorProfileViewState extends State<InspectorProfileView> {
  // InspectorProfileModel? inspectorProfile;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
              title: "Team Profile"),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: _fetchInspectorProfile,
            //   child: const Text('Retry'),
            // ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildProfileDetails(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor().darkYellowColor,width: 2),
            image: widget.member!.profileImage != null
                ? DecorationImage(
              image: NetworkImage(widget.member!.profileImage!),
              fit: BoxFit.cover,
            )
                : null,
            color: widget.member!.profileImage == null
                ? Colors.grey[300]
                : null,
          ),
          child: widget.member!.profileImage == null
              ? Icon(
            Icons.person,
            size: 40,
            color: Colors.grey[600],
          )
              : null,
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name:",style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            )),
            Text(
              "${widget.member!.firstName!} ${widget.member!.lastName!}",
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      spacing: 20,
      children: [
        _buildDetailRow('Gmail:', widget.member!.email!),
        _buildDetailRow('Phone Number:', widget.member!.phoneNumber!),
        _buildDetailRow('Inspection:', ''),
        _buildDetailRow('Upcoming:', ''),
        _buildDetailRow('Completed:', ''),
        _buildDetailRow('Ongoing:', ''),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Data Model
class InspectorProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int inspectionCount;
  final int upcomingCount;
  final int completedCount;
  final int ongoingCount;
  final String? profileImage;

  InspectorProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.inspectionCount,
    required this.upcomingCount,
    required this.completedCount,
    required this.ongoingCount,
    this.profileImage,
  });

  factory InspectorProfileModel.fromJson(Map<String, dynamic> json) {
    return InspectorProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      inspectionCount: json['inspection_count'] ?? 0,
      upcomingCount: json['upcoming_count'] ?? 0,
      completedCount: json['completed_count'] ?? 0,
      ongoingCount: json['ongoing_count'] ?? 0,
      profileImage: json['profile_image'],
    );
  }
}
