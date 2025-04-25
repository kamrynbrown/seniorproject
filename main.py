from navigation.obstacle_avoidance import ObstacleAvoidance
from navigation.path_planning import PathPlanner
from navigation.stair_navigation import StairNavigator
from navigation.terrain_handling import TerrainHandler
from perception.camera_processing import CameraProcessor
from perception.lidar_processing import LidarProcessor
from phone_integration.phone_navigation import PhoneNavigator


def main():
    # Simulated data
    lidar_data = [1.2, 0.8, 1.5, 0.6]  # example in meters
    imu_data = {'accel_z': 10.2}
    gyro_data = {'x': 0.2, 'y': 0.1, 'z': 3.5}
    graph = {
        'A': [('B', 1), ('C', 4)],
        'B': [('C', 2), ('D', 5)],
        'C': [('D', 1)],
        'D': []
    }

    # Initialize modules
    lidar_proc = LidarProcessor(lidar_data)
    obstacle_avoid = ObstacleAvoidance(lidar_data)
    stair_nav = StairNavigator(imu_data)
    terrain_handle = TerrainHandler(gyro_data)
    path_plan = PathPlanner(graph)
    cam_proc = CameraProcessor()
    phone_nav = PhoneNavigator()

    # Connect to phone and set destination
    phone_nav.connect_to_phone()
    print(phone_nav.send_destination("Building B"))

    # Detect obstacle and stairs
    if obstacle_avoid.is_obstacle_ahead():
        print("Obstacle ahead!")

    if stair_nav.detect_stairs():
        print("Stairs detected!")

    print("Terrain type:", terrain_handle.classify_terrain())
    print("Shortest path from A to D:", path_plan.dijkstra('A', 'D'))

    # Detect visual cues
    print("Camera sees:", cam_proc.detect_objects())
    print("Nearest obstacle (LIDAR):", lidar_proc.get_nearest_obstacle())


if __name__ == "__main__":
    main()