const express = require('express');
const db = require('./db');
const fs = require('fs');
const path = require('path');
const { v4: uuidv4, validate: validateUUID } = require('uuid');
const app = express();
const PORT = 3000;

app.use(express.json());

const isUUID = (id) => validateUUID(id);

// ---------- Specialties ----------

app.get('/specialties', async (req, res) => {
    const result = await db.all('SELECT * FROM specialties');
    res.json(result);
});

app.post('/specialties', async (req, res) => {
    const { name } = req.body;
    const id = uuidv4();
    await db.run('INSERT INTO specialties (id, name) VALUES (?, ?)', [id, name]);
    res.status(201).json({ id, name });
});

app.put('/specialties/:id', async (req, res) => {
    const { id } = req.params;
    const { name } = req.body;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('UPDATE specialties SET name = ? WHERE id = ?', [name, id]);
    res.json({ message: 'Specialty updated', id });
});

app.delete('/specialties/:id', async (req, res) => {
    const { id } = req.params;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('DELETE FROM specialties WHERE id = ?', [id]);
    res.json({ message: 'Specialty deleted', id });
});

// ---------- Doctors ----------

app.get('/doctors', async (req, res) => {
    const result = await db.all('SELECT * FROM doctors');
    res.json(result);
});

app.post('/doctors', async (req, res) => {
    const { name, email, specialty_id } = req.body;
    const id = uuidv4();
    await db.run('INSERT INTO doctors (id, name, email, specialty_id) VALUES (?, ?, ?, ?)', [id, name, email, specialty_id]);
    res.status(201).json({ id, name, email, specialty_id });
});

app.put('/doctors/:id', async (req, res) => {
    const { id } = req.params;
    const { name, email, specialty_id } = req.body;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('UPDATE doctors SET name = ?, email = ?, specialty_id = ? WHERE id = ?', [name, email, specialty_id, id]);
    res.json({ message: 'Doctor updated', id });
});

app.delete('/doctors/:id', async (req, res) => {
    const { id } = req.params;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('DELETE FROM doctors WHERE id = ?', [id]);
    res.json({ message: 'Doctor deleted', id });
});

// ---------- Patients ----------

app.get('/patients', async (req, res) => {
    const result = await db.all('SELECT * FROM patients');
    res.json(result);
});

app.post('/patients', async (req, res) => {
    const { name, email, birthdate } = req.body;
    const id = uuidv4();
    await db.run('INSERT INTO patients (id, name, email, birthdate) VALUES (?, ?, ?, ?)', [id, name, email, birthdate]);
    res.status(201).json({ id, name, email, birthdate });
});

app.put('/patients/:id', async (req, res) => {
    const { id } = req.params;
    const { name, email, birthdate } = req.body;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('UPDATE patients SET name = ?, email = ?, birthdate = ? WHERE id = ?', [name, email, birthdate, id]);
    res.json({ message: 'Patient updated', id });
});

app.delete('/patients/:id', async (req, res) => {
    const { id } = req.params;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('DELETE FROM patients WHERE id = ?', [id]);
    res.json({ message: 'Patient deleted', id });
});

// ---------- Appointments ----------

app.get('/appointments', async (req, res) => {
    const result = await db.all('SELECT * FROM appointments');
    res.json(result);
});

app.post('/appointments', async (req, res) => {
    const { doctor_id, patient_id, date, time, notes } = req.body;
    const id = uuidv4();
    await db.run('INSERT INTO appointments (id, doctor_id, patient_id, date, time, notes) VALUES (?, ?, ?, ?, ?, ?)', [id, doctor_id, patient_id, date, time, notes]);
    res.status(201).json({ id, doctor_id, patient_id, date, time, notes });
});

app.put('/appointments/:id', async (req, res) => {
    const { id } = req.params;
    const { doctor_id, patient_id, date, time, notes } = req.body;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('UPDATE appointments SET doctor_id = ?, patient_id = ?, date = ?, time = ?, notes = ? WHERE id = ?', [doctor_id, patient_id, date, time, notes, id]);
    res.json({ message: 'Appointment updated', id });
});

app.delete('/appointments/:id', async (req, res) => {
    const { id } = req.params;
    if (!isUUID(id)) return res.status(400).json({ error: 'Invalid UUID' });
    await db.run('DELETE FROM appointments WHERE id = ?', [id]);
    res.json({ message: 'Appointment deleted', id });
});

// ---------- OpenAPI Spec Route ----------

app.get('/open-api', (req, res) => {
    const filePath = path.join(__dirname, '../openapi.yaml');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error loading openapi.yaml:', err);
            return res.status(500).json({ error: 'Failed to load OpenAPI spec' });
        }
        res.setHeader('Content-Type', 'application/x-yaml');
        res.send(data);
    });
});

// ---------- Start Server ----------

app.listen(PORT, () => {
    console.log(`🚀 Medical API running at http://localhost:${PORT}`);
});
