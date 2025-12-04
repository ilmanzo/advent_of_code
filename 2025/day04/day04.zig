const std = @import("std");

pub const input = @embedFile("input.txt");

const Point = struct {
    x: i32,
    y: i32,

    pub fn add(self: Point, other: Point) Point {
        return Point{ .x = self.x + other.x, .y = self.y + other.y };
    }

    pub fn eql(self: Point, other: Point) bool {
        return self.x == other.x and self.y == other.y;
    }
};

const dir8 = [_]Point{
    .{ .x = 0, .y = -1 },
    .{ .x = 1, .y = -1 },
    .{ .x = 1, .y = 0 },
    .{ .x = 1, .y = 1 },
    .{ .x = 0, .y = 1 },
    .{ .x = -1, .y = 1 },
    .{ .x = -1, .y = 0 },
    .{ .x = -1, .y = -1 },
};

const PointSet = std.AutoArrayHashMap(Point, void);

pub fn removePaper(allocator: std.mem.Allocator, paper: *PointSet) !usize {
    var removable = try std.ArrayList(Point).initCapacity(allocator, 512);
    defer removable.deinit(allocator);

    var it = paper.iterator();
    while (it.next()) |e| {
        const p = e.key_ptr.*;

        var cnt: u8 = 0;
        for (dir8) |d| {
            cnt += @intFromBool(paper.contains(p.add(d)));
        }

        if (cnt < 4) try removable.append(allocator, p);
    }

    for (removable.items) |p| _ = paper.swapRemove(p);

    return removable.items.len;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var paper = PointSet.init(allocator);
    defer paper.deinit();

    // parse input
    var y: i32 = 0;
    var line_iterator = std.mem.splitScalar(u8, input, '\n');
    while (line_iterator.next()) |line| : (y += 1) {
        for (line, 0..) |c, i| {
            if (c == '@') {
                try paper.put(Point{ .x = @intCast(i), .y = y }, {});
            }
        }
    }

    const part1 = removePaper(allocator, &paper);
    std.debug.print("part1: {!}\n", .{part1});

    var part2: usize = try part1;
    while (true) {
        const r = try removePaper(allocator, &paper);
        if (r == 0) break;
        part2 += r;
    }

    std.debug.print("part2: {d}\n", .{part2});
}
