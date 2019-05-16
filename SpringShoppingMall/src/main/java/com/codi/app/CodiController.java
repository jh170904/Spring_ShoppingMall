package com.codi.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;
import java.util.ListIterator;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codi.dao.CodiDAO;
import com.codi.dao.MemberDAO;
import com.codi.dto.CodiDTO;
import com.codi.dto.MemberDTO;
import com.codi.util.MyUtil;

@Controller("codiController")
public class CodiController {

	@Autowired
	@Qualifier("codiDAO")
	CodiDAO dao;
	
	@Autowired
	MyUtil myUtil;// Bean 객체 생성
	
	//업로드한 코디 사진파일 이름
	static String fileName="";
	
	@RequestMapping(value = "/codi/category.ajax", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
	public List<CodiDTO> category(String category,HttpServletRequest req, HttpSession session) throws IOException{

		//System.out.println(category);
		String cp = req.getContextPath();

		List<CodiDTO> lists;

		lists = dao.getListCtg(category);
	
		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		
		return lists;
	}
	
	@RequestMapping(value = "/codi/codicreated.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String codicreated(HttpServletRequest req, HttpSession session) throws IOException{
			 
		List<String> good = null;
		 
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = dao.getDataCount();

		int numPerPage = 6;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<CodiDTO> lists;


		lists = dao.getList(start, end);
		
	
		// 이미지저장 경로 보내주기
		String imagePath = req.getSession().getServletContext().getRealPath("/upload");

		// String imagePath =
		// req.getSession().getServletContext().getRealPath("/WEB-INF/files");

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/codi/codicreated.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		req.setAttribute("listUrl", listUrl);
		req.setAttribute("imagePath", imagePath);
		req.setAttribute("lists", lists);
		req.setAttribute("good", good);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageNum", pageNum);
		
		return "codi/codicreated";
	}

	//파일 캡처해서 이미지 서버에 업로드
	@RequestMapping(value="/codi/imageCreate.ajax", method = {RequestMethod.POST, RequestMethod.GET})
	public void createImage (HttpServletRequest request) throws Exception{

		//System.out.println("컨트롤러들어옴");
		String binaryData = request.getParameter("imgSrc");
		
		FileOutputStream stream = null;

		//System.out.println("binary file   "  + binaryData);
		try{
			//System.out.println("binary file   "  + binaryData);
			if(binaryData == null || binaryData=="") {
				throw new Exception();    
			}

			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
			byte[] file = Base64.decodeBase64(binaryData);
			//System.out.println("file  :::::::: " + file + " || " + file.length);
			 fileName=  UUID.randomUUID().toString();

			String path=request.getSession().getServletContext().getRealPath("/upload")+"\\makecodi\\"+fileName+".png";
			stream = new FileOutputStream(path);
			//stream = new FileOutputStream("d:\\test2\\"+fileName+".png");
			stream.write(file);
			stream.close();
			//System.out.println("파일 작성 완료");

		}catch(Exception e){
			//System.out.println("파일이 정상적으로 넘어오지 않았습니다");

		}finally{
			stream.close();
		}

	}
	
	@RequestMapping(value = "/codi/insertBoard.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertBoard(HttpServletRequest request,HttpSession session,String str,RedirectAttributes redirectAttributes) throws Exception{
		
		
		String[] array = str.split(",");
	
		for(int i=0;i<array.length;i++) {
			int codiCount = dao.getCodiCount(array[i]);
			dao.updateCodiCount(array[i],codiCount+1);
		}

		MemberDTO info = (MemberDTO)session.getAttribute("customInfo"); 
		
		String userid = info.getUserId();
		
		int inum=dao.getMaxNum();
		
		//System.out.println(str);
		//System.out.println(fileName);
		dao.insertCodi(inum+1, str,fileName,userid);
		
		redirectAttributes.addAttribute("iNum",inum+1);
		redirectAttributes.addAttribute("iImage",fileName);

		return "redirect:/myPage/instarWrited.action";
	}
	
	@RequestMapping(value = "/codi/deleteBoard.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteBoard(HttpServletRequest request,HttpSession session,int iNum,RedirectAttributes redirectAttributes) throws Exception{

		String pageNum = request.getParameter("pageNum");
		String path = request.getSession().getServletContext().getRealPath("/upload/makecodi");

		//폴더에서 삭제
		String deleteImage = dao.getiImage(iNum);
		
		String deleteFile = path +"\\"+ deleteImage+".png";
		System.out.println(deleteFile);
		File deletefile = new File(deleteFile);
        deletefile.delete();

		//codiCount-1		
        String productList = dao.getProductList(iNum);
        
        String[] array = productList.split(",");
	
		for(int i=0;i<array.length;i++) {
			int codiCount = dao.getCodiCount(array[i]);
			dao.updateCodiCount(array[i],codiCount-1);
		}
		
		//DB에서 삭제
		dao.deleteBoard(iNum);
		
		
		redirectAttributes.addAttribute("pageNum",pageNum);
		
		return "redirect:/myPage/myInstarLists.action";
	}

}
