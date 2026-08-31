import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import fr.ulille.but.sae_s2_2026.AlgorithmeKPCC;
import fr.ulille.but.sae_s2_2026.Chemin;
import fr.ulille.but.sae_s2_2026.Connexion;
import fr.ulille.but.sae_s2_2026.Lieu;
import fr.ulille.but.sae_s2_2026.ModaliteTransport;
import fr.ulille.but.sae_s2_2026.MultiGrapheOrienteValue;

public class Plateforme {
    private MultiGrapheOrienteValue graphe;
    public static final String FICHIER_RESEAU = "res/exemple-reseau.csv";
    public static final String FICHIER_CORRESPONDANCES = "res/exemple-correspondances.csv";

    public Plateforme() {
        graphe = new MultiGrapheOrienteValue();
    }
    public Arret getArret(String nom, ModaliteTransport modalite) {
        for (Lieu lieu : graphe.sommets()) {
            if (lieu instanceof Arret) {
                Arret arret = (Arret) lieu;
                if (arret.getNom().equals(nom) && arret.getType() != null && arret.getType().equals(modalite)) return arret;
            }
        }
        return null; 
    }

    public List<String> getVilles() {
        Set<String> villes = new HashSet<>();
        for (Lieu lieu : graphe.sommets()) {
            if (lieu instanceof Arret) {
                Arret arret = (Arret) lieu;
                if (arret.getNom() != null && arret.getType() != null) {
                    villes.add(arret.getNom());
                }
            }
        }
        List<String> liste = new ArrayList<>(villes);
        Collections.sort(liste);
        return liste;
    }

    public void chargerReseau(File fichierReseau) {
        try (BufferedReader br = new BufferedReader(new FileReader(fichierReseau))) {
            String ligne = br.readLine();
            do {
                String[] morceaux = ligne.split(";");
                String nomDepart = morceaux[0].trim();
                String nomArrivee = morceaux[1].trim();
                ModaliteTransport modaliteLigne = ModaliteTransport.valueOf(morceaux[2].trim().toUpperCase());

                double prix = Double.parseDouble(morceaux[3]);
                double co2 = Double.parseDouble(morceaux[4]);
                double temps = Double.parseDouble(morceaux[5]);

                Arret depart = enregistrerArret(nomDepart, modaliteLigne);
                Arret arrivee = enregistrerArret(nomArrivee, modaliteLigne);
                Cout cout = new Cout(temps, prix, co2);

                Trajet aller = new Trajet(depart, arrivee, modaliteLigne, cout);
                Trajet retour = new Trajet(arrivee, depart, modaliteLigne, cout);
                // on donne un poids de 0 car on définira les poids par rapport au critère choisi plus tard
                ajouterTrajet(aller);
                ajouterTrajet(retour);
                ligne = br.readLine();
            } while (ligne != null && ligne.trim().length() > 0);
        } catch (IOException e) {
            System.out.println("Erreur lors de la lecture du fichier réseau");
            e.printStackTrace();
        }
    }
    
    public void chargerCorrespondances(File fichierCorrespondances) {
        try (BufferedReader br = new BufferedReader(new FileReader(fichierCorrespondances))) {
            String ligne = br.readLine();
            do {
                String[] morceaux = ligne.split(";");
                String nom = morceaux[0].trim();
                ModaliteTransport modaliteDepart = ModaliteTransport.valueOf(morceaux[1].trim().toUpperCase());
                ModaliteTransport modaliteArrivee = ModaliteTransport.valueOf(morceaux[2].trim().toUpperCase());

                double prix = Double.parseDouble(morceaux[3]);
                double co2 = Double.parseDouble(morceaux[4]);
                double temps = Double.parseDouble(morceaux[5]);

                Arret depart = enregistrerArret(nom, modaliteDepart);
                Arret arrivee = enregistrerArret(nom, modaliteArrivee);
                Cout cout = new Cout(temps, prix, co2);

                // null pour les correspondances
                Trajet aller = new Trajet(depart, arrivee, null, cout);
                Trajet retour = new Trajet(arrivee, depart, null, cout);
                
                ajouterTrajet(aller);
                ajouterTrajet(retour);
                ligne = br.readLine();
            } while (ligne != null && ligne.trim().length() > 0);
        } catch (IOException e) {
            System.out.println("Erreur lors de la lecture du fichier correspondances");
            e.printStackTrace();
        }
    }

    public List<Chemin> comparer(Arret depart, Arret arrivee, Voyageur voyageur) throws NoResultException {
        return comparer(depart, arrivee, voyageur, 4, null);
    }

    public List<Chemin> comparer(Arret depart, Arret arrivee, Voyageur voyageur, int nombre) throws NoResultException {
        return comparer(depart, arrivee, voyageur, nombre, null);
    }

