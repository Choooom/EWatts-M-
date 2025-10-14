# API Request Examples

This document contains example API requests using curl. Replace placeholders with your actual values.

## Prerequisites

```bash
# Set your JWT token (get from auth service login)
export JWT_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# Set your API Gateway URL
export API_URL="http://localhost:8080"
```

## Admin Endpoints

### 1. Create Device (ADMIN only)

```bash
curl -X POST "${API_URL}/api/admin/devices" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{
    "deviceName": "Living Room Air Conditioner",
    "esp32Id": "ESP32_AC001",
    "deviceType": "APPLIANCE",
    "userId": 2,
    "userEmail": "john.doe@example.com",
    "description": "Samsung 2.5HP split-type AC",
    "location": "Living Room",
    "installationNotes": "Installed on August 2024",
    "voltageCalibration": 83.3,
    "currentCalibration": 0.50
  }'
```

Response:
```json
{
  "success": true,
  "message": "Device created successfully",
  "data": {
    "id": 1,
    "deviceName": "Living Room Air Conditioner",
    "esp32Id": "ESP32_AC001",
    "deviceToken": "DEV_a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
    "deviceType": "APPLIANCE",
    "userId": 2,
    "ssrEnabled": true,
    "active": true,
    "online": false
  }
}
```

### 2. Get All Devices (ADMIN)

```bash
curl -X GET "${API_URL}/api/admin/devices" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 3. Get Specific Device (ADMIN)

```bash
curl -X GET "${API_URL}/api/admin/devices/1" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 4. Update Device (ADMIN)

```bash
curl -X PUT "${API_URL}/api/admin/devices/1" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{
    "deviceName": "Living Room AC (Updated)",
    "description": "Samsung 2.5HP split-type AC - Updated",
    "voltageCalibration": 85.0,
    "active": true
  }'
```

### 5. Delete Device (ADMIN)

```bash
curl -X DELETE "${API_URL}/api/admin/devices/1" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 6. Regenerate Device Token (ADMIN)

```bash
curl -X POST "${API_URL}/api/admin/devices/1/regenerate-token" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 7. Get User's Devices (ADMIN)

```bash
curl -X GET "${API_URL}/api/admin/devices/user/2" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

## User Device Endpoints

### 1. Get My Devices

```bash
curl -X GET "${API_URL}/api/devices/my-devices" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 2. Get Device Details

```bash
curl -X GET "${API_URL}/api/devices/1" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 3. Control SSR (Turn OFF)

```bash
curl -X POST "${API_URL}/api/devices/1/ssr-control" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{
    "enabled": false
  }'
```

Response:
```json
{
  "success": true,
  "message": "Device turned OFF",
  "data": null
}
```

### 4. Control SSR (Turn ON)

```bash
curl -X POST "${API_URL}/api/devices/1/ssr-control" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{
    "enabled": true
  }'
```

### 5. Get SSR Status

```bash
curl -X GET "${API_URL}/api/devices/1/ssr-status" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

## Reading Endpoints

### 1. Get Device Readings (Paginated)

```bash
curl -X GET "${API_URL}/api/readings/device/1?page=0&size=20" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 2. Get Latest Reading

```bash
curl -X GET "${API_URL}/api/readings/device/1/latest" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

Response:
```json
{
  "success": true,
  "message": "Success",
  "data": {
    "id": 12345,
    "deviceId": 1,
    "deviceName": "Living Room AC",
    "deviceType": "APPLIANCE",
    "voltage": 220.5,
    "current": 5.234,
    "power": 1154.07,
    "energy": 2.45678,
    "timestamp": "2024-12-05T14:30:25"
  }
}
```

### 3. Get Readings by Date Range

```bash
curl -X GET "${API_URL}/api/readings/device/1/range?start=2024-12-01T00:00:00&end=2024-12-05T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 4. Get All My Readings

```bash
curl -X GET "${API_URL}/api/readings/my-readings?page=0&size=50" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

## Analytics Endpoints

### 1. Get Hourly Analytics

