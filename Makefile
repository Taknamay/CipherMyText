
CSC=csc -R r7rs
INSTALL_PATH=/usr/local

all:	cmt

cmt:	cmt.scm macduffie.cipher.so
	$(CSC) -X macduffie.queue.so -X macduffie.cipher.so cmt.scm -o cmt

macduffie.cipher.so:	cipher.sld macduffie.queue.so
	$(CSC) -X macduffie.queue.so -library cipher.sld -o macduffie.cipher.so

macduffie.queue.so:	queue.sld
	$(CSC) -library queue.sld -o macduffie.queue.so

install:	cmt
	cp macduffie.cipher.so macduffie.queue.so $(INSTALL_PATH)/lib/chicken/8/
	cp cmt $(INSTALL_PATH)/bin/

uninstall:
	rm -f $(INSTALL_PATH)/lib/chicken/8/macduffie.cipher.so
	rm -f $(INSTALL_PATH)/lib/chicken/8/macduffie.queue.so
	rm -f $(INSTALL_PATH)/bin/cmt

clean:
	rm -f *.so cmt
