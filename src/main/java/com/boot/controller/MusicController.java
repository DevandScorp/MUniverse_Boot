package com.boot.controller;

import com.boot.entity.Music;
import com.boot.entity.User;
import com.boot.repository.MusicRepository;
import com.mpatric.mp3agic.ID3v2;
import com.mpatric.mp3agic.Mp3File;
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

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
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
        Iterable<Music> all = musicRepository.findAll();
        model.addAttribute("playlist",all);
        return "playlist";
    }
    private static void extractImageFromFile(String srcFile,String to) throws Exception {
        Mp3File song = new Mp3File(srcFile);
        if (song.hasId3v2Tag()){
            ID3v2 id3v2tag = song.getId3v2Tag();
            byte[] imageData = id3v2tag.getAlbumImage();
            //converting the bytes to an image
            BufferedImage img = ImageIO.read(new ByteArrayInputStream(imageData));
            File f = new File(to);
            String format = "jpg";
            ImageIO.write(img, format, f);
        }

    }
    @PostMapping("/playlist")
    public String getPlayList(@AuthenticationPrincipal User user,
                              @RequestParam("file") MultipartFile file){
        Music music = new Music();
        if(file!=null){
            try {
                music.setFilename(file.getOriginalFilename().substring(0,file.getOriginalFilename().indexOf(".mp3")));
                File file1 = new File("../../../../../../../../../../"+ uploadPath + "/Songs/" + file.getOriginalFilename());
                file.transferTo(file1);
                try {
                    extractImageFromFile("../../../../../../../../../../"+ uploadPath + "/Songs/" + file.getOriginalFilename(),
                                            "../../../../../../../../../../"+ uploadPath + "/Songs/" +
                                                    file.getOriginalFilename().substring(0,file.getOriginalFilename().indexOf(".mp3"))+".jpg");
                } catch (Exception e) {
                    e.printStackTrace();
                }
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
        return "redirect:/playlist";
    }
}
