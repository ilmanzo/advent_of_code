class Integer
    alias_method :add, :+
    alias_method :mult, :*
end


input=File.readlines("input.txt")
puts input.sum { |expr| eval expr.reverse.gsub('+', '.add').gsub('*', '.mult').tr('()', ')(') }
