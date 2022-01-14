const express = require('express');
const app = express();
const mySql = require('mysql');
const jwt = require('jsonwebtoken');

let conStr = { host: "localhost", user: "root", password: "", database: "library" };
const jwtSecreat = 'inapp-nodejs';

const con = mySql.createConnection(conStr);
app.listen(3000);

app.use(express.json());
app.use(log);

//booklist
app.get('/books', (req, res) => {
    let qry = 'select * from books';
    con.query(qry, (err, data) => {
        if (err) res.send({ error: "some error occur" })
        if (data.length)
            res.json(data);
        else
            res.send({ error: "no data" })
    })
})

//user lgoin with jwt token generating
app.post('/auth_user', (req, res) => {
    let user_name = req.body.user_name;
    let user_password = req.body.user_password;
    if (user_name && user_password) {
        let qry = `select * from users where user_name='${user_name}' and user_password=MD5('${user_password}') `;
        con.query(qry, (err, data) => {
            if (err || data.length == 0) res.send({ error: "Some error occur" });
            else {
                let resp = { id: data[0].user_id, name: data[0].user_displayname };
                let token = jwt.sign(resp, jwtSecreat, { expiresIn: 600 });
                res.send({ success: "successfully authenticated", token: token });
            }
        })
    } else res.send({ error: "Please enter all data" });
})

//new book
app.post('/new_book', verifyJWT, (req, res) => {
    let book_name = req.body.book_name;
    let book_auther = req.body.book_auther;
    let book_description = req.body.book_description;
    let book_publishedby = req.body.book_publishedby;
    if (book_name && book_auther) {
        let qry = `insert into books(book_name,book_auther,book_description,book_publishedby) values('${book_name}','${book_auther}','${book_description}','${book_publishedby}')`;
        con.query(qry, (err, data) => {
            if (err) res.send({ error: "Some error occur" })
            let selqry = `select * from books where book_id=${data.insertId}`;
            con.query(selqry, (errs, datas) => {
                if (errs) res.send({ error: "some error occur" })
                if (datas.length)
                    res.send({ success: "successfully added", data: datas })
            })

        })
    } else res.send({ error: "Please enter all data" })
})

//update book
app.post('/update_book', verifyJWT, (req, res) => {
    let book_name = req.body.book_name;
    let book_auther = req.body.book_auther;
    let book_description = req.body.book_description;
    let book_publishedby = req.body.book_publishedby;
    let book_id = req.body.book_id;
    if (book_name && book_auther && book_id) {
        let qry = `update books set book_name='${book_name}',book_auther='${book_auther}',book_description='${book_description}',book_publishedby='${book_publishedby}' where book_id=${book_id}`;
        con.query(qry, (err, data) => {
            if (err) res.send({ error: "Some error occur" })
            res.send({ success: "successfully Updated" })
        })
    } else res.send({ error: "Please enter all data" })
})

//middleware - jwt verification
function verifyJWT(req, res, next) {
    let auth = req.headers.authorization;
    if (auth) {
        let tkn = auth.split(" ")[1];
        jwt.verify(tkn, jwtSecreat, (err, decoded) => {
            if (err) res.status(500).send({ error: "Authentication failed" })
            else
                next();
        })
    } else
        res.status(401).send({ error: "Token not provided" });
}

//logging

function log(req, res, next) {
    res.setHeader('Inapp', 'Bibin-Machine test');
    
    const { rawHeaders, httpVersion, method, socket, url } = req;
    const { remoteAddress, remoteFamily } = socket;
    let qry = `insert into log_request(log_url,log_raw_header,log_remote_address,log_http_version,log_remote_family,log_req_method) values('${url}','${rawHeaders}','${remoteAddress}','${httpVersion}','${remoteFamily}','${method}')`;
    con.query(qry);
    next();
}