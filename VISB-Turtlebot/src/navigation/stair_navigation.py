
class StairNavigator:
    def __init__(self, imu_data):
        self.imu_data = imu_data

    def detect_stairs(self):
        """
        Very basic example using IMU z-axis acceleration to infer stairs.
        :return: True if stairs likely detected
        """
        threshold = 9.5  # example threshold for z-axis acceleration
        return abs(self.imu_data['accel_z']) > threshold
