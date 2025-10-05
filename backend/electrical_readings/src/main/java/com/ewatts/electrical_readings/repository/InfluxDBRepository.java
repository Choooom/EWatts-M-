package com.ewatts.electrical_readings.repository;

import com.influxdb.client.InfluxDBClient;
import com.influxdb.client.WriteApiBlocking;
import com.influxdb.client.domain.WritePrecision;
import com.influxdb.client.write.Point;
import com.ewatts.electrical_readings.dto.ElectricalReadingDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import java.time.Instant;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class InfluxDBRepository {

    private final InfluxDBClient influxDBClient;

    @Value("${influxdb.bucket}")
    private String bucket;

    public void saveReading(ElectricalReadingDto reading) {
        WriteApiBlocking writeApi = influxDBClient.getWriteApiBlocking();

        Point point = Point
                .measurement("electrical_readings")
                .addTag("device_id", reading.getDeviceId())
                .addTag("location", reading.getLocation())
                .addField("voltage", reading.getVoltage())
                .addField("current", reading.getCurrent())
                .addField("power", reading.getPower())
                .addField("energy", reading.getEnergy())
                .time(Instant.now(), WritePrecision.NS);

        writeApi.writePoint(bucket, "your-org", point);
    }

    public void saveBatchReadings(List<ElectricalReadingDto> readings) {
        WriteApiBlocking writeApi = influxDBClient.getWriteApiBlocking();

        List<Point> points = readings.stream()
                .map(reading -> Point
                        .measurement("electrical_readings")
                        .addTag("device_id", reading.getDeviceId())
                        .addTag("location", reading.getLocation())
                        .addField("voltage", reading.getVoltage())
                        .addField("current", reading.getCurrent())
                        .addField("power", reading.getPower())
                        .addField("energy", reading.getEnergy())
                        .time(Instant.now(), WritePrecision.NS))
                .toList();

        writeApi.writePoints(bucket, "your-org", points);
    }
}
