# utl-stack-pairs-of-columns-with-the-same-id-and-visit-sas-r-python
Stack pairs of columns with the same id and visit sas r python 
    %let pgm=utl-stack-pairs-of-columns-with-the-same-id-and-visit-sas-r-python;

    Stack pairs of columns with the same id and visit sas r python

        SOLUTIONS

             1 sas datastep
             2 sas sql
             3 r sql
             4 python sql


    github
    https://tinyurl.com/yk997x3y
    https://github.com/rogerjdeangelis/utl-stack-pairs-of-columns-with-the-same-id-and-visit-sas-r-python

    stackoverflow R
    https://tinyurl.com/2d2yw8ak
    https://stackoverflow.com/questions/78998651/quick-way-to-combine-several-pairs-of-columns-into-one-column-for-each-pair

    /*               _     _
     _ __  _ __ ___ | |__ | | ___ _ __ ___
    | `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
    | |_) | | | (_) | |_) | |  __/ | | | | |
    | .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
    |_|
    */

    /**************************************************************************************************************************/
    /*                                             |                                                                          */
    /*               INPUT                         |       PROCESS & OUTPUT                                                   */
    /*                                             |                                                                          */
    /*  SD1.HAVE total obs=4 19SEP2024:07:38:59    |                           ------------                                   */
    /*                                             |  ID    VISIT    A1    B1  |  A2    B2 |                                  */
    /*  Obs    ID    VISIT    A1    B1    A2    B2 |                           |           |                                  */
    /*                                             |  u1    v1        1    11  |   2    21 |                                  */
    /*   1     u1     v1       1    11     2    21 |  u1    v2        3    31  |   4    41 |                                  */
    /*   2     u1     v2       3    31     4    41 |  u2    v1        5    51  |   6    61 |                                  */
    /*                                             |  u2    v2        7    71  |   8    81 |                                  */
    /*   3     u2     v1       5    51     6    61 |                           -------------                                  */
    /*   4     u2     v2       7    71     8    81 |                                  |                                       */
    /*                                             |  ID    VISIT     A    B          |                                       */
    /*                                             |                                  |                                       */
    /*                                             |  u1    v1        1    11         |                                       */
    /*                                             |  u1    v2        3    31         |                                       */
    /*                                             |  u2    v1        5    51         |                                       */
    /*                                             |  u2    v2        7    71         |                                       */
    /*                                             |                                  |                                       */
    /*                                             |  u1    v1        2    21         |                                       */
    /*                                             |  u1    v2        4    41  <------+                                       */
    /*                                             |  u2    v1        6    61                                                 */
    /*                                             |  u2    v2        8    81                                                 */
    /*                                             |                                                                          */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                             |                                                                          */
    /*                                             | SAS SOLUTION                                                             */
    /*                                             | ============                                                             */
    /*                                             |                                                                          */
    /*                                             |  data want;                                                              */
    /*                                             |    set                                                                   */
    /*                                             |      sd1.have(rename=(a1=a b1=b))                                        */
    /*                                             |      sd1.have(rename=(a2=a b2=b));                                       */
    /*                                             |  run;quit;                                                               */
    /*                                             |                                                                          */
    /*                                             |  TWO R SOLUTIONS                                                         */
    /*                                             |  ===============                                                         */
    /*                                             |                                                                          */
    /*                                             |  library(tidyverse)                                                      */
    /*                                             |  df |>                                                                   */
    /*                                             |    pivot_longer(cols = -c(id, visit),                                    */
    /*                                             |      names_pattern = "(.)(\\d+)",                                        */
    /*                                             |      names_to = c(".value", "number")) |>                                */
    /*                                             |    arrange(number)                                                       */
    /*                                             |                                                                          */
    /*                                             |   reshape(                                                               */
    /*                                             |    df,                                                                   */
    /*                                             |    direction = "long",                                                   */
    /*                                             |    idvar = c("id", "visit"),                                             */
    /*                                             |    varying = -(1:2),                                                     */
    /*                                             |    v.names = c("a", "b"),                                                */
    /*                                             |    timevar = "group"                                                     */
    /*                                             |                                                                          */
    /**************************************************************************************************************************/

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    options validvarname=upcase;
    libname sd1 "d:/sd1";
    data sd1.have;
    input  id $ visit $ a1 b1 a2 b2;
    cards4;
    u1 v1 1 11  2 21
    u1 v2 3 31  4 41
    u2 v1 5 51  6 61
    u2 v2 7 71  8 81
    ;;;;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*               INPUT                                                                                                    */
    /*                                                                                                                        */
    /*  SD1.HAVE total obs=4 19SEP2024:07:38:59                                                                               */
    /*                                                                                                                        */
    /*  Obs    ID    VISIT    A1    B1    A2    B2                                                                            */
    /*                                                                                                                        */
    /*   1     u1     v1       1    11     2    21                                                                            */
    /*   2     u1     v2       3    31     4    41                                                                            */
    /*                                                                                                                        */
    /*   3     u2     v1       5    51     6    61                                                                            */
    /*   4     u2     v2       7    71     8    81                                                                            */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*                       _       _            _
    / |  ___  __ _ ___    __| | __ _| |_ __ _ ___| |_ ___ _ __
    | | / __|/ _` / __|  / _` |/ _` | __/ _` / __| __/ _ \ `_ \
    | | \__ \ (_| \__ \ | (_| | (_| | || (_| \__ \ ||  __/ |_) |
    |_| |___/\__,_|___/  \__,_|\__,_|\__\__,_|___/\__\___| .__/
                                                         |_|
    */


    data want;
      set
        sd1.have(rename=(a1=a b1=b))
        sd1.have(rename=(a2=a b2=b));
    run;quit;

    /*___                              _
    |___ \   ___  __ _ ___   ___  __ _| |
      __) | / __|/ _` / __| / __|/ _` | |
     / __/  \__ \ (_| \__ \ \__ \ (_| | |
    |_____| |___/\__,_|___/ |___/\__, |_|
                                    |_|
    */

    proc sql;
      create
         table want as
      select
         id
        ,visit
        ,a1 as a
        ,b1 as b
      from
        sd1.have
      union
        all
      select
         id
        ,visit
        ,a2 as a
        ,b2 as b
      from
        sd1.have
    ;quit;

    /*____                    _
    |___ /   _ __   ___  __ _| |
      |_ \  | `__| / __|/ _` | |
     ___) | | |    \__ \ (_| | |
    |____/  |_|    |___/\__, |_|
                           |_|
    */


    %utl_rbeginx;
    parmcards4;
    library(sqldf)
    library(haven)
    source("c:/oto/fn_tosas9x.R")
    have<-read_sas("d:/sd1/have.sas7bdat")
    print(have)
    want<-sqldf('
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
      ')
    want;
    fn_tosas9x(
       inp    = want
      ,outlib ="d:/sd1/"
      ,outdsn ="want"
      )
    ;;;;
    %utl_rendx;

    proc print data=sd1.want;
    run;quit;



    /**************************************************************************************************************************/
    /*                     |                                                                                                  */
    /*       R             |             SAS                                                                                  */
    /*                     |                                                                                                  */
    /*  > want;            |                                                                                                  */
    /*    ID VISIT a  b    | ROWNAMES    ID    VISIT    A     B                                                               */
    /*  > want;            |                                                                                                  */
    /*  1 u1    v1 1 11    |     1       u1     v1      1    11                                                               */
    /*  2 u1    v2 3 31    |     2       u1     v2      3    31                                                               */
    /*  3 u2    v1 5 51    |     3       u2     v1      5    51                                                               */
    /*  4 u2    v2 7 71    |     4       u2     v2      7    71                                                               */
    /*  5 u1    v1 2 21    |     5       u1     v1      2    21                                                               */
    /*  6 u1    v2 4 41    |     6       u1     v2      4    41                                                               */
    /*  7 u2    v1 6 61    |     7       u2     v1      6    61                                                               */
    /*  8 u2    v2 8 81    |     8       u2     v2      8    81                                                               */
    /*                     |                                                                                                  */
    /**************************************************************************************************************************/

    /*  _                 _   _                             _
    | || |    _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
    | || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
    |__   _| | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
       |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
             |_|    |___/                                |_|
    */

    %utl_pybeginx;
    parmcards4;
    import pyarrow.feather as feather
    import tempfile
    import pyperclip
    import os
    import sys
    import subprocess
    import time
    import pandas as pd
    import pyreadstat as ps
    import numpy as np
    from pandasql import sqldf
    mysql = lambda q: sqldf(q, globals())
    from pandasql import PandaSQL
    pdsql = PandaSQL(persist=True)
    sqlite3conn = next(pdsql.conn.gen).connection.connection
    sqlite3conn.enable_load_extension(True)
    sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll')
    mysql = lambda q: sqldf(q, globals())
    exec(open('c:/oto/fn_tosas9x.py').read())
    have, meta = ps.read_sas7bdat("d:/sd1/have.sas7bdat")
    want=pdsql("""
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
       """)
    print(want)
    fn_tosas9x(want,outlib="d:/sd1/",outdsn="rwant",timeest=3)
    ;;;;
    %utl_pyendx;

    libname sd1 "d:/sd1";
    proc print data=sd1.rwant;
    run;quit;


    /**************************************************************************************************************************/
    /*                         |                                                                                              */
    /*      PYTHIN             |           SAS                                                                                */
    /*                         |                                                                                              */
    /*  > want;                |                                                                                              */
    /*    ID VISIT    a    b   |   ID    VISIT    A     B                                                                     */
    /*                         |                                                                                              */
    /* 0  u1    v1  1.0  11.0  |   u1     v1      1    11                                                                     */
    /* 1  u1    v2  3.0  31.0  |   u1     v2      3    31                                                                     */
    /* 2  u2    v1  5.0  51.0  |   u2     v1      5    51                                                                     */
    /* 3  u2    v2  7.0  71.0  |   u2     v2      7    71                                                                     */
    /* 4  u1    v1  2.0  21.0  |   u1     v1      2    21                                                                     */
    /* 5  u1    v2  4.0  41.0  |   u1     v2      4    41                                                                     */
    /* 6  u2    v1  6.0  61.0  |   u2     v1      6    61                                                                     */
    /* 7  u2    v2  8.0  81.0  |   u2     v2      8    81                                                                     */
    /*                     |                                                                                                  */
    /**************************************************************************************************************************/

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
