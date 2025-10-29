// lib/screens/weather_debug_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/constants/api_config.dart';
import 'dart:convert';

import 'package:my_app/services/weather_forecasting/weather_service.dart';

class WeatherDebugScreen extends StatefulWidget {
  const WeatherDebugScreen({super.key});

  @override
  State<WeatherDebugScreen> createState() => _WeatherDebugScreenState();
}

class _WeatherDebugScreenState extends State<WeatherDebugScreen> {
  final _weatherService = WeatherService();
  String _status = 'Ready to test';
  bool _isLoading = false;
  String? _rawResponse;
  Map<String, dynamic>? _parsedData;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather API Debug'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configuration Info
            _buildSection(
              'Configuration',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Base URL', ApiConfig.baseUrl),
                  _buildInfoRow('Endpoint', ApiConfig.predictWeather),
                  _buildInfoRow(
                    'Full URL',
                    '${ApiConfig.baseUrl}${ApiConfig.predictWeather}',
                  ),
                  _buildInfoRow(
                    'Latitude',
                    ApiConfig.defaultLatitude.toString(),
                  ),
                  _buildInfoRow(
                    'Longitude',
                    ApiConfig.defaultLongitude.toString(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Test Buttons
            _buildSection(
              'Tests',
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _testHealthCheck,
                    icon: Icon(Icons.favorite),
                    label: Text('1. Test Health Check'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _testWeatherAPI,
                    icon: Icon(Icons.cloud),
                    label: Text('2. Test Weather API'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _testWithCurl,
                    icon: Icon(Icons.code),
                    label: Text('3. Copy cURL Command'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Status
            _buildSection(
              'Status',
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getStatusColor()),
                ),
                child: Row(
                  children: [
                    if (_isLoading)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Icon(_getStatusIcon(), color: _getStatusColor()),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _status,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Error Display
            if (_error != null)
              _buildSection(
                'Error Details',
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: SelectableText(
                    _error!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.red[900],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20),

            // Raw Response
            if (_rawResponse != null)
              _buildSection(
                'Raw Response',
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Response received!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.copy, size: 20),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: _rawResponse!),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Copied to clipboard')),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            _rawResponse!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 20),

            // Parsed Data
            if (_parsedData != null)
              _buildSection(
                'Parsed Data Summary',
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        'Model Used',
                        _parsedData!['model_used'] ?? 'N/A',
                      ),
                      _buildInfoRow(
                        'Generated At',
                        _parsedData!['generated_at'] ?? 'N/A',
                      ),
                      _buildInfoRow(
                        'Predictions Count',
                        (_parsedData!['predictions'] as List?)?.length
                                .toString() ??
                            '0',
                      ),
                      if ((_parsedData!['predictions'] as List?)?.isNotEmpty ??
                          false) ...[
                        SizedBox(height: 8),
                        Text(
                          'First Prediction:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        _buildInfoRow(
                          'Date',
                          _parsedData!['predictions'][0]['forecast_date'] ??
                              'N/A',
                        ),
                        _buildInfoRow(
                          'Temperature',
                          _parsedData!['predictions'][0]['weather_condition']?['temperature']
                                  ?.toString() ??
                              'N/A',
                        ),
                      ],
                    ],
                  ),
                ),
              ),

            SizedBox(height: 40),

            // Troubleshooting Tips
            _buildSection(
              'Troubleshooting Tips',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTip('1. Make sure your FastAPI backend is running'),
                  _buildTip('2. Check the Base URL matches your setup'),
                  _buildTip(
                    '3. For Android emulator, use http://10.0.2.2:8000',
                  ),
                  _buildTip('4. For physical device, use your computer\'s IP'),
                  _buildTip('5. Check firewall isn\'t blocking port 8000'),
                  _buildTip(
                    '6. Try the cURL command in terminal to verify backend',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(child: Text(tip, style: TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    if (_isLoading) return Colors.blue;
    if (_error != null) return Colors.red;
    if (_rawResponse != null) return Colors.green;
    return Colors.grey;
  }

  IconData _getStatusIcon() {
    if (_error != null) return Icons.error;
    if (_rawResponse != null) return Icons.check_circle;
    return Icons.info;
  }

  Future<void> _testHealthCheck() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing health endpoint...';
      _error = null;
      _rawResponse = null;
      _parsedData = null;
    });

    try {
      final isHealthy = await _weatherService.checkHealth();

      setState(() {
        _isLoading = false;
        if (isHealthy) {
          _status = '✅ Backend is healthy and reachable!';
          _rawResponse = 'Health check passed';
        } else {
          _status = '❌ Backend returned unhealthy status';
          _error = 'Health check failed - backend may not be running correctly';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ Health check failed';
        _error =
            'Error: $e\n\nMake sure:\n'
            '1. Backend is running\n'
            '2. Base URL is correct (${ApiConfig.baseUrl})\n'
            '3. You can reach the backend from your device';
      });
    }
  }

  Future<void> _testWeatherAPI() async {
    setState(() {
      _isLoading = true;
      _status = 'Fetching weather forecast...';
      _error = null;
      _rawResponse = null;
      _parsedData = null;
    });

    try {
      final response = await _weatherService.getWeatherForecast(
        latitude: ApiConfig.defaultLatitude,
        longitude: ApiConfig.defaultLongitude,
      );

      // Convert response to JSON string for display
      final jsonString = JsonEncoder.withIndent('  ').convert({
        'model_used': response.modelUsed,
        'generated_at': response.generatedAt,
        'predictions_count': response.predictions.length,
        'first_prediction': response.predictions.isNotEmpty
            ? {
                'forecast_date': response.predictions[0].forecastDate,
                'temperature':
                    response.predictions[0].weatherCondition.temperature,
                'cloud_description':
                    response.predictions[0].weatherCondition.cloudDescription,
                'solar_irradiance':
                    response.predictions[0].solarConditions.solarIrradiance,
              }
            : null,
      });

      setState(() {
        _isLoading = false;
        _status = '✅ Weather data received successfully!';
        _rawResponse = jsonString;
        _parsedData = {
          'model_used': response.modelUsed,
          'generated_at': response.generatedAt,
          'predictions': response.predictions
              .map(
                (p) => {
                  'forecast_date': p.forecastDate,
                  'weather_condition': {
                    'temperature': p.weatherCondition.temperature,
                  },
                },
              )
              .toList(),
        };
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✅ Success! Got ${response.predictions.length} predictions',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ Weather API failed';
        _error =
            'Error: $e\n\n'
            'Full error details:\n${e.toString()}\n\n'
            'Endpoint: ${ApiConfig.baseUrl}${ApiConfig.predictWeather}\n'
            'Payload: {"latitude": ${ApiConfig.defaultLatitude}, "longitude": ${ApiConfig.defaultLongitude}}';
      });
    }
  }

  Future<void> _testWithCurl() async {
    final curlCommand =
        '''
curl -X POST "${ApiConfig.baseUrl}${ApiConfig.predictWeather}" \\
  -H "Content-Type: application/json" \\
  -d '{
    "latitude": ${ApiConfig.defaultLatitude},
    "longitude": ${ApiConfig.defaultLongitude}
  }'
''';

    await Clipboard.setData(ClipboardData(text: curlCommand));

    setState(() {
      _status = '📋 cURL command copied to clipboard';
      _rawResponse =
          'Run this command in your terminal:\n\n$curlCommand\n\n'
          'This will test if your backend is working correctly.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('cURL command copied! Paste in terminal to test'),
        duration: Duration(seconds: 4),
      ),
    );
  }
}
