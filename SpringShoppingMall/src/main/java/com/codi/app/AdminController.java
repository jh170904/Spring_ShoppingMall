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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codi.dao.CouponDAO;
import com.codi.dao.OrderDAO;
import com.codi.dao.ProductDAO;
import com.codi.dao.ProductDetailDAO;
import com.codi.dao.ReviewDAO;
import com.codi.dto.AdminPaymentDTO;
import com.codi.dto.CouponDTO;
import com.codi.dto.DestinationDTO;
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
	MyUtil myUtil;
	
	
	//��ǰ���
	@RequestMapping(value = "/admin/productAdminCreate.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String productadminCreate(HttpServletRequest req) {

		return "admin/productAdminCreate";
	}

	@RequestMapping(value = "/admin/productAdminCreate_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String productAdminCreate_ok(ProductDTO dto, ProductDetailDTO detailDTO, MultipartHttpServletRequest request, String str)
			throws Exception {

		// 1. ����Ʈ ������ ������ �ø��� �۾�

		// Spring3.0���� ��ΰ� �ٲ� : WEB-INF�� files��� ������ �����ؼ� �����ض�
		String path = request.getSession().getServletContext().getRealPath("/upload/list");
		String detailImagePath = request.getSession().getServletContext().getRealPath("/upload/productDetail");
		// D:\sts-bundle\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SpringShoppingMall\

		// �̸����� file�� �޾ƿ�
		MultipartFile file = request.getFile("productListImage");

		// ������ �����Ѵٸ� ���ε� �ϱ�
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

		// 2. DB�� �ֱ�
		dto.setOriginalName(file.getOriginalFilename());
		dto.setSaveFileName(file.getOriginalFilename());

		productDAO.insertData(dto);
		
		// ��ǰ ���̹��� ���
		// ���ε��� ���̹��� ���� ���� ����
		// ���̹����� ÷�������� 3������ ����
		for (int i=1; i<=3; i++) {		
			String productDetailImage = "productDetailImage"+i;
			//�̸����� file�� �޾ƿ�
			MultipartFile detailFile = request.getFile(productDetailImage);
			//���Ͼ��ε�
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
				
				//DB�ݿ�
				detailDTO.setOriginalName(detailFile.getOriginalFilename());
				detailDTO.setSaveFileName(detailFile.getOriginalFilename());
				
				//������ǰ���Է½�
				if(detailDTO.getSuperProduct()==null) {
					//���ϻ�ǰ�� ��ǰ��ȸ
					String superProduct = productDetailDAO.searchSuperProduct(detailDTO.getProductName());
					//��� ���� ��� �ڽ��� �ֻ�����ǰ
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
		// 1. ����Ʈ ������ ������ �ø��� �۾�
		// Spring3.0���� ��ΰ� �ٲ� : WEB-INF�� files��� ������ �����ؼ� �����ض�
		String path = request.getSession().getServletContext().getRealPath("/upload/list");
		String detailImagePath = request.getSession().getServletContext().getRealPath("/upload/productDetail");

		// �̸����� file�� �޾ƿ�
		MultipartFile file = request.getFile("productListImage");

		// ������ �����Ѵٸ� ���ε� �ϱ�
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

		// 2. DB�� �ֱ�
		if(file != null && file.getSize() > 0) {
			//������� ������ �ִ� ���
			dto.setOriginalName(file.getOriginalFilename());
			dto.setSaveFileName(file.getOriginalFilename());
		}else {
			//������� ������ ���� ��� ���������� �״�� ���
			ProductDetailDTO beforedto = productDetailDAO.getReadData(dto.getProductId());
			dto.setOriginalName(beforedto.getOriginalName());
			dto.setSaveFileName(beforedto.getSaveFileName());
		}
		
		//product���̺� ����
		productDetailDAO.updateData(dto);
		
		// ��ǰ ���̹��� ���
		// ���ε��� ���̹��� ���� ���� ����
		// ���̹����� ÷�������� 3������ ����
		for (int i=1; i<=3; i++) {		
			String productDetailImage = "productDetailImage"+i;
			//�̸����� file�� �޾ƿ�
			MultipartFile detailFile = request.getFile(productDetailImage);
			//���Ͼ��ε�
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
				
				//DB�ݿ�
				detailDTO.setOriginalName(detailFile.getOriginalFilename());
				detailDTO.setSaveFileName(detailFile.getOriginalFilename());
				
				//������ǰ���Է½�
				if(detailDTO.getSuperProduct()==null) {
					//���ϻ�ǰ�� ��ǰ��ȸ
					String superProduct = productDetailDAO.searchSuperProduct(detailDTO.getProductName());
					//��� ���� ��� �ڽ��� �ֻ�����ǰ
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
		
		// DB���� ����
		productDAO.productAdminDelete(productId);
		
		// ������ ���� ����
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
	
	
	//����
	@RequestMapping(value = "/admin/couponAdminCreated_ok.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String couponAdminCreated_ok(HttpServletRequest req, HttpSession session,CouponDTO dto,int period) {

		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    cal.add(Calendar.DATE, period);
	     
	    // Ư�� ������ ��¥�� ���� �̱�
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

		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<CouponDTO> lists = couponDAO.getList(start, end);

		// ����¡�� ���� ���� �����ֱ�
		String listUrl = cp + "/admin/couponAdminList.action";

		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		System.out.println(lists);
		
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("lists", lists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("pageNum", pageNum);

		return "admin/couponAdminList";
	}
	
	//�ֹ�����
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
				dto.setProductName(orderDAO.adminPaymentCheckProduct(dto.getOrderNum()) +" �� "  + dto.getOrderCount() + "��");
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
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String orderNum = request.getParameter("orderNum");
		int price = Integer.parseInt(request.getParameter("price"));
		String userId = orderDAO.searchUserId(orderNum);
		
		//�ֹ� ������ ����
		orderDAO.updateOrderDataProduct(userId, orderNum);
		
		//����Ʈ ����
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

}