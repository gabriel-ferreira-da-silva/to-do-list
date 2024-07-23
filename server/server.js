const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');


const app = express();
const port = 8080;


app.use(cors({
    origin: '*', 
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type']
}));

app.use(express.static(path.join(__dirname, 'public')));

app.use(bodyParser.json());

const pool = mysql.createPool({
    host: 'localhost',
    user: 'todouser',
    password: 'todouser',
    database: 'TODOLISTDB'
});

app.post('/authenticate', (req, res) => {
    const { name, senha } = req.body;
    console.log('Incoming authentication request:', name, senha);

    const query = 'SELECT * FROM users WHERE name=? AND password = ?';
    pool.query(query, [name, senha], (err, results) => {
        if (err) {
            return res.status(500).json({ valid: false, error: err.message });
        }
        
        if (results.length > 0) {
            console.log("the aujthetication successd")
            res.status(200).json({ valid: true, id: results[0].id });
        } else {
            console.log("the aujthetication error")

            res.status(401).json({ valid: false });
        }
    });
});


app.get('/users', (req, res) => {
    const query = 'SELECT * FROM users';
    pool.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(200).json(results);
    });
});

app.get('/tasks', (req, res) => {
    const query = 'SELECT * FROM tasks';
    pool.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(200).json(results);
    });
});


app.get('/tasks/byuser/:userid', (req, res) => {
    const userId = req.params.userid;
    const query = 'SELECT * FROM tasks WHERE user_id = ?';
    console.log("tasks byuser request made :", userId, typeof(userId))
    pool.query(query,[userId],(err, results) => {
        if (err) {
            console.log("tasks byuser request error:", userId, typeof(userId))  
            return res.status(500).json({ error: err.message });
        }
        console.log("tasks byuser request has sucessef :", userId, typeof(userId))
        res.status(200).json(results);
    });
});


app.get('/users/:userid', (req, res) => {
    const userId = req.params.userid;
    const query = 'SELECT * FROM users WHERE id = ?';
    pool.query(query,[userId],(err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(200).json(results);
    });
});



app.post('/users', (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ error: 'Name, email, and password are required' });
    }

    const query = 'INSERT INTO users (name, email, password) VALUES (?, ?, ?)';
    pool.query(query, [name, email, password], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(201).json({ id: results.insertId, name, email });
    });
});

app.post('/tasks', (req, res) => {
    const { name, description, priority, isEnded, due_date, user_id } = req.body;

    if (!name || !priority || !isEnded || !user_id) {
        return res.status(400).json({ error: 'Name, priority, isEnded, and user_id are required' });
    }

    console.log("request to create task",name,description,priority,isEnded,due_date,user_id)

    const query = 'INSERT INTO tasks (name, description, priority, isEnded, due_date, user_id) VALUES (?, ?, ?, ?, ?, ?)';
    pool.query(query, [name, description, priority, isEnded, due_date, user_id], (err, results) => {
        if (err) {
            console.log("fail to create")
            return res.status(500).json({ error: err.message });
        }
        console.log("sucesd to create")
        res.status(201).json({ id: results.insertId, name, description, priority, isEnded, due_date, user_id });
    });
});

app.delete('/users/:id', (req, res) => {
    const userId = req.params.id;

    const query = 'DELETE FROM users WHERE id = ?';
    pool.query(query, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        res.status(200).json({ message: 'User deleted successfully' });
    });
});

app.delete('/tasks/:id', (req, res) => {
    const taskId = req.params.id;

    const query = 'DELETE FROM tasks WHERE id = ?';
    pool.query(query, [taskId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ error: 'Task not found' });
        }
        res.status(200).json({ message: 'Task deleted successfully' });
    });
});

app.put('/users/:id', (req, res) => {
    const userId = req.params.id;
    const { name, email, password } = req.body;

    if (!name && !email && !password) {
        return res.status(400).json({ error: 'At least one field (name, email, or password) is required to update' });
    }

    const fields = [];
    const values = [];
    if (name) {
        fields.push('name = ?');
        values.push(name);
    }
    if (email) {
        fields.push('email = ?');
        values.push(email);
    }
    if (password) {
        fields.push('password = ?');
        values.push(password);
    }
    values.push(userId);

    const query = `UPDATE users SET ${fields.join(', ')} WHERE id = ?`;
    pool.query(query, values, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ error: 'User not found' });
        }
        res.status(200).json({ message: 'User updated successfully' });
    });
});

app.put('/tasks/:id', (req, res) => {
    const taskId = req.params.id;
    const { name, description, priority, isEnded, due_date, user_id } = req.body;

    if (!name && !description && !priority && !isEnded && !due_date && !user_id) {
        return res.status(400).json({ error: 'At least one field (name, description, priority, isEnded, due_date, or user_id) is required to update' });
    }

    const fields = [];
    const values = [];
    if (name) {
        fields.push('name = ?');
        values.push(name);
    }
    if (description) {
        fields.push('description = ?');
        values.push(description);
    }
    if (priority) {
        fields.push('priority = ?');
        values.push(priority);
    }
    if (isEnded) {
        fields.push('isEnded = ?');
        values.push(isEnded);
    }
    if (due_date) {
        fields.push('due_date = ?');
        values.push(due_date);
    }
    if (user_id) {
        fields.push('user_id = ?');
        values.push(user_id);
    }
    values.push(taskId);

    const query = `UPDATE tasks SET ${fields.join(', ')} WHERE id = ?`;
    pool.query(query, values, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ error: 'Task not found' });
        }
        res.status(200).json({ message: 'Task updated successfully' });
    });
});


app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
