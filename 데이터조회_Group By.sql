-- GROUP BY ���� --

SELECT * FROM KOPO_CUSTOMERDATA;

SELECT 
    GENDER,
    AVG(TOTAL_AMOUNT)
FROM KOPO_CUSTOMERDATA
GROUP BY GENDER;

SELECT * FROM KOPO_STUDENT_2018;

SELECT 
    TEAM_ID
    ,AVG(SCORE_MATH)
    ,SUM(SCORE_MATH)
    ,MIN(SCORE_MATH)
    ,MAX(SCORE_MATH)
    ,COUNT(SCORE_MATH)
    FROM KOPO_STUDENT_2018
    GROUP BY TEAM_ID;
    
    
    
SELECT 
     A.STUDENT_ID
    ,A.TEAM_ID
    ,A.SCORE_MATH
    ,B.AVG_MATH
    FROM 
        KOPO_STUDENT_2018 A,   
        (SELECT 
            TEAM_ID
            ,AVG(SCORE_MATH) AS AVG_MATH
            FROM KOPO_STUDENT_2018
            GROUP BY TEAM_ID) B
    WHERE 1=1
    AND A.TEAM_ID = B.TEAM_ID (+);
    
    
    
SELECT 
        GENDER
        , AVG(TOTAL_AMOUNT) AS AVG_TOTAL
        FROM KOPO_CUSTOMERDATA
        GROUP BY GENDER;
        
SELECT A.* 
        ,AVG_TOTAL
        FROM KOPO_CUSTOMERDATA A,
        (SELECT 
        GENDER
        , AVG(TOTAL_AMOUNT) AS AVG_TOTAL
        FROM KOPO_CUSTOMERDATA
        GROUP BY GENDER) B
    WHERE 1=1
    AND A.GENDER = B.GENDER;
    
SELECT A.*
        ,(SELECT 
        AVG(TOTAL_AMOUNT) 
        FROM KOPO_CUSTOMERDATA
        GROUP BY GENDED) AS AVG_TOTAL
        FROM KOPO_CUSTOMERDATA A;
        
        
SELECT A.KEY, COUNT(*)
FROM (
    SELECT 
        CONCAT(REGIONID,CONCAT('_',PRODUCT)) AS KEY
        ,REGIONID
        , PRODUCT
        , YEARWEEK
        , CASE WHEN QTY > 700000
                THEN 700000
                ELSE QTY END AS QTY
        FROM KOPO_CHANNEL_SEASONALITY_NEW
        WHERE 1=1
        AND PRODUCT IN ('PRODUCT1','PRODUCT2')
        AND SUBSTR(YEARWEEK,5,6) != '53'
)A
GROUP BY KEY
ORDER BY KEY
