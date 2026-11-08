UPDATE gifts SET name='Air fryer',price=450,category='Nossa casa',image='/presentes/Air fryer.jfif' WHERE id='f0000000-0000-0000-0000-000000000001';
UPDATE gifts SET name='Aspirador vertical',price=500,category='Nossa casa',image='/presentes/aspirador vertical.jfif' WHERE id='f0000000-0000-0000-0000-000000000002';
UPDATE gifts SET name='Batedeira',price=520,category='Nossa casa',image='/presentes/Batedeira.jfif' WHERE id='f0000000-0000-0000-0000-000000000003';
UPDATE gifts SET name='Cafeteira',price=650,category='Nossa casa',image='/presentes/Cafeteira.jfif' WHERE id='f0000000-0000-0000-0000-000000000004';
UPDATE gifts SET name='Cama de casal',price=1400,category='Nossa casa',image='/presentes/cama de casal.jfif' WHERE id='f0000000-0000-0000-0000-000000000005';
UPDATE gifts SET name='Cesto organizador',price=120,category='Nossa casa',image='/presentes/cesto organizador.jfif' WHERE id='f0000000-0000-0000-0000-000000000006';
INSERT INTO gifts(id,name,price,category,image) VALUES
('f0000000-0000-0000-0000-000000000007','Climatizador de ar',650,'Nossa casa','/presentes/climatizador de ar.jfif'),
('f0000000-0000-0000-0000-000000000008','Coifa de parede',1200,'Nossa casa','/presentes/coifa de parede.jfif'),
('f0000000-0000-0000-0000-000000000009','Cômoda para quarto',850,'Nossa casa','/presentes/cômoda para quarto.jfif'),
('f0000000-0000-0000-0000-000000000010','Conjunto de panelas',600,'Nossa casa','/presentes/conjunto de panelas.jfif'),
('f0000000-0000-0000-0000-000000000011','Cooktop',850,'Nossa casa','/presentes/cooktop.jfif'),
('f0000000-0000-0000-0000-000000000012','Faqueiro',350,'Nossa casa','/presentes/faqueiro.jfif'),
('f0000000-0000-0000-0000-000000000013','Ferro de passar a vapor',220,'Nossa casa','/presentes/ferro de passar a vapor.jfif'),
('f0000000-0000-0000-0000-000000000014','Fogão',1500,'Nossa casa','/presentes/fogão.jfif'),
('f0000000-0000-0000-0000-000000000015','Forno elétrico',650,'Nossa casa','/presentes/forno elétrico.jfif'),
('f0000000-0000-0000-0000-000000000016','Fruteira',320,'Nossa casa','/presentes/fruteira.jfif'),
('f0000000-0000-0000-0000-000000000017','Geladeira',3200,'Nossa casa','/presentes/geladeira.jfif'),
('f0000000-0000-0000-0000-000000000018','Guarda roupa de casal',1800,'Nossa casa','/presentes/guarda roupa de casal.jfif'),
('f0000000-0000-0000-0000-000000000019','Jogo de copos',160,'Nossa casa','/presentes/jogo de copos.jfif'),
('f0000000-0000-0000-0000-000000000020','Jogo de jantar',450,'Nossa casa','/presentes/jogo de jantar.jfif'),
('f0000000-0000-0000-0000-000000000021','Jogo de toalhas',220,'Nossa casa','/presentes/jogo de toalhas.jfif'),
('f0000000-0000-0000-0000-000000000022','Lava-louças',2800,'Nossa casa','/presentes/lava-louças.jfif'),
('f0000000-0000-0000-0000-000000000023','Lixeira',180,'Nossa casa','/presentes/lixeira.jfif'),
('f0000000-0000-0000-0000-000000000024','Mesa com 6 cadeiras',1900,'Nossa casa','/presentes/mesa com 6 cadeiras.jfif'),
('f0000000-0000-0000-0000-000000000025','Mesa de centro',550,'Nossa casa','/presentes/mesa de centro.jfif'),
('f0000000-0000-0000-0000-000000000026','Micro-ondas',650,'Nossa casa','/presentes/microondas.jfif'),
('f0000000-0000-0000-0000-000000000027','Mixer de mão',180,'Nossa casa','/presentes/mixer de mão.jfif'),
('f0000000-0000-0000-0000-000000000028','Mop de limpeza',150,'Nossa casa','/presentes/mop de limpeza.jfif'),
('f0000000-0000-0000-0000-000000000029','Panela de pressão',280,'Nossa casa','/presentes/panela de pressão.jfif'),
('f0000000-0000-0000-0000-000000000030','Panela elétrica de arroz',260,'Nossa casa','/presentes/panela elétrica de arroz.jfif'),
('f0000000-0000-0000-0000-000000000031','Processador de alimentos',450,'Nossa casa','/presentes/Processador de alimentos.jfif'),
('f0000000-0000-0000-0000-000000000032','Purificador de água',850,'Nossa casa','/presentes/purificador de água.jfif'),
('f0000000-0000-0000-0000-000000000033','Rack para sala',900,'Nossa casa','/presentes/rack para sala.jfif'),
('f0000000-0000-0000-0000-000000000034','Robô aspirador',1300,'Nossa casa','/presentes/robô aspirador.jfif'),
('f0000000-0000-0000-0000-000000000035','Sanduicheira',180,'Nossa casa','/presentes/sanduicheira.jfif'),
('f0000000-0000-0000-0000-000000000036','Smart TV',2400,'Nossa casa','/presentes/Smart TV.jfif'),
('f0000000-0000-0000-0000-000000000037','Sofá',2200,'Nossa casa','/presentes/sofá.jfif'),
('f0000000-0000-0000-0000-000000000038','Tapete sala',600,'Nossa casa','/presentes/tapete sala.jfif'),
('f0000000-0000-0000-0000-000000000039','Ventilador de coluna',280,'Nossa casa','/presentes/ventilador de coluna.jfif')
ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name, price=EXCLUDED.price, category=EXCLUDED.category, image=EXCLUDED.image;
