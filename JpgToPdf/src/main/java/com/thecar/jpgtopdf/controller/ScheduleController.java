package com.thecar.jpgtopdf.controller;


import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.io.*;

@Component
public class ScheduleController {

    @Scheduled(cron = "0 0 21 * * *")
//    @Scheduled(cron ="0/10 * * * * *")
    public static void fileRemoveSchedule() throws Exception {
        String jpgPath = "/data/jpg/";
        String pdfPath = "/data/pdf/";
        FileRemove(jpgPath);
        FileRemove(pdfPath);
    }


    public static void FileRemove(String path) throws Exception {
        System.err.println("===========================파일 삭제 스케줄 시작===========================");
        File folder = new File(path);

        try {
            if (folder.exists()) {
                File[] folder_list = folder.listFiles();

                for (int i = 0; i < folder_list.length; i++) {
                    if(folder_list[i].isFile()) {
                        folder_list[i].delete();
                        System.err.println("파일이 삭제 되었습니다.");
                    } else {
                        FileRemove(folder_list[i].getPath());
                        System.err.println("폴더가 삭제되었습니다.");
                    }
                    folder_list[i].delete();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.err.println("===========================파일 삭제 스케줄 끝===========================");
    }
}
