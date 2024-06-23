package frgp.utn.edu.ar.daoImp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import frgp.utn.edu.ar.dao.IdaoUsuario;
import frgp.utn.edu.ar.entidad.Usuario;

public class DaoUsuario implements IdaoUsuario{
	private ConfigHibernate conexion;
	
	public DaoUsuario() {
	}
	public DaoUsuario(ConfigHibernate conexion) {
		this.setConexion(conexion);
	}

	public boolean Add(Usuario usuario) {
		boolean estado = true;
	    conexion = new ConfigHibernate();
	    Session session = null;

	    try {
	        session = conexion.abrirConexion();
	        session.beginTransaction();
	        session.save(usuario);
	        session.flush();
	        session.getTransaction().commit();
	        Usuario savedUsuario = (Usuario) session.get(Usuario.class, usuario.getNombreUser());
	        
	        if (savedUsuario == null) {
	            estado = false;
	        }
	        
	    } catch (Exception e) {
	        if (session != null) {
	            Transaction transaction = session.getTransaction();
	            if (transaction != null && transaction.isActive()) {
	                transaction.rollback();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null && session.isOpen()) {
	            session.close();
	        }
	       }
	    
	    return estado;
	}

	public Usuario ReadOne(String usuario) {
		Session session = conexion.abrirConexion();
		session.beginTransaction();
		Usuario user = (Usuario)session.get(Usuario.class,usuario);
		return user;
	}

	public List<Usuario> ReadAll() {
		conexion = new ConfigHibernate();
	    Session session = conexion.abrirConexion();
        session.beginTransaction();
        List<Usuario> usuario= session.createQuery("FROM Usuario").list();
        return usuario;
	}

	public boolean Exist(String nombreUser) {
		Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    
	    String hql = "FROM Usuario p WHERE p.nombreUser = :nombreUser";
	    Query query = session.createQuery(hql);
	    query.setParameter("nombreUser", nombreUser);
	    Usuario usuario = (Usuario) query.uniqueResult();
	    session.getTransaction().commit();
	    session.close();
	    return usuario != null;
	}
	
	public Usuario Login(String nombreUser) {
		Session session = conexion.abrirConexion();
	    session.beginTransaction();
	    String hql = "FROM Usuario p WHERE p.nombreUser = :nombreUser";
	    Query query = session.createQuery(hql);
	    query.setParameter("nombreUser", nombreUser);
	    Usuario usuario = (Usuario) query.uniqueResult();
	    session.getTransaction().commit();
	    session.close();
	    return usuario;
	}

    public boolean Delete(String nombreUser) {
        boolean estado = false;
        Session session = null;

        try {
            session = conexion.abrirConexion();
            session.beginTransaction();
            Usuario usuario = (Usuario) session.get(Usuario.class, nombreUser);
            if (usuario != null) {
                session.delete(usuario);
                session.getTransaction().commit();
                estado = true;
            }
        } catch (Exception e) {
            if (session != null) {
                session.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return estado;
    }
    
	public ConfigHibernate getConexion() {
		return conexion;
	}
	public void setConexion(ConfigHibernate conexion) {
		this.conexion = conexion;
	}

}
