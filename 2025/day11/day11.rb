# frozen_string_literal: true

require 'benchmark'

def count_paths(cache:, input:, cur:, exit:, v_dac:, v_fft:)
    return (v_dac && v_fft) ? 1 : 0 if cur == exit
    key = [cur, v_dac, v_fft]
    cache[key] ||= input.fetch(cur, []).sum do |neigh|
        count_paths(cache: cache, input: input, 
                    cur: neigh,
                    exit: exit,
                    v_dac: v_dac || neigh == "dac",
                    v_fft: v_fft || neigh == "fft")
    end
end

input = File.readlines(ARGV[0], chomp: true).to_h do |line|
      node, neigh = line.split(': ', 2)
      [node, neigh.split(' ')]
    end

time1=Benchmark.measure do
  puts count_paths(cache: {}, input: input, cur: "you", exit: "out", v_dac: true, v_fft: true)
end

time2=Benchmark.measure do
  puts count_paths(cache: {}, input: input, cur: "svr", exit: "out", v_dac: false, v_fft: false)
end

puts "Time1: #{time1.total}"
puts "Time2: #{time2.total}"
