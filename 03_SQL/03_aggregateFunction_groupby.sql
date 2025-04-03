/* **************************************************************************
집계(Aggregation) 함수와 GROUP BY, HAVING
************************************************************************** */

/* ******************************************************************************************
# 집계함수, 그룹함수, 다중행 함수

- 인수(argument)는 컬럼.
  - sum(): 전체합계
  - avg(): 평균
  - min(): 최소값
  - max(): 최대값
  - stddev(): 표준편차
  - variance(): 분산
  - count(): 개수
        - 인수: 
            - 컬럼명: null을 제외한 값들의 개수.
            -  *: 총 행수 - null과 관계 없이 센다.
  - count(distinct 컬럼명): 고유값의 개수.
  
- count(*) 를 제외한 모든 집계함수들은 null을 제외하고 집계한다. 
	- (avg, stddev, variance는 주의)
	- avg(), variance(), stddev()은 전체 개수가 아니라 null을 제외한 값들의 평균, 분산, 표준편차값이 된다.=>avg(ifnull(컬럼, 0))
- 문자타입/일시타입: max(), min(), count()에만 사용가능
	- 문자열 컬럼의 max(): 사전식 배열에서 가장 마지막 문자열, min()은 첫번째 문자열. 
	- 일시타입 컬럼은 오래된 값일 수록 작은 값이다.

******************************************************************************************* */

-- EMP 테이블에서 급여(salary)의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 총직원수를 조회 
select sum(salary), avg(salary), min(salary), max(salary), stddev(salary), variance(salary), count(salary) from EMP

-- EMP 테이블에서 가장 최근 입사일(hire_date)과 가장 오래된 입사일을 조회
select max(hire_date), min(hire_date) from EMP

-- EMP 테이블의 부서(dept_name) 의 개수를 조회
select count(dept_name) from EMP

--  커미션 비율(comm_pct)이 있는 직원의 수를 조회
select count(comm_pct) from EMP

--  최고 급여액과 최저 급여액 그리고 그 둘의 차액을 출력
select max(salary) - min(salary) from EMP

-- 가장 긴 직원 이름(emp_name)이 몇글자 인지 조회.
select count(max(emp_name)) from EMP


/* **************
group by 절
- 특정 컬럼(들)의 값별로 행들을 나누어 집계할 때 기준컬럼을 지정하는 구문. (~~별 ~~에대한 집계)
	- 예) 업무별 급여평균. 부서-업무별 급여 합계. 성별 나이평균
- 구문
  - group by 컬럼명 [, 컬럼명]
    - 컬럼명
      - 집계를 위해 group으로 묶어줄 기준 컬럼명을 지정한다.
      - select절에 기준컬럼을 지정한 경우 컬럼 순번(1부터 시작)으로 지정할 수있다.
      - 지정한 기준 컬럼(들)이 같은 값을 가지는 행들이 같은 그룹으로 묶인다.
      - 같은 그룹으로 묶인 행들의 값을 기준으로 집계한다.
      - 기준 컬럼은 범주형 컬럼을 사용한다. 부서별 급여 평균 => 부서컬럼, 성별 급여 합계 => 성별컬럼
	- group by 절은 select의 where 절 다음에 기술한다.
	- select 절의 컬럼은 group by 에서 선언한 기준 컬럼들만 집계함수와 같이 올 수 있다.
	
****************/

-- 업무(job)별 급여의 총합계, 평균, 최소값, 최대값, 표준편차, 분산, 직원수를 조회
select sum(salary), avg(salary), min(salary), max(salary), stddev(salary), variance(salary), count(salary) from EMP group by job

-- 입사연도 별 직원들의 급여 평균.
select avg(salary) group by year(hire_date)

-- 부서명(dept_name) 이 'Sales'이거나 'Purchasing' 인 직원들의 업무별 (job) 직원수를 조회. 직원수가 많은 순서대로 정렬.
select count(salary) where dept_name = 'Sales' or dept_name = 'Purchasing' group by job 

-- 부서(dept_name), 업무(job) 별 최대, 평균급여(salary)를 조회.
select max(salary), avg(salary) group by dept_name, job

-- 급여(salary) 범위별 직원수를 출력. 급여 범위는 10000 미만,  10000이상 두 범주.
select count(salary) group by (salary < 10000), (salary >= 10000)

-- 부서명(dept_name), 업무(job)별 직원수, 최고급여(salary)를 조회. 부서이름으로 오름차순 정렬.
select count(salary), max(salary) group by dept_name, job from EMP order by dept_name asc 

-- 입사년도와(hire_date) 업무(job)가 같은 직원들의 평균 급여(salary)을 조회
select avg(salary) group by hire_date, job

-- 부서별(dept_name) 직원수 조회하는데 부서명(dept_name)이 null인 것은 제외하고 조회.
select count(salary) where dept_name is not null group by dept_name


/* **************************************************************
having 절
- group by 로 나뉜 그룹을 filtering 하기 위한 조건을 정의하는 구문.
- group by 다음 order by 전에 온다.
- 구문
    having 제약조건  
		- 연산자는 where절의 연산자를 사용한다. 
		- 피연산자는 집계함수(의 결과)
		
-  where절은 행을 filtering한다.
   having절은 group by 로 묶인 그룹들을 filtering한다.		
************************************************************** */

-- 직원수가 10명 이상인 부서의 부서명과 그 부서 직원들의 평균 급여를 조회.
select avg(salary) group by dept_name having count(salary) >= 10 

-- 20명 이상이 입사한 년도와 (그 해에) 입사한 직원수를 조회.
select count(emp_id) group by year(hire_date) having count(salary) >= 20

-- 평균 급여가(salary) $5000 이상인 부서의 이름(dept_name)과 평균 급여(salary), 직원수를 조회
select dept_name, avg(salary), count(emp_id) group by dept_name having avg(salary) >= 5000 

-- 평균급여가 $5,000 이상이고 총급여가 $50,000 이상인 부서의 부서명(dept_name), 평균급여와 총급여를 조회
select dept_name, avg(salary), sum(salary) gropu by 

--  커미션이 있는 직원들의 입사년도별 평균 급여를 조회. 단 평균 급여가 $9,000 이상인 년도분만 조회.




