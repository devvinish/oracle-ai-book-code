-- @connect sysdba
-- @setup drop user if exists atlas_reader cascade
-- a schema without a password: no one can sign in as it
create user atlas_reader no authentication;
