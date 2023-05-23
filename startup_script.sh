#! /bin/bash

sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
echo '<html>
<head>
<title>My Website</title>
</head>
<body>
<h1>Welcome to my website!</h1>
<p>This is a sanjana hosted website on Apache.</p>
</body>
</html>' | sudo tee /var/www/html/index.html > /dev/null


sudo systemctl restart apache2

