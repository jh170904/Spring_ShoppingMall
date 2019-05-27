package com.codi.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codi.dao.CouponDAO;
import com.codi.dao.MemberDAO;
import com.codi.dao.OrderDAO;
import com.codi.dao.ProductDAO;
import com.codi.dao.ProductDetailDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.AdminPaymentDTO;
import com.codi.dto.CouponDTO;
import com.codi.dto.DestinationDTO;
import com.codi.dto.EmailDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.OrderDTO;
import com.codi.dto.OrderListDTO;
import com.codi.dto.ProductDTO;
import com.codi.dto.ProductDetailDTO;
import com.codi.dto.ReviewDTO;
import com.codi.util.MyUtil;

@Controller
public class AdminController {
	
	@Autowired
	@Qualifier("couponDAO")
	CouponDAO couponDAO;
	
	@Autowired
	@Qualifier("productDAO")
	ProductDAO productDAO;
	
	@Autowired
	@Qualifier("productDetailDAO")
	ProductDetailDAO productDetailDAO;
	
	@Autowired
	@Qualifier("reviewDAO")
	ReviewDAO reviewDAO;
	
	@Autowired
	@Qualifier("orderDAO")
	OrderDAO orderDAO;
	
	@Autowired
	@Qualifier("memberDAO")
	MemberDAO memberDAO;
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	private JavaMailSender mailSender;
	private String from = "codi@codi.com"; 	
	
	//상품등록
	@RequestMapping(value = "/admin/productAdminCreate.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String productadminCreate(HttpServletRequest req) {

		return "admin/productAdminCreate";
	}

