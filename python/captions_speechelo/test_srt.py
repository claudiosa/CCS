import pysrt
all_file = pysrt.open("input.txt")

for sub in all_file:
#    print(sub.start.seconds)
    print(sub.start)
    print(sub.end)
    print(sub.end - sub.start)
    print(sub.text)
    print()
