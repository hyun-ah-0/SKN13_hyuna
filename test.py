import streamlit as st


# 초기 로그 설정
if "current_page" not in st.session_state:
    st.session_state.current_page = "home"
if "history" not in st.session_state:
    st.session_state.history = []

# 함수: 페이지 이동
 
# 해당 페이지로 이동(forward)
def go_to(page: str) -> None:
    st.session_state.history.append(st.session_state.current_page)
    st.session_state.current_page = page

# 이전 페이지로 이동(backward)
def go_back()   -> None:
    if st.session_state.current_page != "home":
        st.session_state.current_page = st.session_state.history.pop()    



# 함수: 페이지 구현

# 홈
def home():
    st.title("자동자보험정보시스템")
    left_col, right_col = st.columns(2)
    with left_col:
        st.button("구분별 조회", on_click = lambda: go_to("구분별 페이지"))
    with right_col:
        st.button("보험사별 조회", on_click = lambda: go_to("보험사별 페이지"))

# 구분별: 일단 기능 구현 안해서 pass로 설정했습니다.
def select_condition():
    pass

# 보험사별
def select_company():
    st.title("보험사를 선택해주세요.")
    st.button("삼성화재", on_click = lambda: go_to("삼성화재 페이지"))
    st.button("현대해상", on_click = lambda: go_to("현대해상 페이지"))
    st.button("DB손해보험", on_click = lambda: go_to("DB손해보험 페이지"))
 


# 보험사 detail 파일 불러오기
import pymysql
import pandas as pd

# DB 연결
conn = pymysql.connect(
    host='127.0.0.1',          # 또는 DB 주소
    user='SKN13',
    password='1111',
    database='car_insurance',
    charset='utf8mb4',         # 한글 깨짐 방지
   # cursorclass=pymysql.cursors.DictCursor  # 딕셔너리 형태로 가져오기
)

# 쿼리 작성
query = "SELECT * FROM car_number"

# pandas로 DataFrame 불러오기
insurance_detail = pd.read_sql(query, conn)

# 대표번호 불러오기
def number(int):
    number = insurance_detail[['회사명', '대표번호']]
    return number.iloc[int,1]

# 상담센터 url 불러오기
def consult(int):
    url = insurance_detail[['상담센터', '민원창구']]
    return url.iloc[int,0]

# 민원창구 url 불러오기
def complain(int):
    url = insurance_detail[['상담센터', '민원창구']]
    return url.iloc[int,1]


# 보험사별: 삼성
def samsung():
    st.title("삼성화재")
    st.subheader("대표번호")
    st.text(number(5))
    st.subheader("상담센터")
    st.text(consult(5))
    st.subheader("대표번호")
    st.text(complain(5))


# 보험사별: 현대
def hyundai():
    st.title("현대해상")
    st.subheader("대표번호")
    st.text(number(6))
    st.subheader("상담센터")
    st.text(consult(6))
    st.subheader("대표번호")
    st.text(complain(6))    


# 보험사별: DB
def db_insu():
    st.title("DB손해보험")
    st.subheader("대표번호")
    st.text(number(8))
    st.subheader("상담센터")
    st.text(consult(8))
    st.subheader("대표번호")
    st.text(complain(8))


# 보험사별: meritz
def meritz():
    st.title("메리츠화재보험")
    st.subheader("대표번호")
    st.text(number(0))
    st.subheader("상담센터")
    st.text(consult(0))
    st.subheader("대표번호")
    st.text(complain(0))

# 보험사별: 한화
def db_insu():
    st.title("한화손해보험")
    st.subheader("대표번호")
    st.text(number(1))
    st.subheader("상담센터")
    st.text(consult(1))
    st.subheader("대표번호")
    st.text(complain(1))

# 보험사별: 롯데
def db_insu():
    st.title("롯데손해보험")
    st.subheader("대표번호")
    st.text(number(2))
    st.subheader("상담센터")
    st.text(consult(2))
    st.subheader("대표번호")
    st.text(complain(2))

# 보험사별: MG
def db_insu():
    st.title("MG손해보험")
    st.subheader("대표번호")
    st.text(number(3))
    st.subheader("상담센터")
    st.text(consult(3))
    st.subheader("대표번호")
    st.text(complain(3))

# 보험사별: 흥국
def db_insu():
    st.title("흥국화재손해보험")
    st.subheader("대표번호")
    st.text(number(8))
    st.subheader("상담센터")
    st.text(consult(8))
    st.subheader("대표번호")
    st.text(complain(8))

    

# 딕셔너리에 페이지와 함수 매핑
pages = {
    "home":home,
    "구분별 페이지": select_condition,
    "보험사별 페이지": select_company,
    "삼성화재 페이지": samsung,
    "현대해상 페이지": hyundai,
    "DB손해보험 페이지": db_insu

}

# pages라는 딕셔너리에서 key로 value 불러오기 -> 함수 호출
pages[st.session_state.current_page]()

# 뒤로가기는 홈화면에선 보여주지 마세요.
if st.session_state.current_page != "home":
    st.button("⬅", on_click=go_back)


# 그냥 커스텀어트리뷰트 current_page랑 history 실시간 조회.
st.write(f"현재 페이지: {st.session_state.current_page}")
st.write(f"페이지 로그 스택 방식으로 저장한 거 보여줄게요: {st.session_state.history}")