import time
import RPi.GPIO as GPIO
import os

#Set the working directory
os.chdir("/home/pi/Documents/gatecount")

#Set up the I/O
GPIO.setmode(GPIO.BOARD)
GPIO.setup(7, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

#Startup confirmation (and time to move away from the sensor)
print("Ready to go!")
time.sleep(10)
print("Waiting...")

#Execution
while True:
	if GPIO.input(7):
		print("Movement detected!")
		with open('hits_test.txt', 'a', encoding = "UTF-8") as data:
			data.write(str(time.time()) + '\n')
		time.sleep(3)
	
