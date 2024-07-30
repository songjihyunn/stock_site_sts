package com.pkt.controller;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pkt.model.BoardVO;
import com.pkt.model.Criteria;
import com.pkt.model.PageMaker;
import com.pkt.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	@GetMapping("listCri")
	public void listCri(Criteria cri, Model model) {
		log.info("list_Criteria......................");

		model.addAttribute("list", service.listCriteria(cri));
	}
	
	@GetMapping("listAll")
	public void listPage(Criteria cri, Model model, BoardVO board) {
		log.info(cri.toString());
		
		model.addAttribute("list", service.listAll());
		//model.addAttribute("list", service.listCriteria(cri)); //현재 페이지 리스트 출력 내용
		model.addAttribute("list", service.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();

		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(service.listCountCriteria(cri)); //총 게시물 수 
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker); //현재 페이지에 해당하는 페이징 값들
	}
	
	
	// 글 등록
	@GetMapping("/register")
	public void registerGet(Criteria cri, HttpSession session, Model model) {
		log.info("register get........");
		PageMaker pageMaker = new PageMaker();
 
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(service.listCountCriteria(cri)); //총 게시물 수
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker); //현재 페이지에 해당하는 페이징 값들
        String userid = (String) session.getAttribute("id");
		model.addAttribute("userid",userid);
	}
 
 
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@PostMapping("/register")
	public String registPOST(BoardVO board, RedirectAttributes rttr, MultipartFile[] file, @RequestParam("code") String code) throws Exception {
		log.info("regist post ...........");
		
		board.setCode(code);
		System.out.println("code:" + code);
		
		//첨부 null 처리
		board.setFile01("");
		board.setFile02("");
		board.setFile03("");
		board.setFile01_thum("");

		String savedName[] = new String[file.length];  //저장 파일명 배열 처리

		for(int i=0; i<file.length; i++) {

			if(file[i].getSize() > 0) { //파일크기가 0보다 크다면 : 파일 유무

				log.info("originalName: " + file[i].getOriginalFilename());
				log.info("size: " + file[i].getSize()); //byte 단위
				log.info("contentType: " + file[i].getContentType());

				Date today = new Date();
				SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddhhmmss");
				String signdate = cal.format(today);

				savedName[i] = signdate + "_" + file[i].getOriginalFilename(); //날짜_파일명 처리
				byte[] fileData = file[i].getBytes();

				log.info("============= savedName["+i+"] ====:"+savedName[i]);

				File target = new File(uploadPath, savedName[i]);

				FileCopyUtils.copy(fileData, target); //파일 업로드


				// 첫 첨부 이미지만 썸네일 생성
				if(i == 0) {
					board.setFile01(savedName[i]);

				String new_name = "thum_" + savedName[0]; //썸네일 파일 이름
					//사이즈 크기
					int w = 50;
					int h = 50;
					String imgFormat = "jpg"; //기본 설정 초기화

					Image image = ImageIO.read(new File(uploadPath+"\\"+savedName[0])); //원본 이미지

					if(image != null) { //이미지 파일이 아닌 경우 null
						Image resizeImage = image.getScaledInstance(w,h,Image.SCALE_SMOOTH);

						BufferedImage newImage = new BufferedImage(w,h,BufferedImage.TYPE_INT_BGR);

						Graphics g = newImage.getGraphics();
						g.drawImage(resizeImage, 0, 0, null);
						g.dispose();

						ImageIO.write(newImage, imgFormat, new File(uploadPath+"\\"+new_name)); //파일 올리기

					board.setFile01_thum(new_name); //썸네일 이름 객체 추가
					} 
				}else if(i == 1) {
					board.setFile02(savedName[i]);
				}else if(i == 2) {
					board.setFile03(savedName[i]);
				}
			}
		}

		log.info(board.toString());

		service.regist(board);
		
		
		rttr.addFlashAttribute("msg", "register");

		return "redirect:/board/listAll";
	}

	
	// 상세페이지
	@GetMapping("/read")
	public void read(@RequestParam("bno")int bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("read get...........");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute(service.readOne(bno));
	}
	
	// 삭제
	@GetMapping("remove")
	public String remove(@RequestParam("bno") int bno, Criteria cri, RedirectAttributes rttr) throws Exception {
		//파일 삭제
		BoardVO board = service.readOne(bno); //해당 객체 불러오기

		File fileDelete01 = new File(uploadPath+"/"+board.getFile01());
		if( fileDelete01.exists() ){
			fileDelete01.delete();
		}
		File fileDelete_thum = new File(uploadPath+"/"+board.getFile01_thum());
		if( fileDelete_thum.exists() ){
			fileDelete_thum.delete();
		}
		File fileDelete02 = new File(uploadPath+"/"+board.getFile02());
		if( fileDelete02.exists() ){
			fileDelete02.delete();
		}
		File fileDelete03 = new File(uploadPath+"/"+board.getFile03());
		if( fileDelete03.exists() ){
			fileDelete03.delete();
		}

		service.remove(bno);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		rttr.addFlashAttribute("msg", "delete");

		return "redirect:/board/listAll";
	}
	
	// 수정
	@GetMapping("/modify")
	public void modifyGET(int bno, Model model, Criteria cri, RedirectAttributes rttr) {
		log.info("modify get ...........");

		model.addAttribute("page", cri.getPage());
		model.addAttribute("perPageNum", cri.getPerPageNum());
		model.addAttribute("searchType", cri.getSearchType());
		model.addAttribute("keyword", cri.getKeyword());
		log.info(model.toString());
		model.addAttribute(service.readOne(bno));
	}

	@PostMapping("modify")
	public String modifyPOST(BoardVO board, Criteria cri, RedirectAttributes rttr, MultipartFile[] file) throws Exception {
		String savedName[] = new String[file.length];  //저장 파일명 배열 처리
		
		for(int i=0; i<file.length; i++) { 

			if(file[i].getSize() > 0) { //파일크기가 0보다 크다면 : 파일 유무

				//존재하는 파일 삭제
				if(i == 0) {
					File fileDelete = new File(uploadPath+"/"+board.getFile01());
					if( fileDelete.exists() ){
						fileDelete.delete();
					}
					File fileDelete_thum = new File(uploadPath+"/"+board.getFile01_thum());
					if( fileDelete_thum.exists() ){
						fileDelete_thum.delete();
					}
				}else if(i == 1) {
					File fileDelete = new File(uploadPath+"/"+board.getFile02());
					if( fileDelete.exists() ){
						fileDelete.delete();
					}
				}else if(i == 2) {
					File fileDelete = new File(uploadPath+"/"+board.getFile03());
					if( fileDelete.exists() ){
						fileDelete.delete();
					}
				}

				log.info("originalName: " + file[i].getOriginalFilename());
				log.info("size: " + file[i].getSize()); //byte 단위
				log.info("contentType: " + file[i].getContentType());

				Date today = new Date();
				SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddhhmmss");
				String signdate = cal.format(today);

				savedName[i] = signdate + "_" + file[i].getOriginalFilename(); //날짜_파일명 처리
				byte[] fileData = file[i].getBytes();

				log.info("============= savedName["+i+"] ====:"+savedName[i]);

				File target = new File(uploadPath, savedName[i]);

				FileCopyUtils.copy(fileData, target); //파일 업로드

				// 첫 첨부 이미지만 썸네일 생성
				if(i == 0) {
					board.setFile01(savedName[i]);

					String new_name = "thum_" + savedName[0]; //썸네일 파일 이름

					//사이즈 크기
					int w = 50;
					int h = 50;
					String imgFormat = "jpg"; //기본 설정 초기화

					Image image = ImageIO.read(new File(uploadPath+"\\"+savedName[0])); //원본 이미지

					if(image != null) { //이미지 파일이 아닌 경우 null
						Image resizeImage = image.getScaledInstance(w,h,Image.SCALE_SMOOTH);

						BufferedImage newImage = new BufferedImage(w,h,BufferedImage.TYPE_INT_BGR);

						Graphics g = newImage.getGraphics();
						g.drawImage(resizeImage, 0, 0, null);
						g.dispose();

						ImageIO.write(newImage, imgFormat, new File(uploadPath+"\\"+new_name)); //파일 올리기

						board.setFile01_thum(new_name); //썸네일 이름 객체 추가
					} 
				}else if(i == 1) {
					board.setFile02(savedName[i]);
				}else if(i == 2) {
					board.setFile03(savedName[i]);
				}
			}
		}

		log.info(cri.toString()); 

		service.modify(board);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "modify");

		log.info(rttr.toString());

		return "redirect:/board/listAll";
	}
	
	//댓글
	@GetMapping("reply")
	public void ajaxTest() {		
		log.info("reply get ..........."); 
	}
	
	//업로드
	@GetMapping("/uploadForm2")
	public void uploadFormGet() {
		log.info("uploadForm Get.....................");
	}
	
	//검색
	@GetMapping("search")
	public void search(Criteria cri, Model model) {
	    log.info(cri.toString()); // Criteria 객체의 정보를 로그로 출력합니다.

	    // searchType을 't'로 설정합니다.
	    cri.setSearchType("t");
	    
	    // 전체 리스트를 모델에 추가합니다.
	    model.addAttribute("list", service.listAll());

	    // 검색 조건에 맞는 리스트를 모델에 추가합니다.
	    model.addAttribute("list", service.listSearchCriteria(cri));

	    PageMaker pageMaker = new PageMaker(); // 페이지 정보를 관리할 PageMaker 객체를 생성합니다.
	    pageMaker.setCri(cri); // PageMaker 객체에 현재 Criteria 객체를 설정합니다.

	    // 검색 조건에 맞는 총 게시물 수를 PageMaker에 설정합니다.
	    pageMaker.setTotalCount(service.listSearchCount(cri));

	    System.out.println("cri: " + cri);
	    
	    // PageMaker 객체를 모델에 추가하여 현재 페이지에 해당하는 페이징 값들을 뷰에 전달합니다.
	    model.addAttribute("pageMaker", pageMaker);
	    model.addAttribute("keyword", cri.getKeyword());
	    
	    System.out.println("keyword: " + cri.getKeyword());
	    System.out.println("pageMaker: " + pageMaker);
	}

}
