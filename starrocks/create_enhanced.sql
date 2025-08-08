-- Enhanced schema with multiple tables for JOIN testing

-- Main hits table (already exists in create.sql)
-- We'll add related dimension tables

-- Users dimension table
CREATE TABLE users (
    UserID BIGINT NOT NULL,
    UserSegment STRING NOT NULL,
    UserCountry STRING NOT NULL,
    RegistrationDate Date NOT NULL,
    UserAge SMALLINT NOT NULL,
    UserGender CHAR(1) NOT NULL
)
DUPLICATE KEY (UserID)
DISTRIBUTED BY HASH(UserID) BUCKETS 8
PROPERTIES ( "replication_num"="1");

-- Regions dimension table  
CREATE TABLE regions (
    RegionID INT NOT NULL,
    RegionName STRING NOT NULL,
    Country STRING NOT NULL,
    Continent STRING NOT NULL,
    TimeZone STRING NOT NULL
)
DUPLICATE KEY (RegionID)
DISTRIBUTED BY HASH(RegionID) BUCKETS 4
PROPERTIES ( "replication_num"="1");

-- Search engines reference table
CREATE TABLE search_engines (
    SearchEngineID SMALLINT NOT NULL,
    SearchEngineName STRING NOT NULL,
    SearchEngineURL STRING NOT NULL,
    MarketShare DECIMAL(5,2) NOT NULL
)
DUPLICATE KEY (SearchEngineID)
DISTRIBUTED BY HASH(SearchEngineID) BUCKETS 2
PROPERTIES ( "replication_num"="1");

-- Advertising engines reference table
CREATE TABLE adv_engines (
    AdvEngineID SMALLINT NOT NULL,
    AdvEngineName STRING NOT NULL,
    CostPerClick DECIMAL(8,4) NOT NULL,
    Category STRING NOT NULL
)
DUPLICATE KEY (AdvEngineID)
DISTRIBUTED BY HASH(AdvEngineID) BUCKETS 2
PROPERTIES ( "replication_num"="1");
