all: create emulate

create:
	dd if=/dev/zero of=myrootfs.img bs=1M count=100
	mkfs.ext3 -F myrootfs.img
	mkdir xx
	sudo mount myrootfs.img xx
	sudo cp -R _install/* xx/
	sudo umount xx/	
emulate:
	 qemu-system-x86_64 -kernel bzImage -drive file=myrootfs.img -append "root=/dev/sda rdinit=initrd console=ttyS0 rw"  -serial stdio

clean:
	rm -R xx myrootfs.img
