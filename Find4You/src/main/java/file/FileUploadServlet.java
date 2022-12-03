package file;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

import java.sql.*;
import Connection.ConnectionProvider;

@WebServlet(name = "FileUploadServlet", urlPatterns = {"/upload"})
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
   
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		    

		    // Create path components to save the file
		     String path = "D:\\Find4You\\src\\main\\webapp\\Product";
		    final Part filePart = request.getPart("file");
		    final String fileExtension = getExtention(filePart);
		    final String description = request.getParameter("description");
		    final String title = request.getParameter("title");
		    final String userId = request.getParameter("userId");
		    int id = 0;
		    
		    try {
				Connection con = ConnectionProvider.getcon();
				String sql = "Select max(id) from products";
		        Statement st = con.createStatement();
		        ResultSet rs = st.executeQuery(sql);
		        id = 0;
		        if(rs.next()) {
		        	id = rs.getInt(1) + 1;
		        	
		        }else {
		        	id = 1;
		        }
		        con.close();
		    }catch(Exception e) {
		    	System.out.print(e);
		    }
		    final String fileName = "product"+id+"."+fileExtension;
		    
		   System.out.println("File Name = "+fileName+"\n Extention :"+fileExtension	);
		    
		    
		    OutputStream out = null;
		    InputStream filecontent = null;
		    

		    try {
		
		    	
		    	
		    if(fileExtension != null) {	
		    	out = new FileOutputStream(new File(path + File.separator
		                + fileName));
		        filecontent = filePart.getInputStream();

		        int read = 0;
		        final byte[] bytes = new byte[1024];

		        while ((read = filecontent.read(bytes)) != -1) {
		            out.write(bytes, 0, read);
		       
		        }
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
		        if (out != null) {
		            out.close();
		        }
		        if (filecontent != null) {
		            filecontent.close();
		        }
		        
		    }
		    
		    try {
				Connection con = ConnectionProvider.getcon();
				PreparedStatement ps = con.prepareStatement("INSERT INTO products(id,title,pro_description,location,artist_Id) Values(?,?,?,?,?)");
		        ps.setInt(1, id);
		        ps.setString(2, title);
		        ps.setString(3, description.trim());
		        ps.setString(4, fileName );
		        ps.setString(5, userId);
		        
		       
		        ps.executeUpdate();
		        response.sendRedirect("Artist/Dashboard.jsp?msg=success");
			}catch(Exception e) {
				
				System.out.println(e);
			}
	
	}

	
		private String getExtention(final Part part) {
		    final String partHeader = part.getHeader("content-disposition");
		    String Extention = null;
		    for (String content : partHeader.split(";")) {
		        System.out.println("Part Header : "+content);
		    	if (content.trim().startsWith("filename")) {
		            Extention = content.substring(
		                    content.lastIndexOf('.') + 1).trim().replace("\"", "");
		        }else {
		        	Extention = null;
		        }
		    }
		    return Extention;
		}
		
		
}
