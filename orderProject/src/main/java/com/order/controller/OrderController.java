package com.order.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.order.domain.OrderProductVO;
import com.order.domain.OrderVO;
import com.order.domain.PageDTO;
import com.order.domain.ProductVO;
import com.order.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class OrderController {

	@Autowired
	private OrderService service;
	
	@RequestMapping(value ="/orderList", method = RequestMethod.GET)
	public String orderList(Authentication authentication, Model model) {
		String userId = authentication.getName();
		
		// 해당 사용자의 주문내역
		List<OrderProductVO> orderVO = service.orderList(userId);
		// 해당 사용자의 주문개수
		int orderCount = service.orderCount(userId);
		
		model.addAttribute("userId", userId);
		model.addAttribute("orderList", orderVO);
		model.addAttribute("orderCount", orderCount);
		
		return "/orderList";
	}

	@RequestMapping(value ="/createProduct", method = RequestMethod.GET)
	public String createProduct(Model model) {
		model.addAttribute("type", "create");
		return "/createProduct";
	}

	@RequestMapping(value ="/createProduct", method = RequestMethod.POST)
	public String createProductPost(ProductVO vo ,Model model) {
		log.info("Create product controller with file upload");
				
		service.createProduct(vo);
		return "/productList";
	}
	
	@RequestMapping(value="/uploadImage", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String uploadImage(MultipartFile[] uploadFile) {
		log.info("Create product controller with file upload");
		
		// 업로드 폴더 지정
		String uploadFolder = "C:\\Users\\LEEJH\\Downloads\\orderProject\\src\\main\\webapp\\resources\\image\\";
		String viewFolder = "\\resources\\image\\";
		for(MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return viewFolder + uploadFile[0].getOriginalFilename();
	}
	
	@RequestMapping(value ="/updateProduct", method = RequestMethod.GET)
	public String updateProduct(@RequestParam("productId") String productId ,Model model) {
		log.info("update product controller");
		ProductVO prdtVO = service.productDetail(productId);
		model.addAttribute("type", "update");
		model.addAttribute("prdtVO", prdtVO);
		return "/createProduct";
	}
	
	@RequestMapping(value ="/updateProduct", method = RequestMethod.POST)
	public String updateProductPost(ProductVO vo ,Model model) {
		log.info("Update product controller with file upload");
				
		service.updateProduct(vo);
		return "/productList";
	}
		
	@RequestMapping(value ="/productDetail", method = RequestMethod.GET)
	public String productDetail(@RequestParam("productId") String productId, Model model) {
		log.info("Product detail controller.");
		log.info("##### productId : " + productId);
		ProductVO prdtVO = service.productDetail(productId);
		model.addAttribute("prdtVO", prdtVO);
		return "/productDetail";
	}
	
	@RequestMapping(value ="/productOrder", method = RequestMethod.GET)
	public String productOrder(@RequestParam("productId") String productId, Authentication authentication ,Model model) {
		log.info("productOrder Controller.");
		ProductVO prdtVO = service.productDetail(productId);
		// 로그인한 사용자 ID 받아오기
		String userId = authentication.getName();
		model.addAttribute("product", prdtVO);
		model.addAttribute("userId", userId);
		return "/productOrder";
	}
	
	@RequestMapping(value ="/productOrder", method = RequestMethod.POST)
	public String productOrderPost(OrderVO vo, Model model) {
		log.info("productOrder Controller Post.");
		service.orderProduct(vo);
		service.changeStock(vo);
		return "redirect:/productList";
	}

//	@RequestMapping(value ="/productList", method = RequestMethod.GET)
//	public String productList(Model model) {
//		List<ProductVO> productList = service.productList();
//		model.addAttribute("productList", productList);
//		log.info(productList);
//		return "/productList";
//	}

	@RequestMapping(value ="/productList", method = RequestMethod.GET)
	public String productList(PageDTO dto, @RequestParam(value="nowPage", required=false) String nowPage, 
			@RequestParam(value="cntPerPage", required=false) String cntPerPage, 
			@RequestParam(value="searchCat", required=false) String searchCategory, 
			@RequestParam(value="searchPrdtNm", required=false) String searchProductName, 
			@RequestParam(value="strtPrice", required=false) String searchStartPrice, 
			@RequestParam(value="endPrice", required=false) String searchEndPrice, Model model) {
		log.info("Product List with Paging");
		
		HashMap<String, Object> productList = new HashMap<String, Object>();
		
		if(searchCategory != null) {
			productList.put("searchCategory", searchCategory);
			model.addAttribute("searchCategory", searchCategory);
		}

		if(searchProductName != null) {
			productList.put("searchProductName", searchProductName);
			model.addAttribute("searchProductName", searchProductName);
		}
		
		if(searchStartPrice != null && searchEndPrice != null) {
			productList.put("searchStartPrice", searchStartPrice);
			productList.put("searchEndPrice", searchEndPrice);
			model.addAttribute("searchStartPrice", searchStartPrice);
			model.addAttribute("searchEndPrice", searchEndPrice);
		}
		
		int total = service.countProduct(productList);
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "9";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if(cntPerPage == null) {
			cntPerPage = "9";
		}
		
		dto = new PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));		
		productList.put("start", dto.getStart());
		productList.put("end", dto.getEnd());
		List<ProductVO> prdtList = service.productList(productList);

		model.addAttribute("paging", dto);
		model.addAttribute("productList", prdtList);
		return "/productList";
	}
	
	@RequestMapping(value = "/deleteProduct", method = RequestMethod.POST)
	@ResponseBody
	public Object deleteProduct(HttpServletRequest req) {
//		for(String productId : productIdList) {
//			log.info(productId);
//		}
		String[] arrStr = req.getParameterValues("arrStr");
		for(int i=0; i<arrStr.length; i++) {
            System.out.println("ajax traditional result : " + i +" : "+ arrStr[i]);
            service.deleteProduct(arrStr[i]+"");
	    }
		return "success";
	}
	
    @RequestMapping(value = "/user", method = RequestMethod.GET) 
    public String userName(Authentication authentication) { 
        
        String userName = authentication.getName();
        log.info(userName);
        return userName;
    } 
    
    @RequestMapping(value = "/deleteOrder", method = RequestMethod.POST)
    @ResponseBody
    public int deleteOrder(@RequestParam("orderId") String orderId) {
    	
    	log.info("deleteOrder Controller");
    	int result = service.deleteOrder(orderId);
    	
    	return result;
    }
}
