#
# This uses a modified version of nl2binkd v1.00 by Markus Reschke
# My modified version is available in this repository.
#
#
# Environment
# =====================================================================================
# Note: These variables make up my environment for using these scripts
# 
# export SBBSBASE=/home/bbs
# export SBBSCTRL=${SBBSBASE}/ctrl
# export BINKD_CONFIG="${SBBSBASE}/etc/binkd.conf"
# export FIDOCONFIG="${SBBSBASE}/etc/husky.conf"

TEXTFILES=$( awk '/^include \/home\/bbs\/ftn\/nodelist/ { print $2 }' ${BINKD_CONFIG} )

E=$( pwd )
for i in ${TEXTFILES}
do
	DIR=${i%%.txt}
	LATEST=$( ls -tr ${DIR} | tail -1 )

	if [ -f "${DIR}/${LATEST}" ]
	then
		if test "${DIR}/${LATEST}" -nt "${i}"
		then
			echo Newer nodelist exists in ${DIR}/${LATEST}... converting to ${i}
			DOMAIN=$( basename $DIR )
			~/bin/nl2binkd "${DIR}/${LATEST}" "${i}" $DOMAIN
		fi
	fi

done

cd ${E}

