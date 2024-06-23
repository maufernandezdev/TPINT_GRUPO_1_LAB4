package frgp.utn.edu.ar.daoImp;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class ConfigHibernate {

    private static ConfigHibernate instancia;
    private SessionFactory sessionFactory;
    private Session session;

    public ConfigHibernate() {
    	//Este new configuration no se puede sacar a un bean, es un new de código de hibernate
        Configuration configuration = new Configuration();
        configuration.configure();
        ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties())
                .buildServiceRegistry();
        sessionFactory = configuration.buildSessionFactory(serviceRegistry);
    }

    public static synchronized ConfigHibernate obtenerInstancia() {
        if (instancia == null) {
            instancia = new ConfigHibernate();
        }
        return instancia;
    }

    public Session abrirConexion() {
        session = sessionFactory.openSession();
        return session;
    }

    public void cerrarSession() {
        session.close();
    }

    public void cerrarSessionFactory() {
        sessionFactory.close();
    }

}