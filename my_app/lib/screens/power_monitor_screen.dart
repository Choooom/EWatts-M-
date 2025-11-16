import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/providers/readings/device_reading_provider.dart';
import 'package:my_app/services/readings/device_service.dart';

/// This is a ConsumerStatefulWidget to access Ref in initState/dispose
class PowerMonitorScreen extends ConsumerStatefulWidget {
  // Pass in the ID of the device to monitor
  final String deviceId;

  const PowerMonitorScreen({Key? key, required this.deviceId})
    : super(key: key);

  @override
  _PowerMonitorScreenState createState() => _PowerMonitorScreenState();
}

class _PowerMonitorScreenState extends ConsumerState<PowerMonitorScreen> {
  @override
  void initState() {
    super.initState();
    // Use ref.read to call the connect method from the service
    // We use Future.microtask to ensure the provider is ready
    Future.microtask(() {
      ref.read(deviceServiceProvider).connectWebSocket();
    });
  }

  @override
  void dispose() {
    // Disconnect when the screen is disposed
    ref.read(deviceServiceProvider).disconnectWebSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state provider to rebuild the UI on data changes
    final deviceState = ref.watch(deviceReadingProvider);

    // Read the service provider to call methods (like send command)
    final deviceService = ref.read(deviceServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Device: ${widget.deviceId}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: deviceState.isConnected ? Colors.green : Colors.red,
                  size: 12,
                ),
                const SizedBox(width: 8),
                Text(deviceState.connectionStatus),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildReadingsGrid(deviceState),
              const SizedBox(height: 24),
              _buildControlPanel(deviceState, (command) {
                // Call the service to send the command
                deviceService.sendControlCommand(widget.deviceId, command);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadingsGrid(DeviceReadingState state) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildReadingCard("Voltage", "${state.voltage} V", Icons.flash_on),
        _buildReadingCard("Current", "${state.current} A", Icons.power_input),
        _buildReadingCard("Power", "${state.power} W", Icons.power),
        _buildReadingCard(
          "Energy",
          "${state.energy} kWh",
          Icons.battery_charging_full,
        ),
      ],
    );
  }

  Widget _buildReadingCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28, color: Colors.blue[300]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel(
    DeviceReadingState state,
    void Function(String) onCommand,
  ) {
    // FIXED: Handle the "---" initial state properly
    // Treat "---" as unknown, so enable both buttons
    bool isCurrentlyOn = (state.ssrState == "ON");
    bool isCurrentlyOff = (state.ssrState == "OFF");
    bool isUnknown = (state.ssrState == "---");

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Device Control',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Current State: ${state.ssrState}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isCurrentlyOn
                    ? Colors.green[400]
                    : isCurrentlyOff
                    ? Colors.red[400]
                    : Colors.grey[400],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    // Enable if: OFF or unknown, Disable if: ON
                    onPressed: isCurrentlyOn ? null : () => onCommand("ON"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      disabledBackgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Turn ON',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    // Enable if: ON or unknown, Disable if: OFF
                    onPressed: isCurrentlyOff ? null : () => onCommand("OFF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      disabledBackgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Turn OFF',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
