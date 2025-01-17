
-- index to name of Comerciants (searches and filters by name)
CREATE INDEX idx_comerciants_name ON Comerciants (name);

-- index to city (searches and filters by city_id)
CREATE INDEX idx_comerciants_city ON Comerciants (city_id);

-- index to registration_date (searches and filters by registration_date)
CREATE INDEX idx_comerciants_registration_date ON Comerciants (registration_date);

-- index to status (searches and filters by status)
CREATE INDEX idx_comerciants_status ON Comerciants (status);

-- index to commerciant_id (queries of establishments by merchant)
CREATE INDEX idx_establishments_comerciant ON Establishments (commerciant_id);