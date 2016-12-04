
all:	cipher queue

cipher:	macduffie/cipher.class

queue:	macduffie/queue.class

macduffie/cipher.class:	cipher.sld macduffie/queue.class
	kawa -C cipher.sld

macduffie/queue.class:	queue.sld queue.body.scm
	kawa -C queue.sld

app:	cmt.jar

cmt.jar:	cmtApp.class Manifest.txt
	jar cvfm cmt.jar Manifest.txt kawa gnu macduffie *.class

cmtApp.class:	cmtGui.class cmtApp.scm
	kawa --main -C cmtApp.scm

cmtGui.class:	cmtGui.scm
	kawa -C cmtGui.scm

clean:
	rm -f *.class */*.class
	rm -f cmt.jar
