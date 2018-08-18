package com.boot.repository;

import com.boot.entity.Music;
import org.springframework.data.repository.CrudRepository;

public interface MusicRepository extends CrudRepository<Music,Long> {

}
