-- Enhanced Firebolt schema with multiple tables for JOIN testing
-- First create the external table and main hits table (from create.sql)

-- Users dimension table
CREATE TABLE users
(
    UserID BIGINT NOT NULL,
    UserSegment TEXT NOT NULL,
    UserCountry TEXT NOT NULL,
    RegistrationDate DATE NOT NULL,
    UserAge INTEGER NOT NULL,
    UserGender CHAR(1) NOT NULL
) PRIMARY INDEX UserID;

-- Regions dimension table  
CREATE TABLE regions
(
    RegionID INTEGER NOT NULL,
    RegionName TEXT NOT NULL,
    Country TEXT NOT NULL,
    Continent TEXT NOT NULL,
    TimeZone TEXT NOT NULL
) PRIMARY INDEX RegionID;

-- Search engines reference table
CREATE TABLE search_engines
(
    SearchEngineID INTEGER NOT NULL,
    SearchEngineName TEXT NOT NULL,
    SearchEngineURL TEXT NOT NULL,
    MarketShare DECIMAL(5,2) NOT NULL
) PRIMARY INDEX SearchEngineID;

-- Advertising engines reference table
CREATE TABLE adv_engines
(
    AdvEngineID INTEGER NOT NULL,
    AdvEngineName TEXT NOT NULL,
    CostPerClick DECIMAL(8,4) NOT NULL,
    Category TEXT NOT NULL
) PRIMARY INDEX AdvEngineID;
