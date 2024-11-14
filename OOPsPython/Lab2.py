#5. Fibonacci Series
for i in range(0, n1:=int(input("Enter number of terms for fibonacci series: "))):
    if i==0 or i==1: 
        print(i)
        secondLastTerm=0
        lastTerm=1
    else: 
        print(num:=lastTerm+secondLastTerm)
        secondLastTerm=lastTerm
        lastTerm=num

#6. Calculate Factorial Using Loop
ans2=1
for i in range(1, (n2:=int(input("Enter a number: ")))+1):
    ans2*=i
print("Factorial of ", n2, ":", ans2)

#7. Armstrong Number
n3=int(input("Enter a number: "))
digits=0
temp1n3=n3
while temp1n3!=0:
    temp1n3=temp1n3//10
    digits+=1
sum3=0
temp2n3=n3
while temp2n3!=0:
    temp3=temp2n3%10
    sum3+=temp3**digits
    temp2n3=temp2n3//10
if sum3==n3: print(n3, "is an Amrstrong Number")
else: print(n3, "is not an Amrstrong Number")


#8. Perfect Number
n4=int(input("Enter a number: "))
sum4=0
for i in range(1, n4):
    if n4%i==0:
        sum4+=i
if(sum4==n4): print(n4, "is a Perfect Number")
else: print(n4, "is not a Perfect Number")

#9. Strong Number
n5=int(input("Enter a number: "))
def fact(n):
    if n==0 or n==1: return 1
    else: return n*fact(n-1)
temp1n5=n5
sum5=0
while temp1n5!=0:
    temp5=temp1n5%10
    sum5+=fact(temp5)
    temp1n5=temp1n5//10
if sum5==n5: print(n5, "is a Strong Number")
else: print(n5, "is not a Strong Number")

#10. Multiplication Tables
n6=int(input("Enter a number: "))
print("Multiplication Table of", n6,":")
for i in range(1, 11):
    print(n6, "*", i, ":", n6*i, "\n")

#11. LCM and GCD of Two Numbers
n71 = int(input("Enter number 1: "))
n72 = int(input("Enter number 2: "))
a, b = n71, n72
while b:
    a, b = b, a % b
gcd = a
lcm = abs(n71 * n72) // gcd
print("GCD of", n71, "and", n72, ":", gcd)
print("LCM of", n71, "and", n72, ":", lcm)