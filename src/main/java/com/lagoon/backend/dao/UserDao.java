package com.lagoon.backend.dao;

import com.lagoon.backend.model.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Le on 4/24/2016.
 */

@Repository
public interface UserDao extends CrudRepository <User, Long> {
    List<User> findAll();

    User findByUserName(String userName);

    User findByUserId(Long userId);

    User save(User user);
}
