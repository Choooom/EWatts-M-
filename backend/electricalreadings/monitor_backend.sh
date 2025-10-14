#!/bin/bash

echo "==================================="
echo "Backend Monitoring Script"
echo "==================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if backend is running
echo "1. Checking backend service..."
if curl -s http://localhost:8083/actuator/health > /dev/null; then
    echo -e "${GREEN}✓ Backend is running${NC}"
else
    echo -e "${RED}✗ Backend is NOT running${NC}"
    exit 1
fi

# Check database connection
echo ""
echo "2. Checking database..."
READING_COUNT=$(psql -U postgres -d electrical_readings_db -t -c "SELECT COUNT(*) FROM electrical_readings;" 2>/dev/null)
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Database connected${NC}"
    echo "   Total readings: $READING_COUNT"
else
    echo -e "${RED}✗ Database connection failed${NC}"
fi

# Check latest reading
echo ""
echo "3. Latest reading from database:"
psql -U postgres -d electrical_readings_db -c "
SELECT 
    device_id,
    voltage,
    current,
    power,
    timestamp
FROM electrical_readings
ORDER BY timestamp DESC
LIMIT 1;
"

# Check device status
echo ""
echo "4. Device status:"
psql -U postgres -d electrical_readings_db -c "
SELECT 
    device_name,
    online,
    last_seen_at
FROM electrical_devices;
"

echo ""
echo "==================================="
echo "Monitoring complete!"
echo "==================================="