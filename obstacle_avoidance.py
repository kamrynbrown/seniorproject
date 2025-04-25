class ObstacleAvoidance:
    def __init__(self, lidar_ranges):
        self.lidar_ranges = lidar_ranges

    def is_obstacle_ahead(self, threshold=0.5):
        """
        Checks if any LIDAR readings are below the given threshold.
        :param threshold: Distance in meters considered as too close
        :return: True if obstacle detected, False otherwise
        """
        return any(distance < threshold for distance in self.lidar_ranges)