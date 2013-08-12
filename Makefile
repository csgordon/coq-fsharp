
default: fsinclude

fsinclude: Coq.fs
	fsharpc -a Coq.fs

grabtests: grab_cic.sh
	./grab_cic.sh
	tar -zxvf CoqInCoq.tar.gz

test: CoqInCoq
	cp CoqInCoq/Extract.v CoqInCoq/Extract_orig.v
	echo Load "\"../FSharp.v\"". > CoqInCoq/Extract.v
	cat CoqInCoq/Extract_orig.v >> CoqInCoq/Extract.v
	make -C CoqInCoq || true # make may fail after extraction...
	./ml2fs.sh CoqInCoq/core.ml
	
