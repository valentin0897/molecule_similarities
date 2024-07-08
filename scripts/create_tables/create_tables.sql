CREATE TABLE IF NOT EXISTS chembl_id_lookup (
    chembl_id VARCHAR(20) PRIMARY KEY NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    status VARCHAR(10) NOT NULL,
    last_active INTEGER
);


CREATE TABLE IF NOT EXISTS molecule_dictionary (
    chembl_id VARCHAR(20) PRIMARY KEY NOT NULL,
    pref_name VARCHAR(255),
    max_phase INTEGER,
    therapeutic_flag INTEGER NOT NULL,
    dosed_ingredient INTEGER NOT NULL,
    structure_type VARCHAR(10) NOT NULL,
    chebi_par_id INTEGER,
    molecule_type VARCHAR(30),
    first_approval INTEGER,
    oral INTEGER NOT NULL,
    parenteral INTEGER NOT NULL,
    topical INTEGER NOT NULL,
    black_box_warning INTEGER NOT NULL,
    natural_product INTEGER NOT NULL,
    first_in_class INTEGER NOT NULL,
    chirality INTEGER NOT NULL,
    prodrug INTEGER NOT NULL,
    inorganic_flag INTEGER NOT NULL,
    usan_year INTEGER,
    availability_type INTEGER,
    usan_stem VARCHAR(50),
    polymer_flag INTEGER,
    usan_substem VARCHAR(50),
    usan_stem_definition VARCHAR(1000),
    indication_class VARCHAR(1000),
    withdrawn_flag INTEGER NOT NULL,
    chemical_probe INTEGER NOT NULL,
    orphan INTEGER NOT NULL
);

CREATE UNIQUE INDEX uk_chembl_id ON molecule_dictionary (chembl_id);

CREATE TABLE IF NOT EXISTS compound_properties (
    chembl_id VARCHAR(20) PRIMARY KEY NOT NULL,
    mw_freebase NUMERIC,
    alogp NUMERIC,
    hba NUMERIC,
    hbd NUMERIC,
    psa NUMERIC,
    rtb NUMERIC,
    ro3_pass VARCHAR(3),
    num_ro5_violations NUMERIC,
    cx_most_apka NUMERIC,
    cx_most_bpka NUMERIC,
    cx_logp NUMERIC,
    cx_logd NUMERIC,
    molecular_species VARCHAR(50),
    full_mwt NUMERIC,
    aromatic_rings NUMERIC,
    heavy_atoms NUMERIC,
    qed_weighted NUMERIC,
    mw_monoisotopic NUMERIC,
    full_molformula VARCHAR(100),
    hba_lipinski NUMERIC, 
    hbd_lipinski NUMERIC,
    num_lipinski_ro5_violations NUMERIC,
    np_likeness_score NUMERIC,
    CONSTRAINT fk_molecule_dictionary FOREIGN KEY (chembl_id) REFERENCES molecule_dictionary (chembl_id)
);


CREATE TABLE IF NOT EXISTS compound_structures (
    chembl_id VARCHAR(20) PRIMARY KEY NOT NULL,
    molfile TEXT,
    standard_inchi VARCHAR(4000),
    standard_inchi_key VARCHAR(27) NOT NULL,
    canonical_smiles VARCHAR(4000),
    CONSTRAINT fk_molecule_dictionary FOREIGN KEY (chembl_id) REFERENCES molecule_dictionary (chembl_id)
);

CREATE UNIQUE INDEX uk_standard_inchi ON compound_structures (standard_inchi);
CREATE UNIQUE INDEX uk_standard_inchi_key ON compound_structures (standard_inchi_key);