CREATE TABLE "Patient" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "identifier" varchar(255) UNIQUE NOT NULL,
  "name" varchar(255) NOT NULL,
  "gender" varchar(10),
  "birth_date" date,
  "address" text,
  "telecom" varchar(255),
  "active" boolean DEFAULT true,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "Practitioner" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "identifier" varchar(255) UNIQUE NOT NULL,
  "name" varchar(255) NOT NULL,
  "specialty" varchar(255),
  "telecom" varchar(255),
  "active" boolean DEFAULT true,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "Encounter" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "patient_id" uuid NOT NULL,
  "practitioner_id" uuid,
  "status" varchar(50) NOT NULL,
  "encounter_date" timestamp DEFAULT (now()),
  "reason" text,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "Observation" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "patient_id" uuid NOT NULL,
  "encounter_id" uuid,
  "type" varchar(255) NOT NULL,
  "value" varchar(255) NOT NULL,
  "unit" varchar(50),
  "recorded_at" timestamp DEFAULT (now())
);

CREATE TABLE "MedicationRequest" (
  "id" uuid PRIMARY KEY DEFAULT (gen_random_uuid()),
  "patient_id" uuid NOT NULL,
  "practitioner_id" uuid NOT NULL,
  "medication_name" varchar(255) NOT NULL,
  "dosage" varchar(255),
  "status" varchar(50) NOT NULL,
  "created_at" timestamp DEFAULT (now())
);