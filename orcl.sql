> -- 1. 오라클 DB 다운로드 https://www.oracle.com/database/technologies/oracle19c-windows-downloads.html
> -- 2. SQL Developer 다운로드 https://www.oracle.com/database/sqldeveloper/technologies/download/
> -- 3. Window + R 키 → cmd 클릭
    C:\Users\Gaeun Baek> sqlplus
    
    사용자명 입력: sys as sysdba
    비밀번호 입력: 엔터키만 누르기
    
    SQL> show user
    USER은 "SYS"입니다
    
    SQL> alter user sys identified by 1234;
    사용자가 변경되었습니다.
    
    SQL> conn sys/1234 as sysdba;
    연결되었습니다.
    
    SQL> create user scott
      2  identified by tiger;
    사용자가 생성되었습니다.
    
    SQL> grant dba to scott;
    권한이 부여되었습니다.
    SQL> connect scott/tiger
    연결되었습니다.
    
    SQL> show user
    USER은 "SCOTT"입니다
    SQL>
    
> --초보자를 위한 SQL 200제 스크립트 https://cafe.daum.net/oracleoracle/Sdyr/846 파일 다운로드 후 “SQL200제_실습스크립트.txt” 본문 복사 → SQL Developer에 붙여넣기 → F5 키로 실행
   alter session set nls_date_format='RR/MM/DD';
   
   drop table emp;
   drop table dept;
   
   CREATE TABLE DEPT
          (DEPTNO number(10),
           DNAME VARCHAR2(14),
           LOC VARCHAR2(13) );
   
   INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
   INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
   INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
   INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
   
   CREATE TABLE EMP (
    EMPNO               NUMBER(4) NOT NULL,
    ENAME               VARCHAR2(10),
    JOB                 VARCHAR2(9),
    MGR                 NUMBER(4) ,
    HIREDATE            DATE,
    SAL                 NUMBER(7,2),
    COMM                NUMBER(7,2),
    DEPTNO              NUMBER(2) );
   
   INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
   INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
   INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
   INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
   INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
   INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
   INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
   INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
   INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
   INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
   INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-11',800,NULL,20);
   INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
   INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
   INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);
   
   commit;
   
   drop  table  salgrade;
   
   create table salgrade
   ( grade   number(10),
     losal   number(10),
     hisal   number(10) );
   
   insert into salgrade  values(1,700,1200);
   insert into salgrade  values(2,1201,1400);
   insert into salgrade  values(3,1401,2000);
   insert into salgrade  values(4,2001,3000);
   insert into salgrade  values(5,3001,9999);
   
   commit;

> --PART 1 START
    select * from emp;

    //001.테이블에서 특정 열 선택하기
    select empno, ename, sal from emp;

    //002.테이블에서 모든 열 출력하기
    select * from emp;
    select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp;
    select dept.*, deptno from dept;

    //003.컬럼 별칭을 사용하여 출력되는 컬럼명 변경하기
    select empno as 사원번호, ename as 사원이름, sal as "Salary" from emp;
    select ename, sal * (12 + 3000) from emp;
    select ename, sal * (12 + 3000) as 월급 from emp;
    
    //004.연결 연산자 사용하기(||)
    select ename || sal from emp;
    select ename || '의 월급은 ' || sal || '입니다. ' as 월급정보 from emp;
    select ename || '의 직업은' || job || '입니다. ' as 직업정보 from emp;
    
    //005.중복된 데이터를 제거해서 출력하기(DISTINCT)
    select distinct job from emp;
    select unique job from emp;
    
    //006.데이터를 정렬해서 출력하기(ORDER BY)
    select ename, sal from emp order by sal asc;
    select ename, sal as 월급 from emp order by 월급 asc;
    select ename, deptno, sal from emp order by deptno asc, sal desc;
    select ename, deptno, sal from emp order by 2 asc, 3 desc;
    
    //007.WHERE절 배우기 1 (숫자 데이터 검색)
    select ename, sal, job from emp where sal = 3000;
    select ename as 이름, sal as 월급 from emp where sal >= 3000;
    
    //008.WHERE절 배우기 2 (문자와 날짜 검색)
    select ename, sal, job, hiredate, deptno from emp
    where ename = 'SCOTT';
    select ename, hiredate from emp
    where hiredate = '81/11/17';
    select * from NLS_SESSION_PARAMETERS
    where parameter = 'NLS_DATE_FORMAT';
    alter session set NLS_DATE_FORMAT = 'yy/mm/dd';
    select ename, sal from emp where hiredate = '81/11/17';
    alter session set NLS_DATE_FORMAT = 'rr/mm/dd';

    //009.산술 연산자 배우기(*,/,+,-)
    select ename, sal*12 as 연봉 from emp where sal*12 >= 36000;
    select 300+200*2 from dual;
    select (300+200) * 2 from dual;
    select ename, sal, comm, sal + comm from emp where deptno = 10;
    select sal + comm from emp where ename = 'KING';
    select sal + NVL(comm, 0) from emp where ename = 'KING';

    //010.비교 연산자 배우기 1 (>, <, >=, <=, =, !=, <>, ^=)
    select ename, sal, job, deptno from emp where sal <= 1200;

    //011. 비교 연산자 배우기 2 (BETEWEEN AND)
    select ename, sal from emp where sal between 1000 and 3000;
    select ename, sal from emp where (sal >= 1000 and sal <= 3000);
    select ename, sal from emp where sal between 1000 and 3000;
    select ename, sal from emp where sal not between 1000 and 3000;
    select ename, sal from emp where (sal < 1000 or sal > 3000);
    select ename, hiredate from emp where hiredate between '1982/01/01' and '1982/12/31'; 

    //012. 비교 연산자 배우기 3 (LIKE)
    select ename, sal from emp where ename like 'S%';
    select ename from emp where ename like '_M%';
    select ename from emp where ename like '%T';
    select ename from emp where ename like '%A%';
    
    //013. 비교 연산자 배우기 4 (IS NULL)
    select ename, comm from emp where comm is null;
    
    //014. 비교 연산자 배우기 5 (IN)
    select ename, sal, job from emp where job in ('SALESMAN', 'ANALYST', 'MANAGER');
    select ename, sal job from emp where (job = 'SALESMAN' or job = 'ANALYST' or job = 'MANAGER');
    select ename, sal, job from emp where job not in ('SALESMAN', 'ANALYST', 'MANAGER');
    select ename, sal, job from emp where (job != 'SALESMAN' and job != 'ANALYST' and job != 'MANAGER');
    
    //015. 논리 연산자 배우기 (AND, OR, NOT)
    select ename, sal, job from emp where job = 'SALESMAN' and sal >= 1200;
    select ename, sal, job from emp where job = 'ABCDEFG' and sal >= 1200;
    
    --PART 1 END

