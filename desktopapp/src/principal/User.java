/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package principal;

import java.util.List;
import java.util.Map;

/**
 *
 * @author lucas
 */
public class User {
    
    private Object id;
    private List<Filme> filmes;
    HttpConn request = new HttpConn();
    public User(Object id){
        this.id = id;
        this.loadFilmes();
    }
    
    public Object getId(){
        return this.id;
    }
    
    public void loadFilmes(){
        try {
            this.filmes = request.sendGet("http://localhost:2000/filmes?usuario="+this.id);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex);
        }
    }
    
    public List<Filme> getFilmes(){
        return this.filmes;
    }
}
