print(sum(int("".join((lambda a:[a[0],a[-1]])(list(filter(lambda c:c.isdigit(),l)))))for l in open("1.in").read().splitlines()))
