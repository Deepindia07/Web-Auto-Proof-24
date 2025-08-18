part of "team_screen_route_imple.dart";

/*class TeamScreen extends StatelessWidget {
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
  bool _isLoadingMore = false;

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
    final String? currentCompanyId = SharedPrefsHelper.instance.getString(companyId);
    print('Company ID: $currentCompanyId');
    return CustomAppBar(
      backgroundColor: AppColor().backgroundColor,
      title: localizations.myTeam,
      largeWidget: (currentCompanyId != null && currentCompanyId.isNotEmpty)?InkWell(
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
      ):Container(),
    );
  }

  Widget _buildTeamList(AppLocalizations localizations) {
    return BlocConsumer<TeamScreenBloc, TeamScreenState>(
      listener: (context, state) {
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
}*/

/*
class MyTeamScreen extends StatelessWidget {
  const MyTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyTeamScreenBloc>(
      create: (_) => MyTeamScreenBloc(vehicleRepository: AuthenticationApiCall()),
      child: const MyTeamScreenView(),
    );
  }
}

class MyTeamScreenView extends StatefulWidget {
  const MyTeamScreenView({super.key});

  @override
  State<MyTeamScreenView> createState() => _MyTeamScreenViewState();
}

class _MyTeamScreenViewState extends State<MyTeamScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<MyTeamScreenBloc>().add(LoadVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "My Vehicles",
          ),
          Expanded(
            child: BlocBuilder<MyTeamScreenBloc, MyTeamScreenState>(
              builder: (context, state) {
                if (state is MyTeamScreenLoading) {
                  return  Center(
                    child: CustomLoader(),
                  );
                } else if (state is MyTeamScreenLoaded) {
                  if (state.vehicles.isEmpty) {
                    return  Center(
                      child: universalNull(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<MyTeamScreenBloc>().add(RefreshVehiclesEvent());
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.vehicles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _VehicleCard(
                        vehicle: state.vehicles[i],
                        onSelect: () => _selectVehicle(state.vehicles[i] as Vehicle),
                      ),
                    ),
                  );
                } else if (state is MyTeamScreenError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.errorMessage}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MyTeamScreenBloc>().add(LoadVehiclesEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox(); // Initial state
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectVehicle(Vehicle vehicle) {
    print('Selected: ${vehicle.brand}');
    // You can navigate to another screen or perform other actions here
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onSelect;

  const _VehicleCard({required this.vehicle, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final color = AppColor().darkCharcoalBlueColor;

    return CustomContainer(
      onTap: (){
       SharedPrefsHelper.instance.setString(vehicleId, vehicle.vehicleId.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehicleDetailsScreen(vehicleList: vehicle,vehicleId: SharedPrefsHelper.instance.getString(vehicleId)!,)),
        );
      },
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.black),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: color.withOpacity(0.1)),
            ),
            child: Image.asset(carCopy, height: 20,width: 20,),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vehicle.brand!,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vehicle.numberPlate!,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: color.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            elevation: 0,
            side: BorderSide.none,
            borderRadius: 12,
            backgroundColor: AppColor().darkYellowColor,
            onPressed: onSelect,
            text: "Select",
            textStyle: MontserratStyles.montserratRegularTextStyle(
              size: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Vehicle Details
///

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicleList;
  final String vehicleId;
  const VehicleDetailsScreen({
    super.key, required this.vehicleList, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
              backgroundColor: AppColor().backgroundColor,
              title: "My Vehicles"),
          Expanded(child: _vehicleView(context))
        ],
      ),
    );
  }

  _vehicleView(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Vehicle Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(48),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: Image.asset(
               carCopy,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.directions_car,
                    size: 50, // Reduced from 60 to 48
                    color: Colors.grey[600],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 16),
          Text(
            'Dodge RAM',
            style: TextStyle(
              fontSize: 19.2, // Reduced from 24 to 19.2
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 24), // Reduced from 30 to 24

          _buildDetailRow('Number Plate', vehicleList.numberPlate.toString()),
          _buildDetailRow('Brand', vehicleList.brand.toString()),
          _buildDetailRow('Model', vehicleList.model.toString()),
          _buildDetailRow('Mileage', vehicleList.mileage.toString()),
          _buildDetailRow('Gas Type', vehicleList.gasType.toString()),
          _buildDetailRow('Gas Level', vehicleList.gasLevel.toString()),
          _buildDetailRow('Tyre condition', vehicleList.tyresCondition.toString()),
          _buildDetailRow('Km/day', vehicleList.kmPerDay.toString()),
          _buildDetailRow('Extra KM', vehicleList.extraKm.toString()),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.8, horizontal: 0), // Reduced from 16 to 12.8
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16, // Reduced from 16 to 12.8
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14, // Reduced from 16 to 12.8
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}*/

class MyTeamScreen extends StatefulWidget {
  final Function(ScreenType) onScreenChange; // callback

  const MyTeamScreen({super.key, required this.onScreenChange});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  List<GetTeamUserData>? getTeamUserData;
  @override
  void initState() {
    context.read<TeamScreenBloc>().add(LoadTeamMembers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          bool isMobile = maxWidth < 800;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vGap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Team",
                        style: MontserratStyles.montserratBoldTextStyle(
                          size: 14,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Trigger screen change in parent
                          widget.onScreenChange(ScreenType.addInspector);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Add Team",
                              style:
                                  MontserratStyles.montserratRegularTextStyle(
                                    size: 12,
                                    color: AppColor().silverShadeGrayColor,
                                  ),
                            ),
                            hGap(10),
                            Image.asset(addIcon, height: 20, width: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  vGap(10),
                  Expanded(
                    child: BlocConsumer<TeamScreenBloc, TeamScreenState>(
                      listener: (context, state) {
                        if (state is TeamScreenLoaded) {
                          getTeamUserData = state.teamMembers;
                        }
                      },
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: getTeamUserData?.length ?? 0,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                          itemBuilder: (context, index) {
                            return _teamItem(
                              name: getTeamUserData?[index].firstName ?? "",
                              email: getTeamUserData?[index].email ?? "",
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _teamItem({required String name, required String email}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor().backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColor().silverShadeGrayColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/image/profile.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: MontserratStyles.montserratRegularTextStyle(
                    size: 12,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {

              widget.onScreenChange(ScreenType.viewTeamProfile);
            },
            child: Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor().yellowWarmColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "view",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
