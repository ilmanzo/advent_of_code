require "test/unit"

WIN_LEN=4
  
def is_tls(s)
    hypernet = false
    window = []
    valid = false
    s.each_char do |c|
        case c
            when '['
                hypernet = true
                window = []
            when ']'
                hypernet = false
                window = []
            else
                window.shift unless window.length < WIN_LEN
                window << c
                if window.length >= WIN_LEN && window[0] != window[1] && window[0] == window[3] && window[1]==window[2]
                    if hypernet
                        valid = false
                        break
                    else
                        valid = true
                    end
                end
        end
    end
    valid
end


input=File.read("input.txt")

# input.lines.each do |line|
#     l=line.strip
#     p "l=#{l} #{is_tls(l)}"
# end

part1=input.lines.count { |line| is_tls(line.strip) }
p "part1=#{part1}"





class TestTLS < Test::Unit::TestCase
    def test_outside_brackets
        assert is_tls("abba[mnop]qrst")
    end 

    def test_inside_brackets
        assert !is_tls("abcd[bddb]xyyx")
    end

    def test_equal_chars
        assert !is_tls("aaaa[qwer]tyui")
    end

    def test_within_string
        assert is_tls("ioxxoj[asdfgh]zxcvbn")
    end
end

