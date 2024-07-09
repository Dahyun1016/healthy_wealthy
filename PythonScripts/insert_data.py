
import pymysql
import pandas as pd

print("Starting the script...")

# CSV 파일 경로
file_path = 'C:/Users/choil/Projects/PythonScripts/OpenData_PotOpenTabletIdntfcC20240709.csv'

print("Loading CSV file from:", file_path)
# CSV 파일 로드
try:
    data = pd.read_csv(file_path)
    print("CSV file loaded successfully.")
except Exception as e:
    print(f"Error loading CSV file: {e}")
    exit(1)

selected_columns = ['품목명', '업소명', '큰제품이미지', '의약품제형', '색상앞', '색상뒤', '표시앞', '표시뒤', '분류명', '전문일반구분']
filtered_data = data[selected_columns]
print("Filtered data prepared.")

# MySQL 연결 설정
print("Connecting to MySQL...")
try:
    connection = pymysql.connect(
        host='127.0.0.1',  # MySQL 서버 호스트 이름
        user='root',  # MySQL 사용자 이름
        password='1234',  # MySQL 사용자 비밀번호
        db='wealthy',  # 사용할 데이터베이스 이름
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    print("Connected to MySQL.")
except Exception as e:
    print(f"Error connecting to MySQL: {e}")
    exit(1)

try:
    with connection.cursor() as cursor:
        # 데이터 삽입 쿼리
        sql = """
        INSERT INTO medical_data (
            product_name, company_name, product_image, drug_form, 
            color_front, color_back, mark_front, mark_back, category_name, prescription_type
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        print("Inserting data into the database...")
        
        # 각 행을 데이터베이스에 삽입
        for index, row in filtered_data.iterrows():
            try:
                cursor.execute(sql, (
                    row['품목명'], row['업소명'], row['큰제품이미지'], row['의약품제형'],
                    row['색상앞'], row['색상뒤'], row['표시앞'], row['표시뒤'], row['분류명'], row['전문일반구분']
                ))
            except Exception as e:
                print(f"Error inserting row {index}: {e}")
                continue
        
        # 변경 사항 커밋
        connection.commit()
        print("Data inserted successfully.")
finally:
    connection.close()
    print("MySQL connection closed.")
