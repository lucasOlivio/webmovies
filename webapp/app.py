from flask import Flask, render_template, redirect, url_for, session, flash, request
import requests
from forms import * 
import json
from time import sleep

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
    msg = "Os campos não podem estar vazios!"
    form = Login()
    if form.validate_on_submit():
        post = {
            'email': form.email.data,
            'senha': form.senha.data
        }
        if request.form['login'] == 'Login':
            resp = json.loads(requests.post('http://localhost:2000/login', post).text)
        elif request.form['login'] == 'Novo usuário':
            resp = json.loads(requests.post('http://localhost:2000/addusuario', post).text)
            if resp['status'] == 'inserido':
                resp = json.loads(requests.post('http://localhost:2000/login', post).text)
            else:
                flash(resp['status'], category='danger')
                return render_template('login.html',form=form)
        try:
            print('OK')
            session['id'] = resp['id']
            session['user'] = form.email.data
            session['logged_in'] = True
            return redirect(url_for('main'))
        except:
            msg = resp[0]            
    flash(msg, category='danger')
    print('NOT OK')
    return render_template('login.html',form=form)

@app.route('/addFilm', methods=['POST','GET'])
def addFilm():
    if session['logged_in']:
        form = Filme()
        msg = 'O campo de nome não pode estar vazio!'
        category = 'danger'
        if form.filme.data:
            post = {
                'usuario': session['id'],
                'filme': form.filme.data
            }

            resp = json.loads(requests.post('http://localhost:2000/addfilme', post).text)
            try:
                msg = resp['status']
                category = 'success' if msg == 'inserido' else 'warning'
            except:
                msg = resp
        flash(msg, category=category)
        sleep(1)
        return redirect(url_for('main'))
    return redirect(url_for('index'))

@app.route('/marcarVisto', methods=['POST','GET'])
def marcarVisto():
    if session['logged_in']:
        if request.method == 'POST':
            post = {
                'usuario': session['id'],
                'filme': request.form['filme'],
                'visto': request.form['visto']
            }
            resp = json.loads(requests.put('http://localhost:2000/checkfilme', post).text)

            return redirect(url_for('main'))
    return redirect(url_for('index'))

@app.route('/removerFilme', methods=['POST','GET'])
def removerFilme():
    if session['logged_in']:
        if request.method == 'POST':
            post = {
                'usuario': session['id'],
                'filme': request.form['filme']
            }
            resp = json.loads(requests.delete('http://localhost:2000/removefilme', data=post).text)

            return redirect(url_for('main'))
    return redirect(url_for('index'))

@app.route('/removerUser', methods=['POST','GET'])
def removerUser():
    if session['logged_in']:
        if request.method == 'POST':
            post = {
                'id': request.form['user']
            }
            resp = json.loads(requests.delete('http://localhost:2000/removeusuario', data=post).text)

            return redirect(url_for('listarusers'))
    return redirect(url_for('index'))

@app.route('/editarFilme', methods=['POST','GET'])
def editarFilme():
    if session['logged_in']:
        if request.method == 'POST':
            post = {
                'usuario': session['id'],
                'filme': request.form['filme_old'],
                'novo_filme': request.form['filme']
            }
            resp = json.loads(requests.put('http://localhost:2000/updatefilme', post).text)
            sleep(1)
            return redirect(url_for('main'))
    return redirect(url_for('index'))

@app.route('/listarusers', methods=['GET'])
def listarusers():
    if session['logged_in']:
        resp = json.loads(requests.get('http://localhost:2000/usuarios', ).text)
        return render_template('users.html',users=resp)
    return redirect(url_for('index'))

@app.route('/main')
def main():
    if session['logged_in']:
        form = Filme()
        respRanking = json.loads(requests.get('http://localhost:2000/rankingfilmes').text)

        respFilmes = json.loads(requests.get('http://localhost:2000/filmes?usuario='+str(session['id']), ).text)

        return render_template('main.html',form=form,filmes=respFilmes, ranking=respRanking)
    return redirect(url_for('index'))

if __name__ == "__main__":
    app.run()