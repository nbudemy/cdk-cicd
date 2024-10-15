-- liquibase formatted sql

-- changeset neil.bottomley:1728900798628-103 runOnChange:true
drop function if exists uuid_to_bin;
create function uuid_to_bin(_uuid binary(36))
    returns binary(16)
    language sql  deterministic  contains sql  sql security invoker
    return
        unhex(concat(
                substr(_uuid,  1, 8),
                substr(_uuid, 10, 4),
                substr(_uuid, 15, 4),
                substr(_uuid, 20, 4),
                substr(_uuid, 25) ));

drop function if exists bin_to_uuid;
create function bin_to_uuid(_bin binary(16))
    returns binary(36)
    language sql  deterministic  contains sql  sql security invoker
    return
        lcase(concat_ws('-',
                        hex(substr(_bin,  1, 4)),
                        hex(substr(_bin,  5, 2)),
                        hex(substr(_bin,  7, 2)),
                        hex(substr(_bin,  9, 2)),
                        hex(substr(_bin, 11))
            ));