require "digest"

input=File.read("input.txt")
(0..99999999).each do |n|
    hash=Digest::MD5.hexdigest input+n.to_s
    if hash.start_with? "00000"
      p hash
    end
end