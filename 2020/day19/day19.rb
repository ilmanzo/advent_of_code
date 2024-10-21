# frozen_string_literal: true

def part1(input)
    p input.lines.grep(/\A#{build_re(0)}\Z/).count
end

def build_re(n)
    "(?:rules[n].map { |seq| seq.map { build_re _1 }.join }.join('|')})"
end

def init_rules(rule_data)
    rules = []
    rule_data.lines.each do |line|
    index, definition = line.strip.split(': ')
    rules[index.to_i] =
        if definition.include?('"')
            [definition.tr('"', '')]
         else
            definition.split(' | ').map { _1.scan(/\d+/).map(&:to_i) }
        end
    end
    rules
end

rule_data, input = File.readlines("input.txt").split("\n\n")

rules=init_rules(rule_data)
part1(input)
