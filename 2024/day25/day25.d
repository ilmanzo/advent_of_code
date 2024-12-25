import std;

pure bool good(const string[] lock, const string[] key)
{
        foreach (i; 0..lock.length)
                foreach (j; 0..lock.front.length)
                        if (lock[i][j] == '#' && key[i][j] == '#')
                                return false;
        return true;
}

void main ()
{
        auto input = stdin.byLineCopy.array.split("");
        auto locks = input.filter!(s => s.front.all!("a == '#'"));
        auto keys = input.filter!(s => s.back.all!("a == '#'"));
        auto part1 = 0;
        foreach (l; locks) foreach (k; keys) if (good(l,k)) part1++;
        part1.writeln;
}
