with open("split.txt", 'w') as f:
    f.write("case tempo is\n")
    for i in range(60, 121):
        j = i
        s3 = 0
        if(i >= 100):
            j -=100
            s3 = 1
        s2 = 0
        while(j >= 10):
            s2+=1
            j-=10
        s1 = j
        print(str(i))
        print(str(s3))
        print(str(s2))
        print(str(s1))
        f.write("when \"" + '{:07b}'.format(i) + "\" =>\n")
        f.write("   s3 <= \"" + '{:04b}'.format(s3) + "\";\n")        
        f.write("   s2 <= \"" + '{:04b}'.format(s2) + "\";\n")
        f.write("   s1 <= \"" + '{:04b}'.format(s1) + "\";\n")