import requests
from bs4 import BeautifulSoup
from string import ascii_lowercase
import MySQLdb
from slugify import slugify
# Open database connection
db = MySQLdb.connect("localhost","root","","WTFDIET" )
# prepare a cursor object using cursor() method
cursor = db.cursor()

session = requests.session()

for c in ascii_lowercase:
	req = session.get('http://www.marmiton.org/recettes/recettes-index.aspx?letter='+c)
	doc = BeautifulSoup(req.content)
	for div in doc.find_all('div', { "class" : "marmitonEditoContent" }):
		for li in div.find_all('li'):
			# Prepare SQL query to INSERT a record into the database.
			sql = """INSERT INTO `INGREDIENT`(`slug_ingredient`,`name_ingredient`) 
					VALUES ('"""+slugify(li.a.text)+"""','"""+li.a.text+"""')"""
			print sql
			try:
			   # Execute the SQL command
			   cursor.execute(sql)
			   # Commit your changes in the database
			   db.commit()
			except:
			   # Rollback in case there is any error
			   db.rollback()

# disconnect from server
db.close()