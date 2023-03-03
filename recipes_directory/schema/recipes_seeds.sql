TRUNCATE TABLE recipes RESTART IDENTITY; 

INSERT INTO recipes (name, avg_cooking_time, rating) VALUES 
('Jollof rice', 120, 5),
('Brownies', 60, 4),
('Bubble tea', 10, 2);