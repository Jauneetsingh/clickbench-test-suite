-- Enhanced SingleStore schema with multiple tables for JOIN testing

set global collation_database='utf8_bin';
set collation_database='utf8_bin';

-- Users dimension table
CREATE TABLE users (
    UserID BIGINT NOT NULL,
    UserSegment TEXT NOT NULL,
    UserCountry TEXT NOT NULL,
    RegistrationDate DATE NOT NULL,
    UserAge SMALLINT NOT NULL,
    UserGender CHAR(1) NOT NULL,
    SORT KEY (UserID)
);

-- Regions dimension table  
CREATE TABLE regions (
    RegionID INTEGER NOT NULL,
    RegionName TEXT NOT NULL,
    Country TEXT NOT NULL,
    Continent TEXT NOT NULL,
    TimeZone TEXT NOT NULL,
    SORT KEY (RegionID)
);

-- Search engines reference table
CREATE TABLE search_engines (
    SearchEngineID SMALLINT NOT NULL,
    SearchEngineName TEXT NOT NULL,
    SearchEngineURL TEXT NOT NULL,
    MarketShare DECIMAL(5,2) NOT NULL,
    SORT KEY (SearchEngineID)
);

-- Advertising engines reference table
CREATE TABLE adv_engines (
    AdvEngineID SMALLINT NOT NULL,
    AdvEngineName TEXT NOT NULL,
    CostPerClick DECIMAL(8,4) NOT NULL,
    Category TEXT NOT NULL,
    SORT KEY (AdvEngineID)
);
