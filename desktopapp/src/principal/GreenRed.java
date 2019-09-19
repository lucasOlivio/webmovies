/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package principal;

import java.awt.Color;
import java.awt.Component;
     
import javax.swing.DefaultListCellRenderer;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JPanel;

/**
 *
 * @author lucas
 */
public class GreenRed {
         
    private JFrame frame;
    private JList list;
     
    public GreenRed() {
        frame = new JFrame( "GreenRed" );
         
        list = new JList();
        list.setCellRenderer( new GreenRedCellRenderer() );
        Object[] data = new Object[10];
        for ( int i = 0; i < data.length; i++ ) {
            data[i] = "Data " + ( i + 1 );
        }
        list.setListData( data );
        JPanel p = new JPanel();
        p.add( list );
        frame.getContentPane().add( p );
         
        frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        frame.setBounds( 300, 300, 300, 500 );
        frame.setVisible( true );
    }
     
    public static void main(String[] args) {
        new GreenRed();
    }
     
    private static class GreenRedCellRenderer extends DefaultListCellRenderer {
        public Component getListCellRendererComponent( JList list, Object value, int index, boolean isSelected, boolean cellHasFocus ) {
            Component c = super.getListCellRendererComponent( list, value, index, isSelected, cellHasFocus );
            if ( index % 2 == 0 ) {
                c.setBackground( Color.red );
            }
            else {
                c.setBackground( Color.green );
            }
            return c;
        }
    }
}