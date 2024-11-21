# 18. Separate the string into comma (,) separated values. X= “ India.is.my.country”
X='India.is.my.country'
tempX=X.split('.')
newX=','.join(tempX)
print(newX)

# 19. Remove a given character from the string Y=”M.A.N.I.P.A.L” 
Y='M.A.N.I.P.A.L'
tempY=Y.split('.')
c=str(input("Enter character to remove: "))
for char in tempY:
    if char==c.upper():
        tempY.remove(char)
newY='.'.join(tempY)
print(newY)

# 20. Remove the (.) dots from the string Y=”M.A.N.I.P.A.L” 
Y='M.A.N.I.P.A.L'
tempY=Y.split('.')
newY=''.join(tempY)
print(newY)

# 21. Sort strings alphabetically in python. 
n=int(input("Enter number of strings: "))
strings=[]
for i in range(n):
    char=str(input(f'Enter string {i+1}: '))
    strings.append(char)
sorted_strings=sorted(strings)
print(sorted_strings)

# 22. Reverse a given string.
string = str(input("Enter String: "))
reversed_string = ''
for char in string:
    reversed_string = char + reversed_string
print(reversed_string)

# 23. Check if string contains only digits.
string = str(input("Enter String: "))
print("The string contains only digits.") if string.isdigit() else print("The string contains characters other than digits.")

# 24. Number of vowels in the string.
string = str(input("Enter String: "))
count=0
for char in string.lower():
    if (char=='a'or char=='e' or char=='i' or char=='o' or char=='u'):
        count+=1
print(count, "vowels")

#25: Inverted Pyramid of Numbers
# 1 1 1 1 1 
#  2 2 2 2 
#   3 3 3 
#    4 4 
#     5
rows = int(input("Enter rows: "))
for i in range(1, rows + 1):
    print(' ' * (i - 1), end='')
    print(f"{i} " * (rows - i + 1))

#26: Half Pyramid Pattern of Numbers
#         1 
#       1 2 
#     1 2 3 
#   1 2 3 4 
# 1 2 3 4 5
rows = int(input("Enter rows: "))
for i in range(1, rows + 1):
    print(' ' * (rows - i) * 2, end='')
    for j in range(1, i + 1):
        print(j, end=' ')
    print()

#27: Inverted Half Pyramid Number Pattern
# 0 1 2 3 4 5 
# 0 1 2 3 4 
# 0 1 2 3 
# 0 1 2 
# 0 1
rows = int(input("Enter rows: "))
for i in range(rows, 0, -1):
    for j in range(i):
        print(j, end=' ')
    print()

#28: Unique Pyramid Pattern of Digits
# 1 
# 1 2 1 
# 1 2 3 2 1 
# 1 2 3 4 3 2 1 
# 1 2 3 4 5 4 3 2 1
rows = int(input("Enter rows: "))
for i in range(1, rows + 1):
    for j in range(1, i + 1):
        print(j, end=' ')
    for j in range(i - 1, 0, -1):
        print(j, end=' ')
    print()

#29: Pyramid of Horizontal Tables
# 0  
# 0 1  
# 0 2 4  
# 0 3 6 9  
# 0 4 8 12 16  
# 0 5 10 15 20 25  
# 0 6 12 18 24 30 36
rows = int(input("Enter rows: "))
for i in range(rows):
    for j in range(i + 1):
        print(i * j, end=' ')
    print()

#30: Equilateral Triangle with Stars (Asterisk Symbol)
#         *   
#        * *   
#       * * *   
#      * * * *   
#     * * * * *   
#    * * * * * *   
#   * * * * * * *
rows = int(input("Enter rows: "))
for i in range(1, rows + 1):
    print(' ' * (rows - i), end='')
    print('* ' * i)