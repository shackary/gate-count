import time

doc = open("gate_test.txt", "a", encoding = "UTF-8")

doc.write(str(time.time()) + '\n')

doc.close()