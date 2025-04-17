// badCode.js

var name = "John"

function sayHello(name) {
    if(name){
        console.log("Hello " + name)
    }
    else {
        console.log("Hello stranger")
    }
}

sayHello()
sayHello("Alice")

const numbers = [1,2,3,4,5]
for (var i = 0; i < numbers.length; i++) {
  console.log(numbers[i])
}

function unusedFunction() {
    return "This function is never used"
}

console.log('This is unsafe')

const obj = {
  foo: "baz"
}

// ユーザー入力を直接 eval に渡している（非常に危険）
function runUserCode(code) {
  eval(code); // 🚨 セキュリティリスク：任意コード実行
}

// パスワードが平文で保存されている（NG）
const users = [
  { username: 'admin', password: '123456' }, // 🚨 弱いパスワード + 平文保存
];

// SQLインジェクションが可能な構文（仮想の DB ライブラリを使用）
function findUserByUsername(username) {
  const query = "SELECT * FROM users WHERE username = '" + username + "';";
  db.query(query, function (err, result) {
    if (err) throw err;
    console.log(result);
  });
}

// XSS脆弱性のあるコード（HTML にユーザー入力をそのまま埋め込む）
function showComment(comment) {
  document.getElementById('comments').innerHTML += `<p>${comment}</p>`;
}

// fetch のレスポンス処理を try/catch していない（例外発生時にクラッシュ）
function fetchData(url) {
  fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log(data.user.name);
    });
}

// クロスサイトリクエストフォージェリ対策なしのフォーム送信
function submitForm() {
  fetch('/submit', {
    method: 'POST',
    body: new FormData(document.getElementById('form')),
  });
}
