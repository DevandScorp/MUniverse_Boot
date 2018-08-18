package com.boot.repository;

import com.boot.entity.Music;
import com.boot.entity.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MusicRepository extends CrudRepository<Music,Long> {
    List<Music> findByAuthor(User user);
}
