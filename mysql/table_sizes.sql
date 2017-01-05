SELECT
    IF(ISNULL(DB)+ISNULL(ENGINE)=2,'Database Total',
    CONCAT(DB,' ',IFNULL(ENGINE,'Total'))) "Reported Statistic",
    LPAD(CONCAT(FORMAT(DAT/POWER(1024,pw1),2),' ',
    SUBSTR(units,pw1*2+1,2)),17,' ') "Data Size",
    LPAD(CONCAT(FORMAT(NDX/POWER(1024,pw2),2),' ',
    SUBSTR(units,pw2*2+1,2)),17,' ') "Index Size",
    LPAD(CONCAT(FORMAT(TBL/POWER(1024,pw3),2),' ',
    SUBSTR(units,pw3*2+1,2)),17,' ') "Total Size"
FROM
(
    SELECT DB,ENGINE,DAT,NDX,TBL,
    IF(px>4,4,px) pw1,IF(py>4,4,py) pw2,IF(pz>4,4,pz) pw3
    FROM 
    (SELECT *,
        FLOOR(LOG(IF(DAT=0,1,DAT))/LOG(1024)) px,
        FLOOR(LOG(IF(NDX=0,1,NDX))/LOG(1024)) py,
        FLOOR(LOG(IF(TBL=0,1,TBL))/LOG(1024)) pz
    FROM
    (SELECT
        DB,ENGINE,
        SUM(data_length) DAT,
        SUM(index_length) NDX,
        SUM(data_length+index_length) TBL
    FROM
    (
       SELECT table_schema DB,ENGINE,data_length,index_length FROM
       information_schema.tables WHERE table_schema NOT IN
       ('information_schema','performance_schema','mysql')
       AND ENGINE IS NOT NULL
    ) AAA GROUP BY DB,ENGINE WITH ROLLUP
) AAA) AA) A,(SELECT ' BKBMBGBTB' units) B;
