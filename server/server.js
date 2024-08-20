const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'wealthy'
});

db.connect((err) => {
  if (err) {
    console.error('MySQL 연결 오류:', err);
    throw err;
  }
  console.log('MySQL 연결 성공...');
});

// 로그인 엔드포인트
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  console.log('로그인 시도:', username, password);

  const query = 'SELECT id FROM users WHERE id = ? AND password = ?';
  db.query(query, [username, password], (err, results) => {
    if (err) {
      console.error('로그인 오류:', err);
      res.status(500).send('로그인 중 오류가 발생했습니다.');
      return;
    }

    if (results.length > 0) {
      res.status(200).json({ userId: results[0].id });
    } else {
      res.status(401).send('로그인에 실패했습니다. 다시 시도해 주세요.');
    }
  });
});

app.post('/register', (req, res) => {
  const { id, password, name, gender, age, phone } = req.body;

  const query = 'INSERT INTO users (id, password, name, gender, age, phone) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(query, [id, password, name, gender, age, phone], (err, result) => {
    if (err) {
      console.error('데이터 삽입 오류:', err);
      res.status(500).send('회원가입 중 오류가 발생했습니다.');
      return;
    }
    res.status(200).send('회원가입이 성공적으로 완료되었습니다.');
  });
});

// 약물 정보 검색 엔드포인트 추가
app.get('/search', (req, res) => {
  const searchTerm = req.query.term;
  const query = `
    SELECT product_name, product_image 
    FROM medical_data 
    WHERE product_name LIKE ?`;
  db.query(query, [`%${searchTerm}%`], (err, results) => {
    if (err) {
      console.error('데이터베이스 검색 오류:', err);
      res.status(500).send('데이터베이스 검색 중 오류가 발생했습니다.');
      return;
    }
    res.json(results);
  });
});


// 사용자 약물 정보 저장 엔드포인트
app.post('/user/medications', (req, res) => {
  const { userId, medications, date } = req.body;

  const query = `
    INSERT INTO user_medications (user_id, medication, taken, date)
    VALUES ?
    ON DUPLICATE KEY UPDATE taken=VALUES(taken)
  `;
  const values = medications.map(medication => [userId, medication.name, medication.taken, date]);

  db.query(query, [values], (err, result) => {
    if (err) {
      console.error('데이터 저장 오류:', err);
      res.status(500).send('데이터 저장 중 오류가 발생했습니다.');
      return;
    }
    res.status(200).send('데이터 저장이 성공적으로 완료되었습니다.');
  });
});

// 사용자 약물 정보 불러오기 엔드포인트
app.get('/user/medications', (req, res) => {
  const { userId, date } = req.query;

  const query = 'SELECT medication, taken FROM user_medications WHERE user_id = ? AND date = ?';
  db.query(query, [userId, date], (err, results) => {
    if (err) {
      console.error('데이터 불러오기 오류:', err);
      res.status(500).send('데이터 불러오기 중 오류가 발생했습니다.');
      return;
    }
    res.json(results.map(row => ({ name: row.medication, taken: row.taken })));
  });
});

// 사용자 약물 정보 삭제 엔드포인트
app.delete('/user/medications', (req, res) => {
  const { userId, medication, date } = req.query;

  const query = 'DELETE FROM user_medications WHERE user_id = ? AND medication = ? AND date = ?';
  db.query(query, [userId, medication, date], (err, result) => {
    if (err) {
      console.error('데이터 삭제 오류:', err);
      res.status(500).send('데이터 삭제 중 오류가 발생했습니다.');
      return;
    }
    res.status(200).send('데이터 삭제가 성공적으로 완료되었습니다.');
  });
});

app.listen(port, () => {
  console.log(`서버가 실행 중입니다: http://localhost:${port}`);
});

// 사용자 정보 가져오기 엔드포인트
app.get('/user/info', (req, res) => {
  const userId = req.query.userId;

  const query = 'SELECT name, gender, age FROM users WHERE id = ?';
  db.query(query, [userId], (err, results) => {
    if (err) {
      console.error('사용자 정보 가져오기 오류:', err);
      res.status(500).send('사용자 정보 가져오기 중 오류가 발생했습니다.');
      return;
    }

    if (results.length > 0) {
      res.json(results[0]);
    } else {
      res.status(404).send('사용자를 찾을 수 없습니다.');
    }
  });
});
