package file;

import java.io.File;

public class DeleteFile {
		
		public static boolean deletefile(String path,String filename) {
			File file = new File(path,filename);
			return file.delete();
		}
}
