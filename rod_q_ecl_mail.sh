#!/bin/sh
LDIR="/ua13app/lifeua/ecom/scripts/ROD_Q/OUT/"
#ARCHDIR="/ua13app/lifeua/ecom/scripts/saves/
MASK="rod_q_ecl*"
LOGFILE="/ua13app/lifeua/ecom/scripts/ROD_Q/LOG/ROD_Q.log"
echo "Start" >> $LOGFILE
date >> $LOGFILE
echo "Start sending" >> $LOGFILE
date >> $LOGFILE
SUBJECT="ROD quality report"
EMAIL=""
ls ${LDIR}${MASK} >> $LOGFILE
echo "Please find the report attached"|mailx -s "$SUBJECT" -a $1 $EMAIL
#mv -f ${LDIR}${MASK} ${ARCHDIR}
echo "End sending" >> $LOGFILE
echo "End" >> $LOGFILE
echo "End"
