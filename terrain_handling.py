
class TerrainHandler:
    def __init__(self, gyro_data):
        self.gyro_data = gyro_data

    def classify_terrain(self):
        """
        Use gyro variations to identify rough terrain.
        :return: 'rough' or 'smooth'
        """
        variance = sum(abs(g) for g in self.gyro_data.values())
        return "rough" if variance > 3 else "smooth"