require "test/unit"


def is_tls_p1(s)
    win_len=4
    hypernet = false
    window = []
    valid = false
    s.strip.each_char do |c|
        case c
            when '['
                hypernet = true
                window = []
            when ']'
                hypernet = false
                window = []
            else
                window.shift unless window.length < win_len
                window << c
                if window.length >= win_len && window[0] != window[1] && window[0] == window[3] && window[1]==window[2]
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

def is_tls_p2(s)
    win_len=3
    hypernet,valid = false,false
    window = []
    abas = Set.new
    babs = Set.new
    s.strip.each_char do |c|
      case c
      when '['
        hypernet = true
        window = []
      when ']'
        hypernet = false
        window = []
      else
        window.shift unless window.length < win_len
        window << c
        next unless window.length >= win_len && window[0] == window[2] && window[0] != window[1]
        add, check = hypernet ? [babs, abas] : [abas, babs]
        add << [window[1], window[0], window[1]]
        if check.include?(window)
          valid = true
          break
        end
      end
    end
    valid
end


input=File.read("input.txt")

part1=input.lines.count { |line| is_tls_p1(line) }
p "part1=#{part1}"

part2=input.lines.count { |line| is_tls_p2(line) }
p "part2=#{part2}"


class TestTLS_part1 < Test::Unit::TestCase
    def test_outside_brackets
        assert is_tls_p1("abba[mnop]qrst")
    end 

    def test_inside_brackets
        assert !is_tls_p1("abcd[bddb]xyyx")
    end

    def test_equal_chars
        assert !is_tls_p1("aaaa[qwer]tyui")
    end

    def test_within_string
        assert is_tls_p1("ioxxoj[asdfgh]zxcvbn")
    end
end

class TestSSL_part2 < Test::Unit::TestCase
    def test_aba_outside_brackets_and_bab_inside
        assert is_tls_p2("aba[bab]xyz")
    end

    def test_aba_outside_brackets_and_not_bab_inside
        assert !is_tls_p2("xyx[xyx]xyx")
    end

    def test_aaaa
        assert is_tls_p2("aaa[kek]eke")
    end 

    def test_within_larger_string
        assert is_tls_p2("zazbz[bzb]cdb")
    end
end


