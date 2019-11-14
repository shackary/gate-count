import time
import RPi.GPIO as GPIO

#Set up the I/O
GPIO.setmode(GPIO.BOARD)
GPIO.setup(7, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

#Startup confirmation (and time to move away from the sensor)
print("Ready to go!")
time.sleep(10)
print("Waiting...")

#Set up an iterator (just for fun while testing)
hits = 1

#Execution
while True:
	if GPIO.input(7):
		print("Movement detected!" + " " + str(hits))
		hits += 1
		with open('/home/pi/Documents/gate-count/raws/hits_test.txt', 'a', encoding = "UTF-8") as data:
			data.write(str(time.time()) + '\n')
		time.sleep(3)
	
