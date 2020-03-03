from flask import Flask, render_template, request, session
import psycopg2
from flask_bcrypt import Bcrypt
from psycopg2.extras import RealDictCursor

con = psycopg2.connect(
  host = "localhost",
  dbname = "pyapp_db",
  user = "pyapp",
  password = "password"
)

bcrypt = Bcrypt()

app = Flask(__name__)

@app.route("/")
def index():
  return render_template('index.html')

@app.route("/index.html")
def mainP():
  return render_template('index.html')

@app.route("/register.html")
def register():
  return render_template('register.html')

@app.route("/addProduct.html")
def addProduct():
  return render_template('addProduct.html')

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
        return "<script>alert('Registered Successfully!');window.location.href='index.html';</script>"
      else:
        return "<script>alert('Password and Confrim Password Doesnt match');window.location.href='register.html';</script>"
    else:
      return "<script>alert('Username and Email Already Taken');window.location.href='register.html';</script>"

@app.route("/verify", methods = ["GET","POST"])
def verify():

  if request.method == "POST":
    username = request.form['username']
    password = request.form['password']

    cur = con.cursor(cursor_factory=RealDictCursor)
    cur.execute("SELECT username,password FROM customers WHERE username = %s AND password = %s", (username,password))
    row = cur.fetchall()
    if len(row) == 1:
      #session['username'] = username
      cur.close()
      return "<script>alert('Login Successfully');window.location.href='index.html';</script>"
    else:
      return "<script>alert('Wrong Username or Password');window.location.href='login.html';</script>"



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

@app.route("/login.html")
def login():
  return render_template('login.html')

@app.route("/shop.html")
def shop():
  return render_template('shop.html')

@app.route("/shopping-cart.html")
def shopingCart():
  return render_template('shopping-cart.html')

@app.route("/account.html")
def account():
  return render_template('account.html')

@app.route("/checkout.html")
def checkout():
  return render_template('checkout.html')

@app.route("/contact.html")
def contact():
  return render_template('contact.html')

if __name__ == '__main__':
    app.run(debug=True)