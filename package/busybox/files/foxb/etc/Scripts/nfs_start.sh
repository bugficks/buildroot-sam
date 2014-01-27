mount -t tmpfs none /var/lib/nfs -o size=1M,mode=1777
mount -t tmpfs none /var/run -o size=1M,mode=1777
touch /var/lib/nfs/etab; touch /var/lib/nfs/rmtab;touch /var/lib/nfs/xtab
rpcbind
exportfs -arv 1> /dev/null 2> /dev/null
nfsd 8
mountd
