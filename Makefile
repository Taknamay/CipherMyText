
all:	cipher queue

cipher:	macduffie/cipher.class

queue:	macduffie/queue.class

macduffie/cipher.class:	cipher.sld macduffie/queue.class
	kawa -C cipher.sld

macduffie/queue.class:	queue.sld queue.body.scm
	kawa -C queue.sld

app:	cmt.jar

cmt.jar:	gui/gui.class
	jar cvfm cmt.jar Manifest.txt kawa gnu macduffie gui

gui/gui.class:	gui/gui.scm
	kawa --main -C gui/gui.scm

clean:
	rm -f *.class */*.class
