CREATE TABLE guests (id UUID PRIMARY KEY, name VARCHAR(160) NOT NULL, phone VARCHAR(40), email VARCHAR(200), attending VARCHAR(3) NOT NULL CHECK (attending IN ('yes','no')), adults INTEGER NOT NULL CHECK (adults BETWEEN 0 AND 20), children INTEGER NOT NULL CHECK (children BETWEEN 0 AND 20), note VARCHAR(500), created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE messages (id UUID PRIMARY KEY, name VARCHAR(160) NOT NULL, text VARCHAR(1000) NOT NULL, approved BOOLEAN NOT NULL DEFAULT FALSE, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE gifts (id UUID PRIMARY KEY, name VARCHAR(160) NOT NULL, price NUMERIC(12,2) NOT NULL CHECK(price > 0), category VARCHAR(80) NOT NULL, image VARCHAR(1000));
CREATE TABLE pledges (id UUID PRIMARY KEY, gift_id UUID REFERENCES gifts(id) ON DELETE SET NULL, gift VARCHAR(160) NOT NULL, amount NUMERIC(12,2) NOT NULL CHECK(amount > 0), name VARCHAR(160) NOT NULL, message VARCHAR(300), status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','confirmed')), created_at TIMESTAMPTZ NOT NULL DEFAULT now());
INSERT INTO gifts(id,name,price,category,image) VALUES
('f0000000-0000-0000-0000-000000000001','Jantar romântico',180,'Experiências','https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=700&q=80'),
('f0000000-0000-0000-0000-000000000002','Jogo de jantar',250,'Nossa casa','https://images.unsplash.com/photo-1490312278390-ab64016e0aa9?w=700&q=80'),
('f0000000-0000-0000-0000-000000000003','Lua de mel dos sonhos',350,'Lua de mel','https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=700&q=80'),
('f0000000-0000-0000-0000-000000000004','Café da manhã especial',120,'Experiências','https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=700&q=80'),
('f0000000-0000-0000-0000-000000000005','Nossa cozinha nova',450,'Nossa casa','https://images.unsplash.com/photo-1556911220-bff31c812dba?w=700&q=80'),
('f0000000-0000-0000-0000-000000000006','Passeio inesquecível',200,'Lua de mel','https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=700&q=80');
