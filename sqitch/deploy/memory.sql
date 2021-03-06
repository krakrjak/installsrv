-- Deploy meatPacker:memory to pg
-- requires: size_units
-- requires: transfer_units
-- requires: computers

BEGIN;

CREATE TYPE memory_types AS enum (
    'DDR',
    'DDR2',
    'DDR3',
    'DDR4'
);

CREATE TABLE memory (
    memory_id serial,
    computer_id bigint REFERENCES computers,
    model text NULL,
    speed bigint NOT NULL,
    speed_unit transfer_units NOT NULL,
    size bigint NOT NULL,
    size_unit size_units NOT NULL,
    type memory_types NOT NULL
);

-- Read-Only user can select
GRANT SELECT ON memory TO inventory_ro;
GRANT SELECT ON memory_memory_id_seq TO inventory_ro;

-- Read-Write user can insert/update/delete
GRANT SELECT,INSERT,UPDATE,DELETE ON memory TO inventory_rw;
GRANT USAGE ON memory_memory_id_seq TO inventory_rw;

COMMIT;