```bash
curl -X GET "${API_URL}/api/analytics/hourly?startDate=2024-12-05T00:00:00&endDate=2024-12-05T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

Response:
```json
{
  "success": true,
  "message": "Success",
  "data": {
    "data": [
      {
        "id": 1,
        "deviceId": 1,
        "deviceName": "Living Room AC",
        "aggregationType": "HOURLY",
        "periodStart": "2024-12-05T14:00:00",
        "periodEnd": "2024-12-05T15:00:00",
        "avgVoltage": 220.3,
        "maxVoltage": 222.1,
        "minVoltage": 218.5,
        "avgCurrent": 5.12,
        "maxCurrent": 6.45,
        "minCurrent": 4.23,
        "avgPower": 1128.34,
        "maxPower": 1432.45,
        "minPower": 925.15,
        "totalEnergyConsumed": 1.128,
        "readingCount": 720
      }
    ],
    "totalEnergyConsumed": 12.567,
    "avgPower": 1045.23,
    "totalReadings": 17280
  }
}
```

### 2. Get Daily Analytics

```bash
curl -X GET "${API_URL}/api/analytics/daily?startDate=2024-12-01T00:00:00&endDate=2024-12-05T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 3. Get Monthly Analytics

```bash
curl -X GET "${API_URL}/api/analytics/monthly?startDate=2024-01-01T00:00:00&endDate=2024-12-31T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 4. Get Yearly Analytics

```bash
curl -X GET "${API_URL}/api/analytics/yearly?startDate=2023-01-01T00:00:00&endDate=2024-12-31T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 5. Get Analytics for Specific Device

```bash
curl -X GET "${API_URL}/api/analytics/daily?startDate=2024-12-01T00:00:00&endDate=2024-12-05T23:59:59&deviceId=1" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

### 6. Get General Analytics with Custom Type

```bash
curl -X GET "${API_URL}/api/analytics?type=MONTHLY&startDate=2024-01-01T00:00:00&endDate=2024-12-31T23:59:59&deviceId=1" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

## Testing MQTT

### Subscribe to All Readings

```bash
docker exec -it mqtt-broker mosquitto_sub \
  -h localhost \
  -t "electrical/readings/#" \
  -u mqtt_service \
  -P mqtt_service_password
```

### Subscribe to Specific Device

```bash
docker exec -it mqtt-broker mosquitto_sub \
  -h localhost \
  -t "electrical/readings/ESP32_AC001" \
  -u mqtt_service \
  -P mqtt_service_password
```

### Publish Test Message (Simulate ESP32)

```bash
docker exec -it mqtt-broker mosquitto_pub \
  -h localhost \
  -t "electrical/readings/ESP32_AC001" \
  -u mqtt_service \
  -P mqtt_service_password \
  -m '{"deviceToken":"DEV_a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6","voltage":220.5,"current":5.234,"power":1154.07,"energy":2.45678,"timestamp":1701785425000}'
```

### Send SSR Control Command

```bash
docker exec -it mqtt-broker mosquitto_pub \
  -h localhost \
  -t "electrical/control/ESP32_AC001" \
  -u mqtt_service \
  -P mqtt_service_password \
  -m "OFF"
```

## Complete Workflow Example

### Scenario: Add a new refrigerator device and monitor it

#### Step 1: Admin creates device

```bash
curl -X POST "${API_URL}/api/admin/devices" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{
    "deviceName": "Kitchen Refrigerator",
    "esp32Id": "ESP32_FRIDGE_001",
    "deviceType": "APPLIANCE",
    "userId": 3,
    "userEmail": "jane.smith@example.com",
    "description": "LG Double Door Refrigerator",
    "location": "Kitchen",
    "voltageCalibration": 83.3,
    "currentCalibration": 0.50
  }'
```

Save the `deviceToken` from the response: `DEV_xyz123abc456...`

#### Step 2: Configure ESP32 with device token

