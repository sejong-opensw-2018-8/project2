package file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ① 파일명 가져오기
				String fileName = request.getParameter("file");
				
				// ② 경로 가져오기
				String directory = this.getServletContext().getRealPath("/upload/");
				File file = new File(directory + "/" + fileName);
				System.out.println("파일명 : " + fileName);
				
				
				// ③ MIMETYPE 설정하기
				String mimeType = getServletContext().getMimeType(file.toString());
				if(mimeType == null)
				{
					response.setContentType("application/octet-stream");
				}
				
				// ④ 다운로드용 파일명을 설정
				String downloadName = null;
				if(request.getHeader("user-agent").indexOf("MSIE") == -1)
				{
					downloadName = new String(fileName.getBytes("UTF-8"), "8859_1");
				}
				else
				{
					downloadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
				}
				
				// ⑤ 무조건 다운로드하도록 설정
				response.setHeader("Content-Disposition","attachment;fileName=\"" + downloadName + "\";");
				
				// ⑥ 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
				FileInputStream fileInputStream = new FileInputStream(file);
				ServletOutputStream servletOutputStream = response.getOutputStream();
				
				byte b [] = new byte[1024];
				int data = 0;
				
				while((data=(fileInputStream.read(b, 0, b.length))) != -1)
				{
					servletOutputStream.write(b, 0, data);
				}
				
				servletOutputStream.flush();
				servletOutputStream.close();
				fileInputStream.close();
		
		
	}

	

}
