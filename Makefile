
CSC=csc -R r7rs

all:	cmt

cmt:	cmt.scm macduffie.cipher.so
	$(CSC) -X macduffie.queue.so -X macduffie.cipher.so cmt.scm -o cmt

macduffie.cipher.so:	cipher.sld macduffie.queue.so
	$(CSC) -X macduffie.queue.so -library cipher.sld -o macduffie.cipher.so

macduffie.queue.so:	queue.sld
	$(CSC) -library queue.sld -o macduffie.queue.so

clean:
	rm -f *.so cmt
