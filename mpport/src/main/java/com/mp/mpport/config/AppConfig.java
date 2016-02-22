package com.mp.mpport.config;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.mp.mpport.domain.Client;
import com.mp.mpport.domain.Contractor;
import com.mp.mpport.domain.ClientKey;
import com.mp.mpport.domain.User;
import com.mp.mpport.domain.UserRole;

@EnableTransactionManagement
@ComponentScan(basePackages = { "com.mp.mpport" })
@Configuration
public class AppConfig {

    @Bean(name = "dataSource")
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://us-cdbr-iron-east-03.cleardb.net/heroku_ade30ad02af5a2a");
        ds.setUsername("bfbb1bb0709a1a");
        ds.setPassword("62edde00");
      return ds;
        
    }

    @Bean(name = "sessionFactory")
    public SessionFactory sessionFactory() {
        LocalSessionFactoryBuilder sessionBuilder = new LocalSessionFactoryBuilder(dataSource());
        sessionBuilder.addAnnotatedClasses(User.class, UserRole.class, Contractor.class, ClientKey.class, Client.class);
        sessionBuilder.addProperties(getHibernateProperties());
       return sessionBuilder.buildSessionFactory();
    }
    
    public Properties getHibernateProperties(){
        Properties props = new Properties();
        props.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        props.setProperty("hibernate.show_sql", "false");
        props.setProperty("hibernate.hbm2ddl.auto", "update");
        return props;
    }
    
    @Bean(name = "transactionManager")
    public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory){
        HibernateTransactionManager tm = new HibernateTransactionManager(sessionFactory);
        return tm;
    }
    
    @Bean
    protected CommonsMultipartResolver multipartResolver(){
        CommonsMultipartResolver mpr = new CommonsMultipartResolver();
        mpr.setMaxUploadSize(10240000);
        return mpr;
    }
}
