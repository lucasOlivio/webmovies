from flask import Flask, render_template, redirect, url_for

from forms import Login

app = Flask(__name__)
app.config['SECRET_KEY'] = '1234567890'

@app.route("/", methods=['GET','POST'])
def index():
    form = Login()
    if form.validate_on_submit():
        print('OK')

        return redirect(url_for('index'))
    return render_template('login.html',form=form)

if __name__ == "__main__":
    app.run()