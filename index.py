from flask import Flask, render_template, request, session
import psycopg2
import os
from flask_bcrypt import Bcrypt
from psycopg2.extras import RealDictCursor
from werkzeug.utils import secure_filename

con = psycopg2.connect(
  host = "localhost",
  dbname = "pyapp_db",
  user = "pyapp",
  password = "password"
)

bcrypt = Bcrypt()

app = Flask(__name__)

UPLOAD_FOLDER = 'C:/Users/peysi/Desktop/webApp/static/img'

ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024
app.secret_key = "testing123"

def allowed_file(filename):
	return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/")
def index():
  return render_template('index.html')

@app.route("/index")
def mainP():
  return render_template('index.html')

@app.route("/register")
def register():
  return render_template('register.html')

@app.route("/addProduct")
def addProduct():
  if "username" in session:
    return render_template('addProduct.html')
  else:
    return "<script>alert('Log-In First');window.location.href='/login';</script>"

@app.route("/sell", methods = ["GET","POST"])
def sell():

  if request.method == "POST":
    prodName = request.form['prodName']
    description = request.form['description']
    price = request.form['price']
    sku = request.form['sku']
    stock = request.form['stock']
    variation = request.form['variation']
    brand = request.form['brand']
    category = request.form['category']
    image = request.files['pImage']
    if allowed_file(image.filename):
      filename = secure_filename(image.filename)
      image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    else:
      return "<script>alert('Invalid file extension!');window.location.href='/addProduct';</script>"
    url = "img/" + image.filename
    cur = con.cursor()
    cur.execute("INSERT INTO products (name,description,price,sku,stock,variation,brand,category_id) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(prodName,description,price,sku,stock,variation,
    brand,category))
    con.commit()

    cur.execute("SELECT  currval(pg_get_serial_sequence('products','product_id'))")
    id = cur.fetchone()

    cur.execute("Insert INTO product_images (product_id,image_name) VALUES (%s,%s)",(id,url))
    con.commit()
    cur.close()
    return "<script>alert('Product now Available!');window.location.href='/index';</script>"

@app.route("/submit", methods = ["GET","POST"])
def submit():

  if request.method == "POST":
    fname = request.form['fname']
    lname = request.form['lname']
    gender = request.form['gender']
    bday = request.form['bday']
    email = request.form['email']
    uname = request.form['uname']
    contact = request.form['contact']
    password = request.form['password']
    cpass = request.form['cpass']
    cur = con.cursor()
    cur.execute("SELECT username, email_address FROM customers WHERE username = %s AND email_address = %s ", (uname,email))
    row = cur.fetchall()
    if len(row) == 0:
      if password == cpass:
        cur = con.cursor()
        cur.execute("INSERT INTO customers (first_name,last_name,gender,birthday,email_address,username,password,contact) VALUES ( %s,%s,%s,%s,%s,%s,%s,%s) ", (fname,lname,gender,bday,
        email,uname,password, contact))
        con.commit()
        cur.close()
        return "<script>alert('Registered Successfully!');window.location.href='/index';</script>"
      else:
        return "<script>alert('Password and Confrim Password Doesnt match');window.location.href='/register';</script>"
    else:
      return "<script>alert('Username and Email Already Taken');window.location.href='/register';</script>"

@app.route("/verify", methods = ["GET","POST"])
def verify():

  if request.method == "POST":
    username = request.form['username']
    password = request.form['password']

    cur = con.cursor(cursor_factory=RealDictCursor)
    cur.execute("SELECT username,password FROM customers WHERE username = %s AND password = %s", (username,password))
    row = cur.fetchall()
    if len(row) == 1:
      session['username'] = username
      cur.close()
      return "<script>alert('Login Successfully');window.location.href='/index';</script>"
    else:
      return "<script>alert('Wrong Username or Password');window.location.href='/login';</script>"



  '''
  if request.method == "POST":
    uname = request.form['username']
    password = request.form['password']
    cur = con.cursor()
    cur.execute("SELECT username FROM customers WHERE username = %s",(uname))
    row = cur.fetchall()
    if len(row) == 1:
      cur = con.cursor(cursor_factory=RealDictCursor)
      cur.execute("SELECT password FROM customers WHERE username = %s",(uname))
      row = cur.fetchall()
      for r in row:
        check = bool(bcrypt.check_password_hash(row['password'],password))
      if check == True:
        session['username'] = uname
        cur.close()
        return render_template('index.html')
      else:
        alert = "Invalid Password"
        return render_template('login.html', alert = alert)
    else:
          alert = "Invalid Username"
          return render_template('login.html', alert = alert) 
  '''
@app.route("/logout")
def logout():
  session.pop("username",None)
  return "<script>alert('User has been logged out');window.location.href='index.html';</script>" 

@app.route("/login")
def login():
  return render_template('login.html')

@app.route("/shop")
def shop():
  cur = con.cursor(cursor_factory=RealDictCursor)
  cur.execute("SELECT * FROM Products INNER JOIN product_images on products.product_id = product_images.product_id")
  products = cur.fetchall()
  return render_template('shop.html',products = products)

@app.route("/product/<product_id>")
def product(product_id):
  if "username" in session:
    cur = con.cursor(cursor_factory=RealDictCursor)
    cur.execute("Select *  from products inner join product_images on products.product_id = product_images.product_id WHERE products.product_id = %s",(product_id))
    product = cur.fetchall()
    cur.close()
    return render_template('product.html',products = product)
  else:
    return "<script>alert('Log-In First');window.location.href='/login';</script>"

@app.route("/shopping-cart")
def shopingCart():
  return render_template('shopping-cart.html')

@app.route("/account")
def account():
  return render_template('account.html')

@app.route("/myaccount")
def myaccount():
  if "username" in session:
    return render_template('myaccount.html')
  else:
    return "<script>alert('Log-In First');window.location.href='/login';</script>"

@app.route("/checkout")
def checkout():
  return render_template('checkout.html')

@app.route("/contact")
def contact():
  return render_template('contact.html')

@app.route('/search', methods=['POST'])
def search():
    category = request.form['category']
    search = request.form['search']
    cur = con.cursor(cursor_factory=RealDictCursor)
    cur.execute("Select *  from products inner join product_images on products.product_id = product_images.product_id WHERE products.category_id = %s OR products.name = %s",(category,search))
    products = cur.fetchall()
    return render_template('shop.html', products=products, category=category)


if __name__ == '__main__':
    app.run(debug=True)
