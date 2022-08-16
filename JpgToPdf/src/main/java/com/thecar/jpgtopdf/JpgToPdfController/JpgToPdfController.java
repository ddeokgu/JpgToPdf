package com.thecar.jpgtopdf.JpgToPdfController;

import org.apache.commons.fileupload.FileUpload;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.io.*;
import java.util.*;
import java.util.List;


@Controller
@RequestMapping("/pdfConvert")
public class JpgToPdfController {

    @Value("${upload.file.path}")
    private static String uploadPath;

    @Value("${download.file.path}")
    private static String downloadPath;

    @RequestMapping("/jpgFileUpload.do")
    public static Map FileUpload(List<MultipartFile> multiFileList
            , HttpServletRequest request) throws Exception {
        System.err.println("호출됨");

        String uuid = UUID.randomUUID().toString();
        //String path = uploadPath+"/"+uuid;
        String path = "/Users/kimdeokha/Desktop/jpg/"+uuid;
        int fileLength = multiFileList.size();
        File folder   = new File(path);
        InputStream in = null;
        OutputStream os = null;
        Map resultMap = new HashMap();

        try{
            if(!folder.exists()) { // 폴더가 존재하지 않으면 (file이 아님 저장될 경로에 폴더임)
                folder.mkdirs(); // 새폴더를 생성하고
            }

            if (fileLength > 0) {
                for (int i = 0; i < fileLength; i++) {
                    String orgFileName = multiFileList.get(i).getOriginalFilename();
                    multiFileList.get(i).transferTo(new File(path +"/"+ orgFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
                }
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        resultMap.put("fileName", uuid);
        resultMap.put("filePath", path);
        return resultMap;
    }

    @RequestMapping("/pdf.do")
    public static void createPdf(@RequestParam("multiFile") List<MultipartFile> multiFileList
            , HttpServletRequest request) throws Exception {

        System.err.println("호출됨2");
        String result = "";
        Map fileMap = new HashMap();
        fileMap = FileUpload(multiFileList, request);
        String folderName = fileMap.get("filePath").toString();
        String pdfName = fileMap.get("fileName").toString();

         try {

             File dir = new File(folderName);
             //Post를 통해 생성할 이미지를 가져옴
             File[] imgFiles = dir.listFiles();

            PDDocument doc = new PDDocument();
            for (int i = 0; i < imgFiles.length; i++) {

                System.err.println("루프도는 중..." + i);

                // 이미지 사이즈 확인
                Image img = ImageIO.read(imgFiles[i]);

                // PDF 페이지 생성
                PDPage page = new PDPage(PDRectangle.A4);

                doc.addPage(page);

                // PDF에 삽입할 이미지 인자값 - 이미지 경로, PDF 페이지
                PDImageXObject pdImage = PDImageXObject.createFromFile(imgFiles[i].toString(), doc);

                // 현재 설정된 PDF 페이지의 가로/세로 구하기
                int pageWidth = Math.round(page.getCropBox().getWidth());
                int pageHeight = Math.round(page.getCropBox().getHeight());

                // 이미지 가로사이즈가 PDF 가로사이즈보다 클 경우를 대비해서 이미지 리사이징
                // 현재 설정된 PDF 페이지 가로, 이미지 가로 사이즈로 비율 측정
                float imgWidthRatio = 1;
                float imgHeightRatio = 1;

                if (pageWidth < img.getWidth(null)) {
                    imgWidthRatio = (float) img.getWidth(null) / (float) pageWidth;
                    imgHeightRatio = (float) img.getHeight(null) / (float) pageHeight;

                }

                // 이미지 비율 다시 맞추기
                int imgWidth = Math.round(img.getWidth(null) / imgWidthRatio);
                int imgHeight = Math.round(img.getHeight(null) / imgHeightRatio);

                // 가운데 정렬
                int pageWidthPosition = (pageWidth - imgWidth) / 2;
                int pageHeightPosition = (pageHeight - imgHeight) / 2;
                PDPageContentStream contents = new PDPageContentStream(doc, page);
                contents.drawImage(pdImage, pageWidthPosition, pageHeightPosition, imgWidth, imgHeight);

                contents.close();

            }

            result = "success";

            doc.save("/Users/kimdeokha/Desktop/pdfTest/"+pdfName+".pdf");

            doc.close();

        }catch (Exception e) {
            result = "error";
            e.printStackTrace();
        }
        System.err.println(result);
    }

    public static File multipartToFile(MultipartFile multipartFile) throws IllegalStateException, IOException {
        File file = new File(multipartFile.getOriginalFilename());
        multipartFile.transferTo(file);
        return file;
    }


}
