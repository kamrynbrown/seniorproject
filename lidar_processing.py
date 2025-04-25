class LidarProcessor:
    def __init__(self, lidar_data):
        self.lidar_data = lidar_data

    def get_nearest_obstacle(self):
        """
        Return the closest detected distance from LIDAR
        """
        return min(self.lidar_data)

    def is_clear_path(self, threshold=1.0):
        """
        Determine if all LIDAR points are beyond threshold
        """
        return all(d > threshold for d in self.lidar_data)
