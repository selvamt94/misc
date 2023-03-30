_supportFile_=$1
_curCase_=$2

_jKeys_=`cat $_supportFile_ | jq -c 'keys'`
_jLen_=`echo $_jKeys_ | jq '. | length'`
for i in $(seq 0 $((( _jLen_ - 1 )))); do
	_jKey_=`echo $_jKeys_ | jq -r --arg index "$i" '.[$index|tonumber]'`
	if [ `echo $_jKey_ | grep '/v' | wc -l` = "1" ]; then
		# trim / and replace /?= to -
		_fNAME_=$_curCase_-`echo ${_jKey_:1} | sed 's/[\/?=]/-/g'`.json
#		echo _jKey_ = $_jKey_, _fNAME_ = $_fNAME_
		cat $_supportFile_ | jq -r --arg _jKey_ "$_jKey_" '.[$_jKey_]' > $_fNAME_
                key_length=`cat $_fNAME_ | jq '. | keys|length'`
                if [ $key_length = "1" ];then
                         key=`cat $_fNAME_ | jq -r '. | keys[]'`
                         key_count=`cat $_fNAME_ | jq ".${key} |length"`
                         echo "$_fNAME_ $key $key_count" | tee -a parsed_result
                else
                         #echo $_fNAME_ $key_length
                         _keys_=(`cat $_fNAME_ | jq -r '.|keys[]'`)
                         for k in ${_keys_[@]}
                         do 
                               key=$k
                               if [ `cat $_fNAME_ |jq -r ".${key}|type"` != "boolean" ]; then

                                      key_count=`cat $_fNAME_ |jq ".${key} |length"`
                                      echo "$_fNAME_ $key $key_count" | tee -a parsed_result
                               else
                                      echo "$_fNAME_ $key `cat $_fNAME_ |jq -r ".${key}"`" | tee -a parsed_result
                               fi
                         done
                fi
		#gzip -c $_fNAME_ > $_fNAME_".gz"
		#rm $_fNAME_
	fi
done

group_count=`cat ${_curCase_}-v1-group.json | jq .groups[].name | wc -l`
policy_count=`cat ${_curCase_}-v1-policy-rule.json | jq .rules[].id | wc -l`
waf_group_count=`cat ${_curCase_}-v1-waf-group.json | jq '.waf_groups[] | select(.status == true) |.name' | wc -l`
dlp_group_count=`cat ${_curCase_}-v1-dlp-group.json | jq '.dlp_groups[] | select(.status == true) |.name' | wc -l`

echo "Total Group Count: $group_count"
echo "Total Policy Count: $policy_count"
echo "Total WAF Group Status True Count: $waf_group_count"
echo "Total DLP Group Status True Count: $dlp_group_count"

auto_scale=`cat ${_curCase_}-v2-system-config.json | jq .config.scanner_autoscale.strategy`
echo "Scanner autosclae status $auto_scale"

scan_config=`cat ${_curCase_}-v1-scan-config.json | jq .config.auto_scan`
echo "Auto scan config $scan_config"
