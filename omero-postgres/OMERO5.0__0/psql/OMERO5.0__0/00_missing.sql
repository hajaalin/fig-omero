BEGIN;

CREATE OR REPLACE FUNCTION annotation_link_delete_trigger() RETURNS "trigger"
    AS '
    DECLARE
        eid int8;
    BEGIN

        SELECT INTO eid _current_or_new_event();
        INSERT INTO eventlog (id, action, permissions, entityid, entitytype, event)
                SELECT ome_nextval(''seq_eventlog''), ''REINDEX'', -52, old.parent, TG_ARGV[0], eid;

        RETURN old;

    END;'
LANGUAGE plpgsql;

COMMIT;

