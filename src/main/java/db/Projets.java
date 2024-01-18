package db;

import java.util.List;

public class Projets {
	private int id;
	private String libelle;
	private String description;
	private String idUser;
	private List<Tache> taches;
	public Projets(int id, String libelle, String description, String idUser) {
		super();
		this.id = id;
		this.libelle = libelle;
		this.description = description;
		this.idUser = idUser;
	}
	public Projets() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIdUser() {
		return idUser;
	}
	public void setIdUser(String string) {
		this.idUser = string;
	}
	public List<Tache> getTaches() {
		return taches;
	}
	public void setTaches(List<Tache> taches) {
		this.taches = taches;
	}
}
