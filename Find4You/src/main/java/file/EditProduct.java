package file;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

import java.sql.*;
import Connection.ConnectionProvider;


@MultipartConfig
public class EditProduct extends HttpServlet {
   
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		    // Create path components to save the file
		    String path = "D:\\Find4You\\src\\main\\webapp\\Product";
		    final Part filePart = request.getPart("file");
		    String fileExtension = null;
		    final String description = request.getParameter("description");
		    final String title = request.getParameter("title");
		    final int id = Integer.parseInt(request.getParameter("id"));
		    
		    final String partHeader = request.getPart("file").getHeader("content-disposition");
		    for (String content : partHeader.split(";")) {
		        if (content.trim().startsWith("filename")) {
		            fileExtension = content.substring(
		                    content.lastIndexOf('.') + 1).trim().replace("\"", "");
		        }
		    }
		    if(fileExtension.contains("filename")) {
		    	fileExtension = null;
		    }
		   
		    
		    
		    try {
				Connection con = ConnectionProvider.getcon();
				
				OutputStream out = null;
			    InputStream filecontent = null;
			    try {  
			    if(fileExtension!=null) {
			   
			    final String fileName = "product"+id+"."+fileExtension;
				System.out.println("File Name = "+fileName+"\n Extention :"+fileExtension	);
				    
			    	
			    	
		    	out = new FileOutputStream(new File(path + File.separator
		                + fileName));
		        filecontent = filePart.getInputStream();
		        int read = 0;
		        final byte[] bytes = new byte[1024];

		        while ((read = filecontent.read(bytes)) != -1) {
		            out.write(bytes, 0, read);
		        }
		    
		        con = ConnectionProvider.getcon();
				PreparedStatement ps = con.prepareStatement("Update products Set title = ?,pro_description = ?,location = ? Where id = ?");
		        ps.setString(1, title);
		        ps.setString(2, description.trim());
		        ps.setString(3, fileName );
		        ps.setInt(4, id);
		        ps.executeUpdate();
		        response.sendRedirect("Artist/Dashboard.jsp?msg=success");
			
		        }else {
		        	con = ConnectionProvider.getcon();
					PreparedStatement ps = con.prepareStatement("Update products Set title = ?,pro_description = ? Where id = ?");
			        ps.setString(1, title);
			        ps.setString(2, description.trim());
			        ps.setInt(3, id);
			        ps.executeUpdate();
			        response.sendRedirect("Artist/Dashboard.jsp?msg=success");
					
		        }
		   
		    } catch (FileNotFoundException fne) {
		    	response.setContentType("text/html");
		    	PrintWriter writer = response.getWriter();
		        writer.println("You either did not specify a file to upload or are "
		                + "trying to upload a file to a protected or nonexistent "
		                + "location.");
		        writer.println("<br/> ERROR: " + fne.getMessage());
		        writer.close();

		    } finally {
		       
		    		if(out != null) {
		            out.close();
		            }
		            if(filecontent != null) {
		    		filecontent.close();
		            }
		        
		    }
		    }catch(Exception e) {
				
				System.out.println(e);
			}
	
	}

		
		
}
