#!/bin/bash
#clear file
>voltages_3070.txt

DELAY=0.125
MAXGPUCLOCK=2000
GPUCLOCKSTEP=15
GPUNUMBER=$1
clockTry=100
echo "start"
echo "checking voltages for gpu umber $GPUNUMBER"
for clockTry in 805	820	835	850	865	880	895	910	925	940	955	970	985	1000	1015	1030	1045	1060	1075	1090	1105	1120	1135	1150	1165	1180	1195	1210	1225	1240	1255	1270	1285	1300	1315	1330	1345	1360	1375	1390	1405	1420	1435	1450	1465	1480	1495	1510	1525	1540	1555	1570	1585	1600	1615	1630	1645	1660	1675	1690	1705 1720 1735 1750 1765	1780	1795	1810	1825	1840	1855	1870	1885	1900	1915	1930	1945	1960	1975	1990	2005	2020	2035	2050	2065	2080	2095	2110	2125	2140	2155	2170	2185	2200	2215
do
#echo "trying $clockTry MHz core clock"
nvtool -i 3 --setclocks $clockTry  --setcoreoffset 0 &> /dev/null
sleep $DELAY
nvidia-smi -q -d VOLTAGE -i $GPUNUMBER | grep Graphics > currentVoltage >> voltages_3070.txt
nvtool -i $GPUNUMBER  --clocks | grep GPU >> voltages_3070.txt&& echo "==========">>voltages_3070.txt
TEXT="clock $clockTry MHz"
echo -e "\033[0;31m $TEXT \e[0m"
CURRENTVOLTAGE=$(nvidia-smi -q -d VOLTAGE -i $GPUNUMBER | grep Graphics)
TEXT="voltage $CURRENTVOLTAGE"
echo -e "\e[0;32m $TEXT \e[0m"
clockTry=$((clockTry+$GPUCLOCKSTEP-1))
done
