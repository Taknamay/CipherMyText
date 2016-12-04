
all:	cipher queue

cipher:	macduffie/cipher.class

queue:	macduffie/queue.class

macduffie/cipher.class:	cipher.sld macduffie/queue.class
	kawa -C cipher.sld

macduffie/queue.class: queue.sld queue.body.scm
	kawa -C queue.sld

clean:
	rm -f *.class */*.class
