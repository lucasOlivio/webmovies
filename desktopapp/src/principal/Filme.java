/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package principal;

/**
 *
 * @author lucas
 */
public class Filme {
    String _id, filme, posterPath;
    int usuario;
    boolean visto;

    public String get_id() {
        return this._id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getFilme() {
        return this.filme;
    }

    public void setFilme(String filme) {
        this.filme = filme;
    }

    public String getPosterPath() {
        return this.posterPath;
    }

    public void setPosterPath(String posterPath) {
        this.posterPath = posterPath;
    }

    public int getUsuario() {
        return this.usuario;
    }

    public void setUsuario(int usuario) {
        this.usuario = usuario;
    }

    public boolean isVisto() {
        return this.visto;
    }

    public void setVisto(boolean visto) {
        this.visto = visto;
    }
    
    @Override
    public String toString() {
        return this.getFilme();
    }
}
