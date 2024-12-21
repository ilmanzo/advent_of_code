require 'matrix'

V=Vector

class Day21
    def initialize(codes)
        @codes=codes
        @memo={} # we need this later
    end

    def solve(limit)
        @codes.map{|c| min_len(c, limit) * (c[0..2].to_i)}.sum
    end

    POS = {'0' => V[3, 1], '1' => V[2, 0], '2' => V[2, 1], '3' => V[2, 2], 
        '4' => V[1, 0], '5' => V[1, 1], '6' => V[1, 2], '7' => V[0, 0],
        '8' => V[0, 1], '9' => V[0, 2], 'A' => V[3, 2], '^' => V[0, 1],
        'a' => V[0, 2], '<' => V[1, 0], 'v' => V[1, 1], '>' => V[1, 2] }.freeze
    DIR = {'^' => V[-1, 0], 'v' => V[1, 0], '<' => V[0, -1], '>' => V[0, 1] }.freeze

    def min_len(str, limit=2, depth=0)
        key = [str, depth, limit]
        return @memo[key] if @memo[key]
        avoid = depth == 0 ? V[3, 0] : V[0, 0]
        c = depth==0 ? POS['A'] : POS['a']
        ml=str.chars.map do |char|
            c1 = POS[char]
            moves = get_moves c, c1, avoid
            c = c1
            depth==limit ? (moves[0] || 'a').size : (moves.map{|m| min_len(m, limit, depth + 1)}.min)
        end.sum
        @memo[key]=ml
        ml
    end

    def get_moves(from, to, avoid=V[0, 0])
        d = to-from
        dy,dx = d[0],d[1]
        arrows = dx>0?('>'*dx):('<'*-dx)
        arrows +=dy>0?('v'*dy):('^'*-dy)
        moves = arrows.chars.permutation.to_a.uniq.filter{|s|!s.map{DIR[_1]}.reduce([from]){_1+[_1.last+_2]}.any?{_1==avoid}}.map{_1.join+'a'}
        moves = ['a'] if moves.empty?
        moves
    end

    private :min_len,:get_moves
end