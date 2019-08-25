from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import DataRequired

class Login(FlaskForm):
    email = StringField('email', validators=[DataRequired()])
    senha = StringField('senha',validators=[DataRequired()])

class Filme(FlaskForm):
    filme = StringField('filme', validators=[DataRequired()])