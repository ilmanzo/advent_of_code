
def parse(data):
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
        return (data, int(t,2))
    else:
        ltid= data[0]
        data=data[1:]
        spv = []
        if ltid == '0':
            l = data[:15]
            data=data[15:]
            subpacketslen = int(l, 2)
            subpackets = data[:subpacketslen]
            while subpackets:
                s,x = parse(subpackets)
                subpackets=s
                spv.append(x)
            data=data[subpacketslen:]
        else:
            l = data[:11]
            data=data[11:]
            subpacketsqty = int(l, 2)
            for i in range(subpacketsqty):
                s,x=parse(data)
                data=s
                spv.append(x)
        if tid == 0:
            return (data, sum(spv))
        if tid == 1:
            p = 1
            for x in spv:
                p*=x
            return (data,p)
        if tid == 2:
            return (data, min(spv))
        if tid == 3:
            return (data, max(spv))
        if tid == 5:
            return (data, 1 if spv[0]>spv[1] else 0)
        if tid == 6:
            return (data, 1 if spv[0]<spv[1] else 0)
        if tid == 7:
            return (data, 1 if spv[0]==spv[1] else 0)
