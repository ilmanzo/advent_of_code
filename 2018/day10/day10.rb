require 'set'

pos_and_vels = (ARGV.empty? ? DATA : ARGF).each_line.map { |l|
  l.scan(/-?\d+/).map(&:to_i).freeze
}.freeze

prev_points = nil
prev_yrange = 1.0 / 0.0

puts 0.step { |t|
  points = pos_and_vels.map { |a, b, c, d| [a + c * t, b + d * t] }

  ymin, ymax = points.map(&:last).minmax
  yrange = ymax - ymin

  if yrange > prev_yrange
    ymin, ymax = prev_points.map(&:last).minmax
    xmin, xmax = prev_points.map(&:first).minmax
    prev_points = Set.new(prev_points)

    (ymin..ymax).each { |y|
      (xmin..xmax).each { |x|
        print prev_points.include?([x, y]) ? ?# : ' '
      }
      puts
    }

    puts
    break t - 1
  end

  prev_points = points
  prev_yrange = ymax - ymin
}
