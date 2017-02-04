package com.lagoon.backend.dao;

import com.lagoon.backend.model.Comment;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Le on 4/24/2016.
 */
@Repository
public interface CommentDao extends CrudRepository<Comment, Long> {

    Comment save(Comment comment);

    Comment findOne (Long commentId);

    List<Comment> findByPhotoId (Long photoId);
}
