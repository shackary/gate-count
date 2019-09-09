import time

with open("gate_test.txt", "a", encoding = "UTF-8") as data:
	data.write(str(time.time()) + '\n')