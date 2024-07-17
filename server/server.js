const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;  // 서버가 실행되는 포트 번호

app.use(cors());
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',  // 실제 MySQL 비밀번호로 변경
  database: 'wealthy'  // 데이터베이스 이름이 'wealthy'인지 확인
});

db.connect((err) => {
  if (err) {
    console.error('MySQL 연결 오류:', err);
    throw err;
  }
  console.log('MySQL 연결 성공...');
});

app.post('/register', (req, res) => {
  const { id, password, name, gender, age, phone } = req.body;

  console.log('받은 요청:', req.body);

  const query = 'INSERT INTO users (id, password, name, gender, age, phone) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(query, [id, password, name, gender, age, phone], (err, result) => {
    if (err) {
      console.error('데이터 삽입 오류:', err);
      res.status(500).send('회원가입 중 오류가 발생했습니다.');
      return;
    }
    console.log('데이터 삽입 성공:', result);
    res.status(200).send('회원가입이 성공적으로 완료되었습니다.');
  });
});

app.post('/login', (req, res) => {
  const { id, password } = req.body;

  console.log('로그인 요청:', req.body);

  const query = 'SELECT * FROM users WHERE id = ? AND password = ?';
  db.query(query, [id, password], (err, result) => {
    if (err) {
      console.error('로그인 오류:', err);
      res.status(500).send('로그인 중 오류가 발생했습니다.');
      return;
    }

    if (result.length > 0) {
      console.log('로그인 성공:', result);
      res.status(200).send('로그인이 성공적으로 완료되었습니다.');
    } else {
      console.log('로그인 실패: 사용자 정보를 찾을 수 없습니다.');
      res.status(401).send('로그인에 실패했습니다. 다시 시도해 주세요.');
    }
  });
});

// 생리 주기 데이터 저장
app.post('/save-period', (req, res) => {
  const { userId, startDate, endDate } = req.body;

  const query = 'INSERT INTO periods (user_id, start_date, end_date) VALUES (?, ?, ?)';
  db.query(query, [userId, startDate, endDate], (err, result) => {
    if (err) {
      console.error('생리 주기 데이터 삽입 오류:', err);
      res.status(500).send('생리 주기 데이터 저장 중 오류가 발생했습니다.');
      return;
    }
    res.status(200).send('생리 주기 데이터가 성공적으로 저장되었습니다.');
  });
});

// 기분 데이터 저장
app.post('/save-mood', (req, res) => {
  const { userId, date, mood } = req.body;

  const query = 'INSERT INTO moods (user_id, date, mood) VALUES (?, ?, ?)';
  db.query(query, [userId, date, mood], (err, result) => {
    if (err) {
      console.error('기분 데이터 삽입 오류:', err);
      res.status(500).send('기분 데이터 저장 중 오류가 발생했습니다.');
      return;
    }
    res.status(200).send('기분 데이터가 성공적으로 저장되었습니다.');
  });
});

app.listen(port, () => {
  console.log(`서버가 실행 중입니다: http://localhost:${port}`);
});

