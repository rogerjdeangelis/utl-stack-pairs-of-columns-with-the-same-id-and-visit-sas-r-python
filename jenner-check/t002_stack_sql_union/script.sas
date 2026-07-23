/* Solution 2 of utl-stack-pairs-of-columns-with-the-same-id-and-visit:   */
/* the PROC SQL UNION ALL that stacks the (a1,b1) and (a2,b2) column      */
/* pairs into a single (a,b) pair, keyed by id and visit.                 */
/* Author's input (inline cards4) and UNION ALL query preserved verbatim; */
/* only the hardcoded libname "d:/sd1" is dropped so HAVE lives in WORK.   */

data have;
input  id $ visit $ a1 b1 a2 b2;
cards4;
u1 v1 1 11  2 21
u1 v2 3 31  4 41
u2 v1 5 51  6 61
u2 v2 7 71  8 81
;;;;
run;quit;

/* 2 sas sql */
proc sql;
  create
     table want as
  select
     id
    ,visit
    ,a1 as a
    ,b1 as b
  from
    have
  union
    all
  select
     id
    ,visit
    ,a2 as a
    ,b2 as b
  from
    have
;quit;

proc print data=want;
run;quit;
