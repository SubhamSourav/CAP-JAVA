
DROP VIEW IF EXISTS localized_fr_AdminService_Currencies;
DROP VIEW IF EXISTS localized_de_AdminService_Currencies;
DROP VIEW IF EXISTS localized_fr_AdminService_Categories;
DROP VIEW IF EXISTS localized_de_AdminService_Categories;
DROP VIEW IF EXISTS localized_fr_AdminService_Products;
DROP VIEW IF EXISTS localized_de_AdminService_Products;
DROP VIEW IF EXISTS localized_fr_sap_common_Currencies;
DROP VIEW IF EXISTS localized_de_sap_common_Currencies;
DROP VIEW IF EXISTS localized_fr_sap_capire_products_Categories;
DROP VIEW IF EXISTS localized_de_sap_capire_products_Categories;
DROP VIEW IF EXISTS localized_fr_sap_capire_products_Products;
DROP VIEW IF EXISTS localized_de_sap_capire_products_Products;
DROP VIEW IF EXISTS localized_AdminService_Currencies;
DROP VIEW IF EXISTS localized_AdminService_Categories;
DROP VIEW IF EXISTS localized_AdminService_Products;
DROP VIEW IF EXISTS localized_sap_common_Currencies;
DROP VIEW IF EXISTS localized_sap_capire_products_Categories;
DROP VIEW IF EXISTS localized_sap_capire_products_Products;
DROP VIEW IF EXISTS AdminService_Currencies_texts;
DROP VIEW IF EXISTS AdminService_Categories_texts;
DROP VIEW IF EXISTS AdminService_Products_texts;
DROP VIEW IF EXISTS AdminService_Currencies;
DROP VIEW IF EXISTS AdminService_Categories;
DROP VIEW IF EXISTS AdminService_Products;
DROP TABLE IF EXISTS sap_common_Currencies_texts;
DROP TABLE IF EXISTS sap_capire_products_Categories_texts;
DROP TABLE IF EXISTS sap_capire_products_Products_texts;
DROP TABLE IF EXISTS sap_common_Currencies;
DROP TABLE IF EXISTS sap_capire_products_Categories;
DROP TABLE IF EXISTS sap_capire_products_Products;

CREATE TABLE sap_capire_products_Products (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  title NVARCHAR(111),
  descr NVARCHAR(1111),
  stock INTEGER,
  price DECIMAL(9, 2),
  currency_code NVARCHAR(3),
  category_ID INTEGER,
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_products_Categories (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  ID INTEGER NOT NULL,
  parent_ID INTEGER,
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_common_Currencies (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  symbol NVARCHAR(5),
  minorUnit SMALLINT,
  PRIMARY KEY(code)
); 

CREATE TABLE sap_capire_products_Products_texts (
  locale NVARCHAR(14) NOT NULL,
  ID NVARCHAR(36) NOT NULL,
  title NVARCHAR(111),
  descr NVARCHAR(1111),
  PRIMARY KEY(locale, ID)
); 

CREATE TABLE sap_capire_products_Categories_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  ID INTEGER NOT NULL,
  PRIMARY KEY(locale, ID)
); 

CREATE TABLE sap_common_Currencies_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  PRIMARY KEY(locale, code)
); 

CREATE VIEW AdminService_Products AS SELECT
  Products_0.ID,
  Products_0.createdAt,
  Products_0.createdBy,
  Products_0.modifiedAt,
  Products_0.modifiedBy,
  Products_0.title,
  Products_0.descr,
  Products_0.stock,
  Products_0.price,
  Products_0.currency_code,
  Products_0.category_ID
FROM sap_capire_products_Products AS Products_0; 

CREATE VIEW AdminService_Categories AS SELECT
  Categories_0.name,
  Categories_0.descr,
  Categories_0.ID,
  Categories_0.parent_ID
FROM sap_capire_products_Categories AS Categories_0; 

CREATE VIEW AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM sap_common_Currencies AS Currencies_0; 

CREATE VIEW AdminService_Products_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.title,
  texts_0.descr
FROM sap_capire_products_Products_texts AS texts_0; 

CREATE VIEW AdminService_Categories_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.ID
FROM sap_capire_products_Categories_texts AS texts_0; 

CREATE VIEW AdminService_Currencies_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_common_Currencies_texts AS texts_0; 

CREATE VIEW localized_sap_capire_products_Products AS SELECT
  L_0.ID,
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  coalesce(localized_1.title, L_0.title) AS title,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.stock,
  L_0.price,
  L_0.currency_code,
  L_0.category_ID
FROM (sap_capire_products_Products AS L_0 LEFT JOIN sap_capire_products_Products_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = @locale); 

CREATE VIEW localized_sap_capire_products_Categories AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.ID,
  L_0.parent_ID
FROM (sap_capire_products_Categories AS L_0 LEFT JOIN sap_capire_products_Categories_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = @locale); 

CREATE VIEW localized_sap_common_Currencies AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.code,
  L_0.symbol,
  L_0.minorUnit
FROM (sap_common_Currencies AS L_0 LEFT JOIN sap_common_Currencies_texts AS localized_1 ON localized_1.code = L_0.code AND localized_1.locale = @locale); 

