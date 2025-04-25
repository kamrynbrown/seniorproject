import heapq

class PathPlanner:
    def __init__(self, graph):
        self.graph = graph

    def dijkstra(self, start, goal):
        queue = [(0, start)]
        distances = {node: float('inf') for node in self.graph}
        distances[start] = 0
        previous = {node: None for node in self.graph}

        while queue:
            current_distance, current_node = heapq.heappop(queue)

            if current_node == goal:
                break

            for neighbor, weight in self.graph[current_node]:
                distance = current_distance + weight
                if distance < distances[neighbor]:
                    distances[neighbor] = distance
                    previous[neighbor] = current_node
                    heapq.heappush(queue, (distance, neighbor))

        path, node = [], goal
        while node is not None:
            path.insert(0, node)
            node = previous[node]

        return path
