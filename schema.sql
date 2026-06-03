CREATE DATABASE IF NOT EXISTS elite_estates_db;

USE elite_estates_db;

CREATE TABLE agents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    photo_url VARCHAR(x255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE properties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    agent_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    bedrooms INT NOT NULL,
    bathrooms DECIMAL(4, 2) NOT NULL,
    sqft INT NOT NULL,
    lot_size INT,
    year_built INT,
    property_type ENUM('house', 'condo', 'townhouse',  'land', 'commercial') DEFAULT 'house',
    status ENUM('active', 'pending', 'sold') DEFAULT 'active',
    featured TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (agent_id) REFERENCES agents(id) ON DELETE CASCADE
);

CREATE TABLE property_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary TINYINT(1) DEFAULT 0,
    sort_order TINYINT UNSIGNEED DEFUALT 0,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);

-- sample data --

INSERT INTO agents (name, email, phone) VALUES
('Sarah Mitchell', 'sarah@keystonerealty.com', '405-555-0101'),
('James Caldwell', 'james@keystonerealty.com', '405-555-0102');

INSERT INTO properties
    (agent_id, title, description, address, city, state, zip_code,
     price, bedrooms, bathrooms, sqft, year_built, property_type, status, featured)
VALUES
(1, 'Charming Craftsman Bungalow',
 'Beautifully updated bungalow with original hardwood floors, modern kitchen, and a wraparound porch perfect for Oklahoma evenings.',
 '4821 Elm Street', 'Oklahoma City', 'OK', '73105',
 289000, 3, 2.0, 1540, 1928, 'house', 'active', 1),

(1, 'Modern Downtown Condo',
 'Sleek 14th-floor unit with floor-to-ceiling windows, exposed concrete, and stunning city views. Walk to restaurants and arts district.',
 '101 N Broadway Ave #1402', 'Oklahoma City', 'OK', '73102',
 375000, 2, 2.0, 1200, 2018, 'condo', 'active', 1),

(2, 'Spacious Suburban Family Home',
 'Five-bedroom home on a quiet cul-de-sac. Large backyard, three-car garage, open-concept kitchen with granite countertops.',
 '7209 Willow Creek Dr', 'Edmond', 'OK', '73034',
 459000, 5, 3.5, 3100, 2005, 'house', 'active', 0),

(2, 'Cozy Starter Home',
 'Move-in ready two-bed with new roof, HVAC, and appliances. Great starter home in established neighborhood close to schools.',
 '2214 NW 35th St', 'Oklahoma City', 'OK', '73112',
 159000, 2, 1.0, 980, 1962, 'house', 'active', 0),

(1, 'Luxury Estate on Acreage',
 'Stunning 5-acre property featuring a 4,800 sqft custom home, pool, guest house, and private pond. A rare find.',
 '14902 S Sooner Rd', 'Guthrie', 'OK', '73044',
 1250000, 5, 4.5, 4800, 2012, 'house', 'active', 1);
