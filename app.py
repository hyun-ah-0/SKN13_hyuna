import streamlit as st
import pandas as pd

st.set_page_config(page_title="나만의 Streamlit 앱", layout="centered")

st.title("🚗 자동차 보험 할인 특약 조회기")
st.write("이 페이지는 당신에게 적용 가능한 할인 특약을 안내해드립니다.")

# 사용자 입력 받기
age = st.number_input("나이를 입력해주세요", min_value=18, max_value=100, value=30)
drive_years = st.slider("운전 경력 (년)", 0, 50, 5)

# 결과 표시
if age < 25:
    st.warning("만 25세 미만은 일부 특약 적용이 제한될 수 있어요.")
else:
    st.success("특약 대상입니다! 🎉")

# 테이블 표시 예시
data = {
    '특약명': ['블랙박스', '자녀 할인', '무사고 할인'],
    '할인율': ['5%', '10%', '15%']
}
df = pd.DataFrame(data)
st.table(df)
