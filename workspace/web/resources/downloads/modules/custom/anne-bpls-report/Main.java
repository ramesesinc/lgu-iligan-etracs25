/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import com.rameses.osiris2.test.OsirisTestPlatform;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.swing.UIManager;

public class Main {

    public static void main(String[] args) throws Exception {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
        } catch(Exception ex) {;} 
        
        Map env = new HashMap(); 
        env.put("app.host","localhost:8570"); 
        env.put("app.context","etracs25"); 
        env.put("app.cluster","osiris3"); 
        env.put("app.debug",true); 
        env.put("app.devmode",true); 
        
        env.put("app.custom", "iligan");
        env.put("report.custom", "iligan");

        OsirisTestPlatform.runTest(env, new HashMap(), new HashMap()); 
    }
}
