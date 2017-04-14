usql -h -n -t\; -e "
/*!pass-through*/
select
 A1.\"tsunld\" as \"UNLD DATE\"
,A0.\"vrfilk\" as \"depot\"
,A0.\"oms\" as \"region\"
,to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0')) as \"total\"
,to_number(nvl(sum(A1.c5),'0')) || ' ' ||
case when to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0')) = 0
then '(-%)'
else '(' ||
round((to_number(nvl(sum(A1.c5),'0')) /
(to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0'))))*100,0)
|| '%)'
end as \"in_time (q%)\"
,to_number(nvl(sum(A1.c6),'0')) || ' ' ||
case when to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0')) = 0
then '(-%)'
else '(' ||
round((to_number(nvl(sum(A1.c6),'0')) /
(to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0'))))*100,0)
|| '%)'
end as \"late (q%)\"
,to_number(nvl(sum(A1.c4),'0')) || ' ' ||
case when to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0')) = 0
then '(-%)'
else '(' ||
round((to_number(nvl(sum(A1.c4),'0')) /
(to_number(nvl(sum(A1.c4),'0'))
+to_number(nvl(sum(A1.c5),'0'))
+to_number(nvl(sum(A1.c6),'0'))))*100,0)
|| '%)'
end as \"not_processed (q%)\"
/*,case when '' = 'nf'
then 'nf'
when '' = 'fl'
then 'fl'
else ''
end as \"Product\",*/
from
life.\"cef_vrfili\" A0
left outer join
(
select distinct
t1.\"dosvlg\" as c1,
t1.\"tsunld\" as \"tsunld\"
,case when t5.\"DEL_DEPOT\" is not null
then t5.\"DEL_DEPOT\"
else to_number(substr(tsroma.\"tsrido\",4,2))
end as c2
,least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD')))
- ((
case when
tsfees.\"oms\" = 'so'
then t4.\"tstizo\" + 2
when tsfees.\"oms\" = 'n'
then t4.\"tstizo\" + 1
when tsfees.\"oms\" = 'holiday'
then t4.\"tstizo\" + 1
else t4.\"tstizo\"
end) + 5)
- (select count(*) from life.\"cef_tsfees\"
where \"land\" = 'UA'
and \"jdatum\" between t4.\"tstizo\"
and
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD')))
) as c3
,case when
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD'))) -
((
case when
tsfees.\"oms\" = 'so'
then t4.\"tstizo\" + 2
when tsfees.\"oms\" = 'n'
then t4.\"tstizo\" + 1
when tsfees.\"oms\" = 'holiday'
then t4.\"tstizo\" + 1
else t4.\"tstizo\"
end) + 5) -
(select count(*) from life.\"cef_tsfees\"
where \"land\" = 'UA'
and \"jdatum\" between t4.\"tstizo\"
and
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD')))
) is null
then 1
else 0
end as c4
,case when
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD'))) -
((
case when
tsfees.\"oms\" = 'so'
then t4.\"tstizo\" + 2
when tsfees.\"oms\" = 'n'
then t4.\"tstizo\" + 1
when tsfees.\"oms\" = 'holiday'
then t4.\"tstizo\" + 1
else t4.\"tstizo\"
end) + 5) -
(select count(*) from life.\"cef_tsfees\"
where \"land\" = 'UA'
and \"jdatum\" between t4.\"tstizo\"
and
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD')))
) <= 0
then 1
else 0
end as c5
,case when
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD'))) -
((
case when
tsfees.\"oms\" = 'so'
then t4.\"tstizo\" + 2
when tsfees.\"oms\" = 'n'
then t4.\"tstizo\" + 1
when tsfees.\"oms\" = 'holiday'
then t4.\"tstizo\" + 1
else t4.\"tstizo\"
end) + 5) -
(select count(*) from life.\"cef_tsfees\"
where \"land\" = 'UA'
and \"jdatum\" between t4.\"tstizo\"
and
least(to_date(t6.LAST_DATE,'YYYY/MM/DD'),
nvl(t2.\"tsacdt\",to_date('29991231','YYYYMMDD')))
)
> 0
then 1
else 0
end
as c6
,substr(to_char(t4.\"tstizo\"),1,10)
,tsfees.\"jdatum\"
,tsfees.\"oms\"
from life.\"cef_tsdsmd\" t1
left outer join life.\"ROD_HANDLING\" t5
on t5.DOSVLG = t1.\"dosvlg\"
left outer join life.\"ROD_HANDLING\" t6
on t6.DOSVLG = t1.\"dosvlg\"
and(
(t5.OWN_DEPOT <> t5.DEL_DEPOT
and t6.TSSTTS >= 30)
or
(t5.OWN_DEPOT = t5.DEL_DEPOT
and t6.TSSTTS >= 10)
)
left outer join
life.\"cef_tsdott\"
t2
on t2.\"dosvlg\" = t1.\"dosvlg\"
and(
(t5.OWN_DEPOT <> t5.DEL_DEPOT
and t2.\"tstrst\" = 30)
or
(t5.OWN_DEPOT = t5.DEL_DEPOT
and t2.\"tstrst\" = 10)
)
and t2.\"doksrt\" = 91
left outer join life.\"cef_vw_naw\" t3
on t3.\"dosvlg\" = t1.\"dosvlg\"
and t3.\"tsroln\" = 0
left outer join
(select distinct
min(\"tstizo\") as \"tstizo\"
,\"dosvlg\"
from
life.\"cef_tstrac\"
where \"tsttkd\" = 'POD'
or \"tsttkd\" = 'D00'
or \"tsttkd\" = 'POD2'
or \"tsttkd\" = 'D21'
or \"tsttkd\" = '200150'
or \"tsttkd\" = '200151'
or \"tsttkd\" = '200152'
or \"tsttkd\" = '200153'
or \"tsttkd\" = '200154'
group by \"dosvlg\") t4
on t4.\"dosvlg\" = t1.\"dosvlg\"
left outer join
life.\"cef_tsfees\" tsfees
on
substr(to_char(t4.\"tstizo\"),1,10) = tsfees.\"jdatum\"
and tsfees.\"land\" = 'UA'
left outer join
(select distinct
\"dosvlg\"
, \"tsrido\"
from life.\"cef_tsroma\"
where \"tsakti\" = 4) tsroma
on tsroma.\"dosvlg\" = t1.\"dosvlg\"
left outer join life.\"cef_tsdsmd\" tsdsmd
on tsroma.\"tsrido\" = tsdsmd.\"dosvlg\"
left outer join life.\"cef_vw_naw\" tsdnaw
on tsdnaw.\"dosvlg\" = tsdsmd.\"dosvlg\"
and tsdnaw.\"tsroln\" = 6
where
t1.\"srtdos\" = 'd'
and t1.\"tsunld\" between 
    to_date(
    extract(year from to_date(SYSDATE,'YYYY-MM-DD'))||'-'||
    (case 
    when
    extract(month from to_date(SYSDATE,'YYYY-MM-DD'))<10
    then
    '0'||extract(month from to_date(SYSDATE,'YYYY-MM-DD'))
    else
    to_char(extract(month from to_date(SYSDATE,'YYYY-MM-DD')))
    end)||'-'||'01'
                        ,'YYYY-MM-DD')
and to_date(SYSDATE,'YYYY-MM-DD')
and substr(t1.\"dosvlg\",6,1) in (1,2)
and t1.\"plaanl\" is null
and (t1.\"tsserl\" is null or t1.\"tsserl\" <> 'OP' )
and t1.\"tsca09\" = 'Y'
and t3.\"zoek\" not like 'RABEN%'
and t3.\"zoek\" not like 'MGOPAK%'
and t3.\"zoek\" not like 'MGL%'
and t3.\"zoek\" <> 'REALKIEBO'
and (t1.\"refopd\" not like 'pallety'
or t1.\"refopd\" is null)
and getCzyAnulowana(t1.\"dosvlg\") = 'n'
) A1
on A0.\"vrfilk\" = A1.c2
where GETAUTODOS(A1.c1) <> 'СКЛАД 01'
and GETAUTODOS(A1.c1) <> 'SKLAD'
group by A0.\"vrfilk\",A0.\"oms\"
,A1.\"tsunld\"
order by 2,1

; 
"
