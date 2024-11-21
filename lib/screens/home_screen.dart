import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtracking_app/colors_all.dart';
import 'package:vtracking_app/widgets/group_list_item.dart';
import 'package:vtracking_app/widgets/vehicle_info_card.dart';
import 'package:vtracking_app/widgets/expandable_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  String? selectedGroup;
  LatLng? selectedVehicleLocation;
  bool _showInfoCard = false;
  final MapController _mapController = MapController();
  final Map<String, LatLng> vehicleLocations = {
    'Vehicle 1 of Group A': const LatLng(21.4858, 39.1925),
    'Vehicle 2 of Group A': const LatLng(21.4958, 39.2025),
    'Vehicle 1 of Group B': const LatLng(21.5058, 39.2125),
    'Vehicle 2 of Group B': const LatLng(21.5158, 39.2225),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          selectedGroup = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToVehicle(String vehicleName) {
    final location = vehicleLocations[vehicleName];
    if (location != null) {
      setState(() {
        selectedVehicleLocation = location;
        _showInfoCard = true;
      });
      _mapController.move(location, 15);
      Navigator.of(context).pop();
    }
  }

  void hideVehicle() {
    setState(() {
      _showInfoCard = false;
      selectedVehicleLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue,
                AppColors.secondaryBlue,
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryBlue,
                    AppColors.secondaryBlue,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Spacer(),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(child: Text('Groups', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Tab(child: Text('Vehicles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ],
                    labelColor: AppColors.primaryOrange,
                    unselectedLabelColor: AppColors.primaryOrange,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.primaryOrange,
                          width: 3.0,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: -10),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // First tab content (Groups)
                  ListView(
                    children: [
                      GroupListItem(
                        groupName: 'Group A',
                        isSelected: selectedGroup == 'Group A',
                        onTap: () {
                          setState(() {
                            selectedGroup = 'Group A';
                            _tabController.animateTo(1);
                          });
                        },
                      ),
                      GroupListItem(
                        groupName: 'Group B',
                        isSelected: selectedGroup == 'Group B',
                        onTap: () {
                          setState(() {
                            selectedGroup = 'Group B';
                            _tabController.animateTo(1);
                          });
                        },
                      ),
                    ],
                  ),
                  // Second tab content (Vehicles)
                  selectedGroup == null
                      ? const Center(child: Text('Please select a group first'))
                      : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Vehicles for $selectedGroup',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      VehicleListItem(
                        vehicleName: 'Vehicle 1 of $selectedGroup',
                        onNavigateTap: () => _navigateToVehicle('Vehicle 1 of $selectedGroup'),
                      ),
                      VehicleListItem(
                        vehicleName: 'Vehicle 2 of $selectedGroup',
                        onNavigateTap: () => _navigateToVehicle('Vehicle 2 of $selectedGroup'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(21.4858, 39.1925), // Jeddah, Saudi Arabia
              initialZoom: 10.4,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (selectedVehicleLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: selectedVehicleLocation!,
                      child: const Icon(
                        Icons.directions_car,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
          if (_showInfoCard && selectedVehicleLocation != null)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0), // Adjust the top padding as needed
                child: VehicleInfoCard(
                  vehicleName: vehicleLocations.entries
                      .firstWhere((entry) => entry.value == selectedVehicleLocation)
                      .key,
                  onClose: () {
                    setState(() {
                      _showInfoCard = false;
                    });
                  },
                  onHideVehicle: hideVehicle,
                ),
              ),
            ),
        ],
      ),
      extendBody: true, // Added to make body extend behind bottom bar
      bottomNavigationBar: ExpandableBottomAppBar(
        onLeftButtonPressed: () {
          // Zoom out
          double currentZoom = _mapController.camera.zoom;
          _mapController.move(_mapController.camera.center, currentZoom - 1);
        },
        onRightButtonPressed: () {
          // Zoom in
          double currentZoom = _mapController.camera.zoom;
          _mapController.move(_mapController.camera.center, currentZoom + 1);
        },
      ),
    );
  }
}