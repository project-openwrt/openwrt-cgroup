libipt_cgroup.so: libipt_cgroup.o
	$(CC) -shared -lxtables -o $@ $^;
libipt_cgroup.o: libipt_cgroup.c
	$(CC) ${CFLAGS} -fPIC -D_INIT=$*_init -c -o $@ $<;

obj-m += xt_cgroup.o
