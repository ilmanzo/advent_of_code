class Cuboid:
    def __init__(self, bounds) -> None:
        self.bounds = bounds
        self.vacuums = []

    def intersect_ranges(self,r11, r12, r21, r22):
        assert r12 >= r11 and r22 >= r21
        if r21 > r12 or r11 > r22:
            return None
        nums = sorted([r11, r12, r21, r22])
        return [nums[1], nums[2]]

    def intersect_bounds(self,bounds1, bounds2):
        x11, x12, y11, y12, z11, z12 = bounds1
        x21, x22, y21, y22, z21, z22 = bounds2
        X = self.intersect_ranges(x11, x12, x21, x22)
        Y = self.intersect_ranges(y11, y12, y21, y22)
        Z = self.intersect_ranges(z11, z12, z21, z22)
        if not all((X, Y, Z)):
            return None
        return X + Y + Z

    def remove(self, bounds):
        shaved_bounds = self.intersect_bounds(self.bounds, bounds)
        if not shaved_bounds:
            return
        for vacuum in self.vacuums:
            vacuum.remove(shaved_bounds)
        self.vacuums.append(Cuboid(shaved_bounds))

    def count_cubes(self):
        x1, x2, y1, y2, z1, z2 = self.bounds
        return (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1) - sum(vacuum.count_cubes() for vacuum in self.vacuums)
