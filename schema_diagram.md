erDiagram

    Patient {
        uuid id PK
        varchar identifier
        varchar name
        varchar gender
        date birth_date
        text address
        varchar telecom
        boolean active
        timestamp created_at
    }

    Practitioner {
        uuid id PK
        varchar identifier
        varchar name
        varchar specialty
        varchar telecom
        boolean active
        timestamp created_at
    }

    Encounter {
        uuid id PK
        uuid patient_id FK
        uuid practitioner_id FK
        varchar status
        timestamp encounter_date
        text reason
        timestamp created_at
    }

    Observation {
        uuid id PK
        uuid patient_id FK
        uuid encounter_id FK
        varchar type
        varchar value
        varchar unit
        timestamp recorded_at
    }

    MedicationRequest {
        uuid id PK
        uuid patient_id FK
        uuid practitioner_id FK
        varchar medication_name
        varchar dosage
        varchar status
        timestamp created_at
    }

    %% Relationships
    Patient ||--o{ Encounter : "has"
    Patient ||--o{ Observation : "has"
    Patient ||--o{ MedicationRequest : "has"

    Practitioner ||--o{ Encounter : "performs"
    Practitioner ||--o{ MedicationRequest : "prescribes"

    Encounter ||--o{ Observation : "contains"
