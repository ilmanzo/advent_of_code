def getfrequency(str)
    letters=Hash.new(0)
    str.each_char.reduce(letters) { |h, c| h[c] += 1; h}
end

def one_letter_apart?(s1, s2)
    return false if s1.length != s2.length
    diff=0
    s1.chars.each_with_index do |c,i|
        diff+=1 if s2[i]!=c 
        return false if diff>1
    end
    true
end


input=File.read("input.txt").lines
freqs=input.map{|l| getfrequency(l)}
doubles=freqs.select{|f| f.values.count(2)>=1}.count
triples=freqs.select{|f| f.values.count(3)>=1}.count
p "part1=#{doubles*triples}"

# quadratic ... :( 
input.each do |a|
  input.each do |b|
    if a!=b and one_letter_apart?(a,b) then
        puts a,b 
        puts
    end
  end
end



