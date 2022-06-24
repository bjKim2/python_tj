def sum(a,b):
    if type(a) != type(b):
        print("더하기를 할 수 없습니다.")
    else:
        return a + b


#파이썬에서 main 메소드 만드는 법 
if __name__ == "__main__": ##__로 시작하는 것들은 모두 시스템 변수
    print(sum(10,20))