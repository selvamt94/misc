if [ ! -d "consulkv" ]; then
        mkdir consulkv
fi
rm -fr consulkv/*
IFS=$'\n'
for _podINFO_ in `kubectl get pod -n neuvector -o wide | grep "controller\|allinone"`; do
        _podNAME_=`echo $_podINFO_ | awk '{print $1}'`
        _HOSTNAME_=`echo $_podINFO_ | awk '{print $6}'`
        if [ ! -d "consulkv/$_HOSTNAME_" ]; then
                mkdir consulkv/$_HOSTNAME_
        fi
        echo dumping the consul kv, $_podNAME_ on $_HOSTNAME_
        for _KEYS_ in `kubectl exec $_podNAME_ -n neuvector -- consul kv get -keys`; do
                if [ `echo $_KEYS_ | grep object | wc -l` = "1" ]; then
                        for _OBJKEYS_ in `kubectl exec $_podNAME_ -n neuvector -- consul kv get -keys $_KEYS_`; do
                                #kubectl exec $_podNAME_ -n neuvector -- consul kv get -recurse $_OBJKEYS_ > ./consulkv/$_HOSTNAME_/`echo $_OBJKEYS_ | awk -F"/" '{print $1"."$2}'`.exp
                                kubectl exec $_podNAME_ -n neuvector -- consul kv export $_OBJKEYS_ > ./consulkv/$_HOSTNAME_/`echo $_OBJKEYS_ | awk -F"/" '{print $1"."$2}'`.exp
                        done
                else
                        kubectl exec $_podNAME_ -n neuvector -- consul kv export $_KEYS_ > ./consulkv/$_HOSTNAME_/`echo $_KEYS_ | awk -F"/" '{print $1}'`.exp
                fi
        done
        echo total containers: `grep '"scope":"' consulkv/$_HOSTNAME_/object.workload.exp | wc -l` >> ./consulkv/md5sum.log
        echo total containers with host scope: `grep '"scope":"host"' consulkv/$_HOSTNAME_/object.workload.exp | wc -l` >> ./consulkv/md5sum.log
        echo total containers with nat scope: `grep '"scope":"nat"' consulkv/$_HOSTNAME_/object.workload.exp | wc -l` >> ./consulkv/md5sum.log
        echo total containers with global scope: `grep '"scope":"global"' consulkv/$_HOSTNAME_/object.workload.exp | wc -l` >> ./consulkv/md5sum.log
        md5sum consulkv/$_HOSTNAME_/* >> ./consulkv/md5sum.log
done
cat ./consulkv/md5sum.log
