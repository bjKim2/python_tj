# Before

total1 = 0

for i in range(0,100000000):
    total1 += i
print(total1)

# 14 초 

# After
from threading import Thread
def calc(start, end):
    total = 0
    for i in range(start, end):
        total += i
    print(total)

if __name__ == "__main__":
    start, end = 0, 100000000
    thr1 = Thread(target =calc, args= (start,end))

    thr1.start()
    thr1.join()

#14초 에서 7.43로 줄음 

# MultiThread 는 한 문제를 나눠서 연산 (cpu 쓰레드 수인듯)
# MultiProcess 는 여러 문제를 동시에 연산 (cpu 코어수 인듯)
