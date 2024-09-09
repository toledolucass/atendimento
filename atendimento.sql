CREATE TABLE Especialidade(
    cod_espec NUMBER(3)
        CONSTRAINT pk_cod_espc PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    obs VARCHAR(100)
);

CREATE TABLE Convenio(
    cod_conven CHAR(6)
        CONSTRAINT pk_cod_conven PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    status NUMBER(1)
        CONSTRAINT ck_status CHECK(status IN (0, 1, 2))
);

CREATE TABLE Medico(
    cod_med NUMBER(4)
        CONSTRAINT pk_cod_med PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    titulo VARCHAR(10),
    crm NUMBER(6),
    uf_crm CHAR(2),
    cod_espec NUMBER(3)
        CONSTRAINT fk_med_espec REFERENCES Especialidade,
    
    CONSTRAINT uk_med_crm UNIQUE(crm, uf_crm)
);

ALTER TABLE Medico
MODIFY cod_espec NOT NULL;

CREATE TABLE Paciente(
    cod_pac NUMBER(7)
        CONSTRAINT pk_pac PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    dt_nasc DATE NOT NULL,
    sexo CHAR(1) NOT NULL
        CONSTRAINT ck_pac_sexo CHECK(sexo IN ('F', 'M')),
    cod_conv CHAR(6)
        CONSTRAINT fk_pac_conve REFERENCES Convenio,
    historico VARCHAR(4000)        
);

CREATE TABLE Atendimento(
    cod_pac NUMBER(7)
        CONSTRAINT fk_atend_pac REFERENCES Paciente,
    cod_med NUMBER(4)
        CONSTRAINT fk_atend_med REFERENCES Medico,
    dt_atend DATE,
    dt_retorno DATE, 
    preco NUMBER(7, 2)
        CONSTRAINT ck_preco_atend CHECK(preco >= 0),
    obs VARCHAR(500),
    
    CONSTRAINT pk_atend PRIMARY KEY(cod_pac, cod_med, dt_atend)
);