    public List<Chemin> comparer(Arret depart, Arret arrivee, Voyageur voyageur, int nombre, Set<ModaliteTransport> modes) throws NoResultException {
        TypeCout typeCout = voyageur.getCritere();
        for (Connexion c : graphe.aretes()) {
            Trajet t = (Trajet) c;
            Cout cout = t.getCout();
            double valeur = cout.getValeur(typeCout);
            graphe.modifierPoidsArete(t, valeur);
        }
        List<Chemin> kpcc = AlgorithmeKPCC.kpcc(graphe, depart, arrivee, nombre);
        if (kpcc.size() == 0) {
            throw new NoResultException();
        }
        return kpcc;
    }

    public List<Voyage> comparerVoyages(Arret depart, Arret arrivee, Voyageur voyageur, int maxResultats, Map<TypeCout, Double> limites) throws NoResultException, AllResultFilteredException {
        return comparerVoyages(depart, arrivee, voyageur, maxResultats, limites, null);
    }

    public List<Voyage> comparerVoyages(Arret depart, Arret arrivee, Voyageur voyageur, int maxResultats, Map<TypeCout, Double> limites, Set<ModaliteTransport> modes) throws NoResultException, AllResultFilteredException {
        List<Chemin> chemins = comparer(depart, arrivee, voyageur, 4*maxResultats);
        List<Voyage> voyages = new ArrayList<>();
        HashSet<String> vus = new HashSet<>();
        for (Chemin chemin : chemins) {
            Voyage voyage = new Voyage(chemin);
            if (respecteLimites(voyage, limites) && respecteModes(voyage, modes)) {
                StringBuilder sb = new StringBuilder();
                for (Trajet t : voyage.getEtapes()) {
                    sb.append(t.getDepart().getNom()).append(t.getArrivee().getNom()).append(t.getModalite());
                }
                if (vus.add(sb.toString())) {
                    voyages.add(voyage);
                    if (voyages.size() == maxResultats) {
                        break;
                    }
                }
            }
        }
        if (voyages.size() == 0) {
            if (modes != null) {
                throw new NoResultException();
            }
            throw new AllResultFilteredException();
        }
        return voyages;
    }

    private static boolean respecteModes(Voyage voyage, Set<ModaliteTransport> modes) {
        if (modes == null || modes.isEmpty()) return true;
        for (Trajet t : voyage.getEtapes()) {
            if (t.getModalite() != null && !modes.contains(t.getModalite())) {
                return false;
            }
        }
        return true;
    }

    public static void trierVoyages(List<Voyage> voyages, TypeCout critere1, TypeCout critere2, TypeCout critere3) {
        voyages.sort((v1, v2) -> {
            int c1 = Double.compare(v1.getCoutTotal(critere1), v2.getCoutTotal(critere1));
            if (c1 != 0) {
                return c1;
            }
            int c2 = Double.compare(v1.getCoutTotal(critere2), v2.getCoutTotal(critere2));
            if (c2 != 0) {
                return c2;
            }
            return Double.compare(v1.getCoutTotal(critere3), v2.getCoutTotal(critere3));
        });
    }

    private static boolean respecteLimites(Voyage voyage, Map<TypeCout, Double> limites) {
        if (limites == null || limites.isEmpty()) {
            return true;
        }
        for (Map.Entry<TypeCout, Double> entree : limites.entrySet()) {
            Double max = entree.getValue();
            if (max != null && voyage.getCoutTotal(entree.getKey()) > max) {
                return false;
            }
        }
        return true;
    }

    public Arret enregistrerArret(String nom, ModaliteTransport modalite) {
        Arret arret = new Arret(nom.trim(), modalite);
        graphe.ajouterSommet(arret);
        return arret;
    }

    public Arret creerArretVille(String nom, boolean arrive) {
        for (Lieu lieu : graphe.sommets()) {
            if (lieu instanceof Arret) {
                Arret a = (Arret) lieu;
                if (a.getNom().equals(nom.trim()) && a.getType() == null) {
                    return a;
                }
            }
        }
        Arret arret = new Arret(nom.trim(), null);
        graphe.ajouterSommet(arret);
        for (ModaliteTransport m : ModaliteTransport.values()) {
            Arret dest = getArret(nom, m);
            if (dest != null) {
                ajouterTrajet(new Trajet(arret, dest, null, new Cout(0, 0, 0)));
                ajouterTrajet(new Trajet(dest, arret, null, new Cout(0, 0, 0)));
            }
        }
        return arret;
    }

    public void ajouterTrajet(Trajet trajet) {
        if (trajet != null) {
            graphe.ajouterArete(trajet, 0);
        }
    }
}
