package com.bigjava.util;

import com.bigjava.bean.User;

import java.util.*;

public class RemoveList {
    //     剔除根据list对象id属性相同
    public List<User> removeDupliById(List<User> persons) {
        Set<User> personSet = new TreeSet<>(Comparator.comparing(User::getId));
        personSet.addAll(persons);
        return new ArrayList<>(personSet);
    }
}
