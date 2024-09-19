# 1. Prime Number
flag=0
for i in range(2, n:=int(input("Enter Number: "))):
    if(n%i==0):
        flag=1
print("Not Prime") if flag!=0 else print("Prime")

# 2. Palindrome Number
orig=(n:=int(input("Enter Number: ")))
pl=0
while n!=0:
    pl=(pl*10)+(n%10)
    n=n//10
print("Palindrome") if orig==pl else print("Not Palindrome")

# 3. Grade of Student Using Given Percentage
n=float(input("Enter Student %: "))
if n<=100 and n>=90: print("Grade: A")
elif n<90 and n>=80: print("Grade: B")
elif n<80 and n>=70: print("Grade: C")
elif n<70 and n>=60: print("Grade: D")
elif n<60 and n>=33: print("Grade: E")
elif n<33 and n>=0: print("Grade: F")
else: print("Invalid %")

# 4. Console Based Calculator 
n1=float(input("Enter Number 1: "))
n2=float(input("Enter Number 2: "))
n3=str(input("Enter Operation (+,-,*,/): "))
if n3=='+': print("Answer: ", n1+n2)
if n3=='-': print("Answer: ", n1-n2)
if n3=='*': print("Answer: ", n1*n2)
if n3=='/': print("Answer: ", n1/n2)