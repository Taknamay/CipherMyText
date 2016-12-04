
all:	cipher queue

cipher:	macduffie/cipher.class

queue:	macduffie/queue.class

macduffie/cipher.class:	cipher.sld macduffie/queue.class
	kawa -C cipher.sld

macduffie/queue.class:	queue.sld queue.body.scm
	kawa -C queue.sld

app:	cmt.jar

cmt.jar:	gui/cmtApp.class Manifest.txt
	jar cvfm cmt.jar Manifest.txt kawa gnu macduffie gui

gui/cmtApp.class:	gui/cmtGui.class gui/cmtApp.scm
	kawa --main -C gui/cmtApp.scm

gui/cmtGui.class:	gui/cmtGui.scm
	kawa -C gui/cmtGui.scm

#gui/gui.class:	gui/gui.scm
#	kawa --main -C gui/gui.scm

clean:
	rm -f *.class */*.class
	rm -f cmt.jar