Edit your ESP32 code:
```cpp
const char* device_token = "DEV_xyz123abc456...";
const char* esp32_id = "ESP32_FRIDGE_001";
```

Upload to ESP32.

#### Step 3: Verify ESP32 is sending data

```bash
# Monitor MQTT messages
docker exec -it mqtt-broker mosquitto_sub \
  -h localhost \
  -t "electrical/readings/ESP32_FRIDGE_001" \
  -u mqtt_service \
  -P mqtt_service_password
```

You should see messages every 5 seconds.

#### Step 4: Check latest reading via API

```bash
curl -X GET "${API_URL}/api/readings/device/2/latest" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

#### Step 5: Turn off refrigerator

```bash
curl -X POST "${API_URL}/api/devices/2/ssr-control" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  -d '{"enabled": false}'
```

ESP32 should turn off SSR immediately.

#### Step 6: Get daily energy consumption

```bash
curl -X GET "${API_URL}/api/analytics/daily?startDate=2024-12-01T00:00:00&endDate=2024-12-05T23:59:59&deviceId=2" \
  -H "Authorization: Bearer ${JWT_TOKEN}"
```

## WebSocket Testing (using wscat)

### Install wscat

```bash
npm install -g wscat
```

### Connect to WebSocket

```bash
wscat -c "ws://localhost:8080/ws"
```

### Send CONNECT frame

```
CONNECT
accept-version:1.0,1.1,2.0
heart-beat:10000,10000

^@
```

### Subscribe to readings

```
SUBSCRIBE
id:sub-0
destination:/topic/user/3/readings

^@
```

### Subscribe to SSR control

```
SUBSCRIBE
id:sub-1
destination:/topic/user/3/ssr-control

^@
```

You'll receive messages in real-time as the ESP32 sends readings or when SSR state changes.

## Postman Collection

You can import these requests into Postman:

1. Create a new collection: "Electrical Readings API"
2. Add environment variables:
   - `API_URL`: `http://localhost:8080`
   - `JWT_TOKEN`: Your JWT token from auth service
3. Import the curl commands above as requests
4. Use `{{API_URL}}` and `{{JWT_TOKEN}}` in requests

## Common Error Responses

### 401 Unauthorized

```json
{
  "success": false,
  "message": "Unauthorized",
  "data": null
}
```

Solution: Check if JWT token is valid and not expired.

### 403 Forbidden

```json
{
  "success": false,
  "message": "Access denied",
  "data": null
}
```

Solution: User doesn't own this device or lacks ADMIN role.

### 404 Not Found

```json
{
  "success": false,
  "message": "Device not found",
  "data": null
}
```

Solution: Device ID doesn't exist.

### 400 Bad Request

```json
{
  "success": false,
  "message": "Validation failed",
  "data": null
}
```

Solution: Check request body for missing or invalid fields.

## Rate Limiting Considerations

For production, consider implementing rate limiting:
- Max 100 requests per minute per user for regular endpoints
- Max 10 requests per minute for SSR control
- WebSocket connections: Max 5 concurrent connections per user

## Monitoring Tips

### Check device online status

```bash
curl -X GET "${API_URL}/api/devices/my-devices" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  | jq '.data[] | {name: .deviceName, online: .online, lastSeen: .lastSeenAt}'
```

### Get total energy consumption for today

```bash
TODAY=$(date +%Y-%m-%d)
curl -X GET "${API_URL}/api/analytics/hourly?startDate=${TODAY}T00:00:00&endDate=${TODAY}T23:59:59" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  | jq '.data.totalEnergyConsumed'
```

### List all devices with their current power consumption

```bash
curl -X GET "${API_URL}/api/devices/my-devices" \
  -H "Authorization: Bearer ${JWT_TOKEN}" \
  | jq '.data[] | .id' \
  | while read device_id; do
      curl -s -X GET "${API_URL}/api/readings/device/${device_id}/latest" \
        -H "Authorization: Bearer ${JWT_TOKEN}" \
        | jq '{device: .data.deviceName, power: .data.power, unit: "W"}'
    done
```