	@RequestMapping(value = "/admin/productAdminCreate_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String productAdminCreate_ok(ProductDTO dto, ProductDetailDTO detailDTO, MultipartHttpServletRequest request, String str)
			throws Exception {

		// 1. 리스트 파일을 서버에 올리는 작업

		// Spring3.0에서 경로가 바뀜 : WEB-INF에 files라는 폴더를 생성해서 저장해라
		String path = request.getSession().getServletContext().getRealPath("/upload/list");
		String detailImagePath = request.getSession().getServletContext().getRealPath("/upload/productDetail");
		// D:\sts-bundle\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SpringShoppingMall\

		// 이름으로 file을 받아옴
		MultipartFile file = request.getFile("productListImage");

		// 파일이 존재한다면 업로드 하기
		if (file != null && file.getSize() > 0) {

			try {

				FileOutputStream fos = new FileOutputStream(path + "/" + file.getOriginalFilename());

				InputStream is = file.getInputStream();

				byte[] buffer = new byte[512];

				while (true) {

					int data = is.read(buffer, 0, buffer.length);

					if (data == -1) {
						break;
					}

					fos.write(buffer, 0, data);
				}

				is.close();
				fos.close();

			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}

		// 2. DB에 넣기
		dto.setOriginalName(file.getOriginalFilename());
		dto.setSaveFileName(file.getOriginalFilename());

		productDAO.insertData(dto);
		
		// 상품 상세이미지 등록
		// 업로드한 상세이미지 파일 정보 추출
		// 상세이미지는 첨부파일이 3개까지 가능
		for (int i=1; i<=3; i++) {		
			String productDetailImage = "productDetailImage"+i;
			//이름으로 file을 받아옴
			MultipartFile detailFile = request.getFile(productDetailImage);
			//파일업로드
			if(detailFile!=null && detailFile.getSize()>0) {
				
				try {
					FileOutputStream fos = new FileOutputStream(detailImagePath + "/" + detailFile.getOriginalFilename());
					InputStream is = detailFile.getInputStream();
					byte[] buffer = new byte[512];
					
					while(true) {
						int data = is.read(buffer,0,buffer.length);
						if(data==-1) {
							break;
						}
						fos.write(buffer,0,data);
					}
					is.close();
					fos.close();
					
				} catch (Exception e) {
					System.out.println(e.toString());
				}
				
				//DB반영
				detailDTO.setOriginalName(detailFile.getOriginalFilename());
				detailDTO.setSaveFileName(detailFile.getOriginalFilename());
				
				//상위상품미입력시
				if(detailDTO.getSuperProduct()==null) {
					//동일상품명 상품조회
					String superProduct = productDetailDAO.searchSuperProduct(detailDTO.getProductName());
					//결과 없을 경우 자신이 최상위상품
					if(superProduct==null) {
						detailDTO.setSuperProduct(detailDTO.getProductId());
					} else {
						detailDTO.setSuperProduct(superProduct);
					}
				}
				String detailNum = detailDTO.getProductId()+"-"+i;
				detailDTO.setDetailNum(detailNum);
				productDetailDAO.insertData(detailDTO);
			}
		}
		return "redirect:/admin/productAdminList.action";
	}
	
	@RequestMapping(value = "/admin/productAdminUpdate.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String productadminUpdate(String productId, HttpServletRequest request) {
		
		ProductDetailDTO dto = productDetailDAO.getUpdateData(productId);

		request.setAttribute("dto", dto);
		return "admin/productAdminUpdate";
	}
	
	@RequestMapping(value = "/admin/productAdminUpdate_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String productAdminUpdate_ok(ProductDTO dto, ProductDetailDTO detailDTO, MultipartHttpServletRequest request, String str)
			throws Exception {
		// 1. 리스트 파일을 서버에 올리는 작업
		// Spring3.0에서 경로가 바뀜 : WEB-INF에 files라는 폴더를 생성해서 저장해라
		String path = request.getSession().getServletContext().getRealPath("/upload/list");
		String detailImagePath = request.getSession().getServletContext().getRealPath("/upload/productDetail");

		// 이름으로 file을 받아옴
		MultipartFile file = request.getFile("productListImage");

		// 파일이 존재한다면 업로드 하기
		if (file != null && file.getSize() > 0) {

			try {

				FileOutputStream fos = new FileOutputStream(path + "/" + file.getOriginalFilename());

				InputStream is = file.getInputStream();

				byte[] buffer = new byte[512];

				while (true) {

					int data = is.read(buffer, 0, buffer.length);

					if (data == -1) {
						break;
					}

					fos.write(buffer, 0, data);
				}

				is.close();
				fos.close();

			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}

		// 2. DB에 넣기
		if(file != null && file.getSize() > 0) {
			
			//수정등록 파일이 있는 경우
			dto.setOriginalName(file.getOriginalFilename());
			dto.setSaveFileName(file.getOriginalFilename());
			
		}else if(dto.getFileCategory()!=null){
			//수정등록 파일이 없는 경우 기존데이터 그대로 사용
			ProductDetailDTO beforedto = productDetailDAO.getReadData(dto.getProductId());
			if(beforedto.getFileCategory()!=null) {
				dto.setOriginalName(beforedto.getOriginalName());
				dto.setSaveFileName(beforedto.getSaveFileName());
			}
		}
		
		//product테이블 수정
		productDetailDAO.updateData(dto);
		
		// 상품 상세이미지 등록
		// 업로드한 상세이미지 파일 정보 추출
		// 상세이미지는 첨부파일이 3개까지 가능
		for (int i=1; i<=3; i++) {		
			String productDetailImage = "productDetailImage"+i;
			//이름으로 file을 받아옴
			MultipartFile detailFile = request.getFile(productDetailImage);
			//파일업로드
			if(detailFile!=null && detailFile.getSize()>0) {
				
				try {
					FileOutputStream fos = new FileOutputStream(detailImagePath + "/" + detailFile.getOriginalFilename());
					InputStream is = detailFile.getInputStream();
					byte[] buffer = new byte[512];
					
					while(true) {
						int data = is.read(buffer,0,buffer.length);
						if(data==-1) {
							break;
						}
						fos.write(buffer,0,data);
					}
					is.close();
					fos.close();
					
				} catch (Exception e) {
					System.out.println(e.toString());
				}
				
				//DB반영
				detailDTO.setOriginalName(detailFile.getOriginalFilename());
				detailDTO.setSaveFileName(detailFile.getOriginalFilename());
				
				//상위상품미입력시
				if(detailDTO.getSuperProduct()==null) {
					//동일상품명 상품조회
					String superProduct = productDetailDAO.searchSuperProduct(detailDTO.getProductName());
					//결과 없을 경우 자신이 최상위상품
					if(superProduct==null) {
						detailDTO.setSuperProduct(detailDTO.getProductId());
					} else {
						detailDTO.setSuperProduct(superProduct);
					}
				}
				String detailNum = detailDTO.getProductId()+"-"+i;
				detailDTO.setDetailNum(detailNum);
				productDetailDAO.insertData(detailDTO);
			}
		}
		return "redirect:/admin/productAdminList.action";
	}

	@RequestMapping(value = "/admin/productAdminList.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String productAdminList(HttpServletRequest req) {

		List<ProductDTO> lists = productDAO.getAdminLists();

		req.setAttribute("lists", lists);

		return "admin/productAdminList";
	}

	@RequestMapping(value = "/admin/productAdminDelete.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String productAdminDelete(HttpServletRequest req) {

		String productId = req.getParameter("productId");
		String originalName = req.getParameter("originalName");

		String path = req.getSession().getServletContext().getRealPath("/upload/list/" + originalName);
		String detailImagePath = req.getSession().getServletContext().getRealPath("/upload/productDetail");
		
		// DB파일 삭제
		productDAO.productAdminDelete(productId);
		
		// 물리적 파일 삭제
		try {
			File file = new File(path);
			if (file.exists()) {
				file.delete();
			}
			
			file = new File(detailImagePath);
			if (file.exists()) {
				file.delete();
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "redirect:/admin/productAdminList.action";
	}
	
	
	//쿠폰
	@RequestMapping(value = "/admin/couponAdminCreated_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String couponAdminCreated_ok(HttpServletRequest req, HttpSession session,CouponDTO dto,int period) {

		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    cal.add(Calendar.DATE, period);
	     
	    // 특정 형태의 날짜로 값을 뽑기
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
		
		int maxNum = couponDAO.getMaxNum();
		
		dto.setCouponEndDate(strDate);
		dto.setCouponKey(maxNum+1);
		couponDAO.insertData(dto);
		
		
		return "redirect:/admin/couponAdminList.action";
	}	
	
	@RequestMapping(value = "/admin/couponAdminCreated.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String couponAdminCreated(HttpServletRequest req, HttpSession session) {
		
		return "admin/couponAdminCreate";
	}
	
	@RequestMapping(value = "/admin/couponAdminList.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String couponAdminList(HttpServletRequest req, HttpSession session) {
		
		String cp = req.getContextPath();

		String pageNum = req.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int dataCount = couponDAO.getDataCount();

		int numPerPage = 7;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<CouponDTO> lists = couponDAO.getList(start, end);

		// 페이징을 위한 값들 보내주기
		String listUrl = cp + "/admin/couponAdminList.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		System.out.println(lists);
		
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("pageNum", pageNum);

		return "admin/couponAdminList";
	}
	
	@RequestMapping(value = "admin/couponAdminDeleted.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String couponAdminDeleted(int couponKey, HttpServletRequest req, RedirectAttributes redirectAttributes, HttpSession session) {

		String pageNum = req.getParameter("pageNum");
		
		if(pageNum==null || pageNum.equals(""))
			pageNum = "1";

		couponDAO.deleteCoupon(couponKey);		
		
		redirectAttributes.addAttribute("pageNum", pageNum);

		return "redirect:/admin/couponAdminList.action";
	}
	
	//주문관리 
	@RequestMapping(value = "/admin/bankbookPaymentAdmin.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String bankkbookPaymentAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
			
		int currentPage = 1;
			
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		String searchOrderName = request.getParameter("searchOrderName");
		
		if(searchOrderName==null || searchOrderName.equals("")) {
			searchOrderName="";
		}
		
		int numPerPage = 7;
		int totalPage = myUtil.getPageCount(numPerPage, orderDAO.adminPaymentCheckCountAll(searchOrderName));
		
		if(currentPage>totalPage)
			currentPage = totalPage;
			
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
			
		List<AdminPaymentDTO> adminPaymentCheckList = orderDAO.adminPaymentCheck(start, end, searchOrderName);
		List<AdminPaymentDTO> adminPaymentCheck2List = orderDAO.adminPaymentCheck2();
		List<AdminPaymentDTO> adminDiscountPrice = orderDAO.adminDiscountPrice();
		
		Iterator<AdminPaymentDTO> it = adminPaymentCheckList.iterator();
		while(it.hasNext()) {
			AdminPaymentDTO dto = it.next();
			
			dto.setOrderCount(orderDAO.adminPaymentCheckCount(dto.getOrderNum()));
			if(dto.getOrderCount()>1) {
				dto.setProductName(orderDAO.adminPaymentCheckProduct(dto.getOrderNum()) +" 외 "  + dto.getOrderCount() + "건");
			}
			else {
				dto.setProductName(orderDAO.adminPaymentCheckProduct(dto.getOrderNum()));
			}
			
		}
			
		searchOrderName = URLEncoder.encode(searchOrderName, "UTF-8");
			
		String listUrl = cp + "/admin/bankbookPaymentAdmin.action?searchOrderName=" + searchOrderName;
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("adminPaymentCheckList", adminPaymentCheckList);
		request.setAttribute("adminPaymentCheck2List", adminPaymentCheck2List);
		request.setAttribute("adminDiscountPrice", adminDiscountPrice);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", orderDAO.adminPaymentCheckCountAll(searchOrderName));
		
		return "admin/order_bankbook_payment";
	}
	
	@RequestMapping(value = "/admin/without_bankbook_paymentYes.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String without_bankbook_paymentYes(OrderDTO orderDTO, OrderListDTO orderListDTO, DestinationDTO destinationDTO, ReviewDTO reviewDTO,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		MemberDTO info = (MemberDTO) session.getAttribute("customInfo");
		
		String orderNum = request.getParameter("orderNum");
		int price = Integer.parseInt(request.getParameter("price"));
		String userId = orderDAO.searchUserId(orderNum);
		
		//리뷰 입력
		int reviewCount = orderDAO.reviewCount()+1;
		
		reviewDTO.setUserId(userId);
		
		List<OrderDTO> orderList = orderDAO.getOrderNumData(orderNum);		
		Iterator<OrderDTO> orderLists = orderList.iterator();
		while(orderLists.hasNext()){
			reviewDTO.setProductId(orderLists.next().getProductId().toString());
			reviewDTO.setReviewNum(reviewCount);
			orderDAO.insertReview(reviewDTO);		
			
			reviewCount++;
		}	
		
		//주문 데이터 변경
		orderDAO.updateOrderDataProduct(userId, orderNum);
		
		//포인트 적립
		orderDAO.updateMemberPoint(userId,(int)(price*0.01));
		
		int gradePoint = orderDAO.gradePoint(userId);
		String userGrade = "SILVER";
		if(gradePoint<500000) 
			userGrade = "SILVER";
		else if (gradePoint>=500000 && gradePoint<1000000) {
			userGrade = "GOLD";
		}
		else if(gradePoint>=1000000)
			userGrade = "VIP";
		
		orderDAO.updateGrade(userId, userGrade);	
		
		return "redirect:/admin/bankbookPaymentAdmin.action";
	}
	
	//리뷰 관리
	@RequestMapping(value = "/admin/reviewAdmin.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
			
		int currentPage = 1;
			
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, reviewDAO.countReportReview());

		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ReviewDTO> reviewNumAndCount = reviewDAO.reviewNumAndCount(start, end);
		List<ReviewDTO> adminReportReview= reviewDAO.reportedReview();
			
		String listUrl = cp + "/admin/reviewAdmin.action";
			
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("adminReportReview", adminReportReview);
		request.setAttribute("reviewNumAndCount", reviewNumAndCount);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("dataCount", reviewDAO.countReportReview());
			
		return "admin/reportReview";
	}
	
	@RequestMapping(value = "/admin/reviewAdminDelete.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String reviewAdminDelete(int reviewNum, HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		reviewDAO.deleteReviewAdmin(reviewNum);
		
		String cp = request.getContextPath();
				
		String pageNum = request.getParameter("pageNum");
			
		int currentPage = 1;
			
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, reviewDAO.countReportReview());

		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<ReviewDTO> reviewNumAndCount = reviewDAO.reviewNumAndCount(start, end);
		List<ReviewDTO> adminReportReview= reviewDAO.reportedReview();
			
		String listUrl = cp + "/admin/reviewAdmin.action";
			
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		
		request.setAttribute("adminReportReview", adminReportReview);
		request.setAttribute("reviewNumAndCount", reviewNumAndCount);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", reviewDAO.countReportReview());
			
		return "admin/reportReview";
	}
	
	//회원관리
	@RequestMapping(value = "/admin/memberList.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String cp = request.getContextPath();
				
		String pageNum = request.getParameter("pageNum");
			
		int currentPage = 1;
			
		if(pageNum!=null)
			currentPage = Integer.parseInt(pageNum);
		
		int numPerPage = 3;
		int totalPage = myUtil.getPageCount(numPerPage, reviewDAO.countReportReview());

		if(currentPage>totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		List<MemberDTO> memberList = (List<MemberDTO>) memberDAO.getAllData();
		
		String listUrl = cp + "/admin/memberList.action";
		
		request.setAttribute("memberList", memberList);
			
		return "admin/memberAdminList";
	}
	
	@RequestMapping(value = "/admin/sendEmail.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String sendEmail(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		if(dto.getUserName()=="all" || dto.getUserName().equals("all")) {
			dto.setEmail("전체발송");
		}
		
		request.setAttribute("dto", dto);
			
		return "admin/sendEmail";
	}
	
	@RequestMapping(value = "/admin/sendEmali_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String sendEmali_ok(EmailDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String style="\"";
		
		if(dto.getBold()!=null && dto.getBold().equals("")) {
			style += "font-weight: bold;";
		}
		if(dto.getUnderline()!=null && dto.getUnderline().equals("")) {
			style += "text-decoration:underline;";
		}
		if(dto.getItalic()!=null && dto.getItalic().equals("")) {
			style += "font-style: italic;";
		}
		if(dto.getLineThrough()!=null && dto.getLineThrough().equals("")) {
			style += "text-decoration: line-through;";
		}
		
		style += "font-size:" + dto.getFontsize() + ";";
		style += "font-family:verdana;";
		style += "color:" + dto.getColor() + "\"";

		 
		String content = dto.getContent().replaceAll("\n", "<br/>"); 
		
		//메일
		try {
        	
			MimeMessage message = mailSender.createMimeMessage(); 
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

	        
			String html = "<div>";
			
	        html+="<br/>안녕하세요. <strong>내일의 코디북</strong> 입니다.<br/><br/> ";   
	        html+="안내사항 알려드립니다.<br/><br/>";
	        html+="<p style="+ style +">";
	        html+= content;
	        html+="</p>";
	        html+="<br/><br/>더 궁금하신 내용은 yerin2407@gmail.com으로 메일 부탁드립니다.";
	        html+="</div>";

	        messageHelper.setText(html, true);

			messageHelper.setFrom(from); 
			messageHelper.setSubject(dto.getSubject());

			System.out.println(from);
			
			
			if(dto.getUserName()=="all" || dto.getUserName().equals("all")) {
				Iterator<String> emailList = memberDAO.allEmail().iterator();
				
				String email ="";
				while(emailList.hasNext()) {
					 email = emailList.next();
					 messageHelper.setTo(email);
					 mailSender.send(message);
				}
				
			} else {
				messageHelper.setTo(dto.getEmail());
				mailSender.send(message);
			}

		} catch (Exception e) {
			System.out.println("ㅅㅂ");
		}
			
		return "redirect:/admin/memberList.action";
	}
	
}
