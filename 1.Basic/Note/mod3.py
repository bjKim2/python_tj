PI = 3.141592

class Math:
    a = 1
    
    def solve(self,r): # class 안에 있는 method를 정의할 때만 매개변수에 self 가 있어야됨 
                        # Math 의 solve 메소드라는 걸 알려주는 의미? 라네
        return PI * (r**2)
    def sum(self,a,b):
        return a + b


if(__name__ == "__main__"):
    print(PI)
    a = Math()
    print(a.solve(2))
    print(a.sum(PI,4.4))


