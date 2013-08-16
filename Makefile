
default: Coq.dll

%.dll: %.fs
	fsharpc -a $<

CoqInCoq: grab_cic.sh Coq.dll
	./grab_cic.sh
	tar -zxvf CoqInCoq.tar.gz

test: CoqInCoq
	cp CoqInCoq/Extract.v CoqInCoq/Extract_orig.v
	echo Load "\"../FSharp.v\"". > CoqInCoq/Extract.v
	cat CoqInCoq/Extract_orig.v >> CoqInCoq/Extract.v
	make -C CoqInCoq || true # make may fail after extraction...
	./ml2fs.sh CoqInCoq/core.ml
	
