/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package principal;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.stream.Collectors;

import javax.net.ssl.HttpsURLConnection;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.OutputStreamWriter;
import java.util.List;

public class HttpConn {

	private final String USER_AGENT = "Mozilla/5.0";

	// HTTP GET request
	public List<Filme> sendGet(String url) throws Exception {
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod("GET");

		//add request header
		con.setRequestProperty("User-Agent", USER_AGENT);

		int responseCode = con.getResponseCode();

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		return stringToList(response.toString());

	}
        
        public List<Filme> stringToList(String arrayAsString) {
            ObjectMapper mapper = new ObjectMapper();
            List<Filme> filmes = null;

            try {

                filmes = Arrays.asList(mapper.readValue(arrayAsString, Filme[].class));

            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return filmes;
        }
        
        public Map<String, Object> stringToJson(String mapAsString) {
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> map = new HashMap<String, Object>();

            try {

                // convert JSON string to Map
                map = mapper.readValue(mapAsString, Map.class);

            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return map;
        }
	
	// HTTP POST request
	public Map<String, Object> sendPost(String url, String parameters) throws Exception {

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		//add reuqest header
		con.setRequestMethod("POST");
		
		// Send post request
		con.setDoOutput(true);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(parameters);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
                
                if(responseCode==404){
                    Map<String, Object> responseMap = new HashMap<String, Object>();
                    return responseMap;
                }

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
                
		//print result
		return stringToJson(response.toString());

	}
        
        // HTTP PUT request
	public Map<String, Object> sendPut(String url, String parameters) throws Exception {

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		//add reuqest header
		con.setRequestMethod("PUT");
		
		// Send post request
                con.setDoInput(true);
		con.setDoOutput(true);
                con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                wr.writeBytes(parameters);
                wr.close();
                con.getInputStream();

		int responseCode = con.getResponseCode();
                
                if(responseCode==404){
                    Map<String, Object> responseMap = new HashMap<String, Object>();
                    return responseMap;
                }

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
                
		//print result
		return stringToJson(response.toString());

	}
        
        // HTTP DELETE request
	public Map<String, Object> sendDelete(String url, String parameters) throws Exception {

		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		//add reuqest header
		con.setRequestMethod("DELETE");
		
		// Send post request
                con.setDoInput(true);
		con.setDoOutput(true);
                con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                wr.writeBytes(parameters);
                wr.close();
                con.getInputStream();

		int responseCode = con.getResponseCode();
                
                if(responseCode==404){
                    Map<String, Object> responseMap = new HashMap<String, Object>();
                    return responseMap;
                }

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
                
		//print result
		return stringToJson(response.toString());

	}
}
