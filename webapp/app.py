from flask import Flask, render_template, redirect, url_for, session

from forms import Login

app = Flask(__name__)
app.config['SECRET_KEY'] = '1234567890'

@app.route("/", methods=['GET','POST'])
def index():
    session['logged_in'] = False
    form = Login()
    return render_template('login.html',form=form)

@app.route('/logout')
def logout():
    session['logged_in'] = False
    return redirect(url_for('index'))

@app.route('/login',methods=['GET','POST'])
def login():
    form = Login()
    if form.validate_on_submit():
        print('OK')
        session['logged_in'] = True
        session['id'] = 0
        return redirect(url_for('main'))
    print('NOT OK')
    return render_template('login.html',form=form)

@app.route('/main')
def main():
    if session['logged_in']:
        return render_template('main.html')
    return redirect(url_for('index'))

if __name__ == "__main__":
    app.run()