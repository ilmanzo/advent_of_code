
sumofversions=0
def parse(data):
    global sumofversions
    version = int(data[:3],2)
    sumofversions+=version
    data=data[3:]

    tid = int(data[:3],2)
    data=data[3:]
    if tid == 4:
        t = ""
        while True:
            t += data[1:5]
            cnt = data[0]
            data=data[5:]
            if cnt == '0':
                break
    else:
        ltid= data[0]
        data=data[1:]
        if ltid == '0':
            l = data[:15]
            data=data[15:]
            subpacketslen = int(l, 2)
            subpackets = data[:subpacketslen]
            while subpackets:
                subpackets = parse(subpackets)
            data=data[subpacketslen:]
        else:
            l = data[:11]
            data=data[11:]
            subpacketsqty = int(l, 2)
            for i in range(subpacketsqty):
                data=parse(data)
    return data


