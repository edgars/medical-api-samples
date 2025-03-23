# 🏥 Medical API

A RESTful API for managing **doctors**, **specialties**, **patients**, and **appointments**.  
Built with **Node.js**, **Express**, **SQLite**, and **Docker** — all data identified by UUIDs.

---

## 🚀 Features

- Full CRUD for:
  - 🔹 Doctors
  - 🔹 Specialties
  - 🔹 Patients
  - 🔹 Appointments
- Pre-populated SQLite database (with 17 patients, 9 doctors, 78 appointments)
- UUID primary keys
- Exposes OpenAPI spec via `/open-api`
- Ready-to-import Postman Collection
- Dockerized: all-in-one deployment

---

## 📦 Project Structure

```
.
├── Dockerfile
├── LICENSE
├── README.md
├── build.sh
├── db
│   └── seed.sql
├── openapi.yaml
├── package.json
├── postman_collection.json
└── server
    ├── db.js
    └── index.js
```


---

## ⚙️ Quick Start (Docker)

### 1. Build Docker Image
```bash
docker build --platform linux/amd64 -t edgars/medical-api .

docker run -p 3000:3000 edgars/medical-api
