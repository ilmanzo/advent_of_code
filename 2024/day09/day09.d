import std;

immutable int EMPTY = -9999;

void main ()
{
    auto input=readln.strip.map!(q{a-'0'}).array;
    input.part1.writeln;
    input.part2.writeln;
}

pure long checksum(const int[] disk) {
    ulong result = 0;
    foreach (i, x; disk) result += i * x;
    return result;
}

pure getValue(const int i) { return (i & 1) ? EMPTY : (i >> 1); }

pure ulong part1(const uint[] input) {
  int [] disk;
  foreach (int i, ref x; input) disk ~= i.getValue.repeat(x).array;
  int pos = 0;
  while (true)
  {
    for (;pos < disk.length && disk[pos] != EMPTY; pos++) { } // just to increment pos
    if (pos >= disk.length) break;
    swap (disk[pos], disk.back);
    disk.length -= 1;
  }
 return disk.checksum;
}

pure ulong part2(const uint[] input) {
	alias File = Tuple!(int, "id", int, "len");
	File [] disk;
	foreach (int i, ref x; input) disk ~= File (i.getValue, x);
  for (int i = disk.length.to !(int) - 1; i >= 0; i--) if (disk[i].id != EMPTY)
		foreach (j; 0..i) if (disk[j].id == EMPTY && disk[j].len >= disk[i].len)
		{
			disk[j].len -= disk[i].len;
			disk = disk[0..j] ~ disk[i] ~ disk[j..i] ~ File (EMPTY, disk[i].len) ~ disk[i + 1..$];
			i += 1;
			break;
		}
	int[] newdisk;
	foreach (f; disk) newdisk ~= f.id.repeat (f.len).array;
  return newdisk.checksum;
}