CREATE VIEW localized_AdminService_Products AS SELECT
  Products_0.ID,
  Products_0.createdAt,
  Products_0.createdBy,
  Products_0.modifiedAt,
  Products_0.modifiedBy,
  Products_0.title,
  Products_0.descr,
  Products_0.stock,
  Products_0.price,
  Products_0.currency_code,
  Products_0.category_ID
FROM localized_sap_capire_products_Products AS Products_0; 

CREATE VIEW localized_AdminService_Categories AS SELECT
  Categories_0.name,
  Categories_0.descr,
  Categories_0.ID,
  Categories_0.parent_ID
FROM localized_sap_capire_products_Categories AS Categories_0; 

CREATE VIEW localized_AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM localized_sap_common_Currencies AS Currencies_0; 

CREATE VIEW localized_de_sap_capire_products_Products AS SELECT
  L_0.ID,
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  coalesce(localized_de_1.title, L_0.title) AS title,
  coalesce(localized_de_1.descr, L_0.descr) AS descr,
  L_0.stock,
  L_0.price,
  L_0.currency_code,
  L_0.category_ID
FROM (sap_capire_products_Products AS L_0 LEFT JOIN sap_capire_products_Products_texts AS localized_de_1 ON localized_de_1.ID = L_0.ID AND localized_de_1.locale = @locale); 

CREATE VIEW localized_fr_sap_capire_products_Products AS SELECT
  L_0.ID,
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  coalesce(localized_fr_1.title, L_0.title) AS title,
  coalesce(localized_fr_1.descr, L_0.descr) AS descr,
  L_0.stock,
  L_0.price,
  L_0.currency_code,
  L_0.category_ID
FROM (sap_capire_products_Products AS L_0 LEFT JOIN sap_capire_products_Products_texts AS localized_fr_1 ON localized_fr_1.ID = L_0.ID AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_sap_capire_products_Categories AS SELECT
  coalesce(localized_de_1.name, L_0.name) AS name,
  coalesce(localized_de_1.descr, L_0.descr) AS descr,
  L_0.ID,
  L_0.parent_ID
FROM (sap_capire_products_Categories AS L_0 LEFT JOIN sap_capire_products_Categories_texts AS localized_de_1 ON localized_de_1.ID = L_0.ID AND localized_de_1.locale = @locale); 

CREATE VIEW localized_fr_sap_capire_products_Categories AS SELECT
  coalesce(localized_fr_1.name, L_0.name) AS name,
  coalesce(localized_fr_1.descr, L_0.descr) AS descr,
  L_0.ID,
  L_0.parent_ID
FROM (sap_capire_products_Categories AS L_0 LEFT JOIN sap_capire_products_Categories_texts AS localized_fr_1 ON localized_fr_1.ID = L_0.ID AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_sap_common_Currencies AS SELECT
  coalesce(localized_de_1.name, L_0.name) AS name,
  coalesce(localized_de_1.descr, L_0.descr) AS descr,
  L_0.code,
  L_0.symbol,
  L_0.minorUnit
FROM (sap_common_Currencies AS L_0 LEFT JOIN sap_common_Currencies_texts AS localized_de_1 ON localized_de_1.code = L_0.code AND localized_de_1.locale = @locale); 

CREATE VIEW localized_fr_sap_common_Currencies AS SELECT
  coalesce(localized_fr_1.name, L_0.name) AS name,
  coalesce(localized_fr_1.descr, L_0.descr) AS descr,
  L_0.code,
  L_0.symbol,
  L_0.minorUnit
FROM (sap_common_Currencies AS L_0 LEFT JOIN sap_common_Currencies_texts AS localized_fr_1 ON localized_fr_1.code = L_0.code AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_AdminService_Products AS SELECT
  Products_0.ID,
  Products_0.createdAt,
  Products_0.createdBy,
  Products_0.modifiedAt,
  Products_0.modifiedBy,
  Products_0.title,
  Products_0.descr,
  Products_0.stock,
  Products_0.price,
  Products_0.currency_code,
  Products_0.category_ID
FROM localized_de_sap_capire_products_Products AS Products_0; 

CREATE VIEW localized_fr_AdminService_Products AS SELECT
  Products_0.ID,
  Products_0.createdAt,
  Products_0.createdBy,
  Products_0.modifiedAt,
  Products_0.modifiedBy,
  Products_0.title,
  Products_0.descr,
  Products_0.stock,
  Products_0.price,
  Products_0.currency_code,
  Products_0.category_ID
FROM localized_fr_sap_capire_products_Products AS Products_0; 

CREATE VIEW localized_de_AdminService_Categories AS SELECT
  Categories_0.name,
  Categories_0.descr,
  Categories_0.ID,
  Categories_0.parent_ID
FROM localized_de_sap_capire_products_Categories AS Categories_0; 

CREATE VIEW localized_fr_AdminService_Categories AS SELECT
  Categories_0.name,
  Categories_0.descr,
  Categories_0.ID,
  Categories_0.parent_ID
FROM localized_fr_sap_capire_products_Categories AS Categories_0; 

CREATE VIEW localized_de_AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM localized_de_sap_common_Currencies AS Currencies_0; 

CREATE VIEW localized_fr_AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM localized_fr_sap_common_Currencies AS Currencies_0; 

