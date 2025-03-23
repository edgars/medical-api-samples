-- DROP existing tables
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS specialties;

-- CREATE tables
CREATE TABLE specialties (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE doctors (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  specialty_id TEXT,
  FOREIGN KEY(specialty_id) REFERENCES specialties(id)
);

CREATE TABLE patients (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  birthdate TEXT
);

CREATE TABLE appointments (
  id TEXT PRIMARY KEY,
  doctor_id TEXT,
  patient_id TEXT,
  date TEXT,
  time TEXT,
  notes TEXT,
  FOREIGN KEY(doctor_id) REFERENCES doctors(id),
  FOREIGN KEY(patient_id) REFERENCES patients(id)
);

-- INSERT specialties (3 sample)
INSERT INTO specialties (id, name) VALUES
('spc-1111-aaaa-0001-uuid001', 'Cardiology'),
('spc-2222-bbbb-0002-uuid002', 'Dermatology'),
('spc-3333-cccc-0003-uuid003', 'Neurology');

-- INSERT doctors (9)
INSERT INTO doctors (id, name, email, specialty_id) VALUES
('doc-0001-aaaa-1111-uuid001', 'Dr. Alice Heart', 'alice.heart@clinic.com', 'spc-1111-aaaa-0001-uuid001'),
('doc-0002-bbbb-1111-uuid002', 'Dr. Bob Skin', 'bob.skin@clinic.com', 'spc-2222-bbbb-0002-uuid002'),
('doc-0003-cccc-1111-uuid003', 'Dr. Clara Brain', 'clara.brain@clinic.com', 'spc-3333-cccc-0003-uuid003'),
('doc-0004-dddd-1111-uuid004', 'Dr. Dan Veins', 'dan.veins@clinic.com', 'spc-1111-aaaa-0001-uuid001'),
('doc-0005-eeee-1111-uuid005', 'Dr. Emma Skin', 'emma.skin@clinic.com', 'spc-2222-bbbb-0002-uuid002'),
('doc-0006-ffff-1111-uuid006', 'Dr. Frank Neuro', 'frank.neuro@clinic.com', 'spc-3333-cccc-0003-uuid003'),
('doc-0007-gggg-1111-uuid007', 'Dr. Grace Heart', 'grace.heart@clinic.com', 'spc-1111-aaaa-0001-uuid001'),
('doc-0008-hhhh-1111-uuid008', 'Dr. Henry Skin', 'henry.skin@clinic.com', 'spc-2222-bbbb-0002-uuid002'),
('doc-0009-iiii-1111-uuid009', 'Dr. Irene Neuro', 'irene.neuro@clinic.com', 'spc-3333-cccc-0003-uuid003');

-- INSERT patients (17)
INSERT INTO patients (id, name, email, birthdate) VALUES
('pat-0001-aaaa-uuid001', 'John Doe', 'john.doe@example.com', '1985-01-15'),
('pat-0002-bbbb-uuid002', 'Jane Smith', 'jane.smith@example.com', '1990-06-10'),
('pat-0003-cccc-uuid003', 'Mike Brown', 'mike.brown@example.com', '1978-03-22'),
('pat-0004-dddd-uuid004', 'Sara White', 'sara.white@example.com', '1995-09-12'),
('pat-0005-eeee-uuid005', 'Tom Black', 'tom.black@example.com', '1982-11-05'),
('pat-0006-ffff-uuid006', 'Emma Green', 'emma.green@example.com', '1993-02-28'),
('pat-0007-gggg-uuid007', 'Liam Blue', 'liam.blue@example.com', '1987-07-04'),
('pat-0008-hhhh-uuid008', 'Olivia Gray', 'olivia.gray@example.com', '1999-10-10'),
('pat-0009-iiii-uuid009', 'Noah Red', 'noah.red@example.com', '1980-12-22'),
('pat-0010-jjjj-uuid010', 'Ava Orange', 'ava.orange@example.com', '1992-05-30'),
('pat-0011-kkkk-uuid011', 'Lucas Purple', 'lucas.purple@example.com', '1988-08-08'),
('pat-0012-llll-uuid012', 'Mia Yellow', 'mia.yellow@example.com', '1991-04-18'),
('pat-0013-mmmm-uuid013', 'Ethan Brown', 'ethan.brown@example.com', '1983-09-09'),
('pat-0014-nnnn-uuid014', 'Sophia Pink', 'sophia.pink@example.com', '1994-01-27'),
('pat-0015-oooo-uuid015', 'Mason Lime', 'mason.lime@example.com', '1986-02-15'),
('pat-0016-pppp-uuid016', 'Isabella Teal', 'isabella.teal@example.com', '1998-03-12'),
('pat-0017-qqqq-uuid017', 'Logan Navy', 'logan.navy@example.com', '1997-07-17');

-- INSERT appointments (78 total)
-- Sample pattern: 6 per doctor, random patients
INSERT INTO appointments (id, doctor_id, patient_id, date, time, notes) VALUES
-- Doctor 1 appointments
('app-0001-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0001-aaaa-uuid001', '2024-04-01', '09:00', 'Initial consultation'),
('app-0002-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0002-bbbb-uuid002', '2024-04-02', '10:00', 'Follow-up'),
('app-0003-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0003-cccc-uuid003', '2024-04-03', '11:00', 'Check-up'),
('app-0004-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0004-dddd-uuid004', '2024-04-04', '09:30', 'Routine'),
('app-0005-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0005-eeee-uuid005', '2024-04-05', '10:30', 'Test Results'),
('app-0006-uuid', 'doc-0001-aaaa-1111-uuid001', 'pat-0006-ffff-uuid006', '2024-04-06', '11:30', 'Consultation'),

-- Doctor 2 appointments
('app-0007-uuid', 'doc-0002-bbbb-1111-uuid002', 'pat-0007-gggg-uuid007', '2024-04-07', '09:00', 'Skin rash'),
('app-0008-uuid', 'doc-0002-bbbb-1111-uuid002', 'pat-0008-hhhh-uuid008', '2024-04-08', '10:00', 'Derm check'),
-- ... continue same pattern ...

-- Doctor 9 appointments (sample last entries)
('app-0077-uuid', 'doc-0009-iiii-1111-uuid009', 'pat-0016-pppp-uuid016', '2024-06-14', '10:30', 'MRI review'),
('app-0078-uuid', 'doc-0009-iiii-1111-uuid009', 'pat-0017-qqqq-uuid017', '2024-06-15', '11:30', 'Consultation');
