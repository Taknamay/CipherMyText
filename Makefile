
CSC=csc -R r7rs

all:	macduffie.cipher.so

macduffie.cipher.so:	cipher.sld macduffie.queue.so
	$(CSC) -X macduffie.queue.so -library cipher.sld -o macduffie.cipher.so

macduffie.queue.so:	queue.sld
	$(CSC) -library queue.sld -o macduffie.queue.so

