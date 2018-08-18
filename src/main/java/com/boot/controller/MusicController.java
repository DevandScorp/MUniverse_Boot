package com.boot.controller;

import com.boot.entity.Music;
import com.boot.entity.User;
import com.boot.repository.MusicRepository;
import org.apache.tika.exception.TikaException;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.parser.ParseContext;
import org.apache.tika.parser.Parser;
import org.apache.tika.parser.mp3.Mp3Parser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.xml.sax.ContentHandler;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

@Controller
public class MusicController {
    @Autowired
    MusicRepository musicRepository;
    @Value("${upload.path}")
    private String uploadPath;
    @GetMapping("/playlist")
    public String getPlayList(@AuthenticationPrincipal User user, Model model){
        model.addAttribute("user",user);

        return "playlist";
    }

    @PostMapping("/playlist")
    public String getPlayList(@AuthenticationPrincipal User user,
                              @RequestParam("file") MultipartFile file){
        Music music = new Music();
        if(file!=null){
            try {
                music.setFilename(file.getOriginalFilename());
                File file1 = new File("../../../../../../../../../../"+ uploadPath + "/Songs/" + file.getOriginalFilename());
                file.transferTo(file1);
                try (InputStream input = new FileInputStream(file1)) {
                    ContentHandler handler = new DefaultHandler();
                    Metadata metadata = new Metadata();
                    Parser parser = new Mp3Parser();
                    ParseContext parseCtx = new ParseContext();
                    parser.parse(input, handler, metadata, parseCtx);
                    // Retrieve the necessary info from metadata
                    // Names - title, xmpDM:artist etc. - mentioned below may differ based
                    String title = metadata.get("title");
                    String artists = metadata.get("xmpDM:artist");
                    music.setSong(title);
                    music.setArtist(artists);
                } catch (TikaException e) {
                    e.printStackTrace();
                } catch (SAXException e) {
                    e.printStackTrace();
                }
                music.setAuthor(user);
                musicRepository.save(music);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "playlist";
    }
}
