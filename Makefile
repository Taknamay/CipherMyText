
all:	cipher queue

cipher:	macduffie/cipher.class

queue:	macduffie/queue.class

macduffie/cipher.class:	cipher.sld macduffie/queue.class
	kawa -C cipher.sld

macduffie/queue.class:	queue.sld queue.body.scm
	kawa -C queue.sld

app:	gui/gui.class

gui/gui.class:	gui/gui.scm
	kawa --main -C gui/gui.scm

clean:
	rm -f *.class */*.class
