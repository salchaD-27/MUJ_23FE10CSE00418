# 12. Disarium Number (175 = 1^1 + 7^2 + 5^3 = 1+ 49 +125 = 175)
orig=(n:=int(input("Enter Number: ")))
pl=0
while n!=0:
    pl=(pl*10)+(n%10)
    n=n//10
i=1
sum=0
while pl!=0:
    sum+=(pl%10)**i
    pl=pl//10
    i+=1
print("Disarium Number") if orig==sum else print("Not a Disarium Number")

# 13. Harshad Number (number is divisible by the sum of its digits).
orig=(n:=int(input("Enter Number: ")))
sum=0
while n!=0:
    sum+=n%10
    n=n//10
print("Harshad Number") if orig%sum==0 else print("Not a Harshad Number")

# 14. Armstrong Number from 1 to 1000.
for n in range(1, 1001):
    digits=0
    temp=n
    while temp!=0:
        temp=temp//10
        digits+=1
    temp=n
    sum=0
    while temp!=0:
        sum+=((temp%10)**digits)
        temp=temp//10
    if n==sum:
        print(n)

# 15. Value of X^n.
n1=int(input("Enter Number: "))
n2=int(input("Enter Exponent: "))
print("Answer: ", n1**n2)

# 16. Value of nCr
def fact(n):
    if n==0 or n==1: return 1
    else: return n*fact(n-1)
print((n:=int(input("Enter n for nCr: "))), "C", (r:=int(input("Enter r for nCr: "))), ":", fact(n)/(fact(r)*fact(n-r)))

# 17. Sum of digits in the entered number.
n=int(input("Enter Number: "))
sum=0
while n!=0:
    sum+=n%10
    n=n//10
print("Sum of digits: ", sum)