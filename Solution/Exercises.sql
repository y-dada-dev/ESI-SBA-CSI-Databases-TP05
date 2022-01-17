use bddtp5;

/*Requête 1 : Donner les livres en informatique qui sont écrits par des auteurs algériens et qui 
sont apparus avant l'an 2012*/
select l.IdLivre, l.titre
from livre l, ecrit e, auteur a
where (e.IdAuteur = a.IdAuteur) and (e.IdLivre = l.IdLivre) and (l.domaine = 'informatique') 
	  and (l.DateEdition<='2012-01-01') and (a.nationalité='Algérie');
       
/*Requête 2 : Donner les livres qui sont écrits que par des auteurs algériens*/
select l.*
from livre l
where not exists (select *
                  from ecrit e2, auteur a2
				  where (e2.IdAuteur = a2.IdAuteur) and (e2.IdLivre = l.IdLivre) and (a2.nationalité!='Algérie'))
						and exists (select *
			                        from ecrit e
                                    where (l.IdLivre=e.IdLivre));

select l.IdLivre, l.titre, a.nationalité
from livre l, ecrit e, auteur a
where (e.IdAuteur = a.IdAuteur) and (e.IdLivre = l.IdLivre) and (a.nationalité='Algérie')
      and not exists (select *
                      from ecrit e2, auteur a2
					  where (e2.IdAuteur = a2.IdAuteur) and (e2.IdLivre = l.IdLivre) and (a2.nationalité!='Algérie'));

select l.IdLivre, l.titre
from livre l
where 'Algérie' = all (select a.nationalité 
					   from ecrit e, auteur a 
					   where (e.IdAuteur = a.IdAuteur) and (e.IdLivre = l.IdLivre))
    and exists (select *
			    from ecrit e
				where (l.IdLivre=e.IdLivre));

/*Requête 3 : Donner les clients qui n'ont acheté aucun Livre dont le titre contient oracle ou php 
(proposer deux solutions : avec le not exists et avec not in)*/ 
select c.IdClient, c.nom
from `client` c
where not exists (select a.IdClient 
                  from achat a, livre l 
                  where (a.IdClient=c.IdClient) and (l.IdLivre=a.IdLivre) 
                        and ((l.titre like '%oracle%') or (l.titre like '%php%')));
 
select c.IdClient, c.nom
from `client` c
where c.IdClient not in (select a.IdClient
						 from livre l, achat a
						 where (l.IdLivre=a.IdLivre) and ((l.titre like '%oracle%') or (l.titre like '%php%')));
 
/*Requête 4 : Donner les auteurs qui ont écrit des livres édités par l'éditeur ENI ou DUNOD*/
select a.IdAuteur, a.nom, a.prenom
from auteur a, ecrit ec
where (a.IdAuteur=ec.IdAuteur) and ec.IdLivre in (select l.IdLivre
												  from livre l, editeur e
												  where (l.IdEditeur = e.IdEditeur) and ((e.nom='ENI') or (e.nom='DUNOD')));
 
/*Requête 5 : Donner les auteurs qui ont écrit à la fois des livres édités par l'éditeur ENI et l'éditeur DUNOD*/
select a.*
from auteur a
where a.IdAuteur in (select ec2.IdAuteur
                     from ecrit ec, ecrit ec2  
                     where (ec.IdAuteur=ec2.IdAuteur)
	                       and ec.IdLivre in  (select l.IdLivre
				                               from livre l, editeur e
				                               where (l.IdEditeur=e.IdEditeur) and (e.nom='ENI')) 
	                       and ec2.IdLivre in (select l.Idlivre
						                       from livre l, editeur e
						                       where (l.IdEditeur=e.IdEditeur) and (e.nom='DUNOD')));

select a.*
from editeur e, livre l, auteur a, ecrit ec
where (l.IdEditeur=e.IdEditeur) and (a.IdAuteur=ec.IdAuteur) and (l.IdLivre=ec.IdLivre) and (e.nom='ENI')
	  and Exists (select *
                  from editeur e2, livre l2, ecrit ec2
	  		      where (l2.IdEditeur=e2.IdEditeur) and (a.IdAuteur=ec2.IdAuteur)
                        and (l2.IdLivre=ec2.IdLivre) and (e2.nom='DUNOD'));

/*Requête 6 : Donner le livre le plus vendu à Sidi Bel Abbes*/
select l.*, sum(a.Quantite)
from livre l join achat a join librairie lib on (l.IdLivre=a.IdLivre) and (lib.IdLib=a.IdLib)
where (lib.ville='sba')
group by l.IdLivre
having sum(a.Quantite) >= all (select sum(a.Quantite)
                               from livre l join achat a join librairie lib on (l.IdLivre=a.IdLivre) and (lib.IdLib=a.IdLib)
							   where (lib.ville='sba')
							   group by l.IdLivre);

/*Requête 7 : Donner les clients qui ont acheté que des livres en Informatique (est ce qu'on doit considérer les clients qui n'ont achetés aucun 
livre parmi le résultat de cette requête ?)*/
select c.*
from `client` c
where not exists (select *
                  from livre l, achat a
				  where (l.IdLivre=a.IdLivre) and (c.IdClient=a.IdClient) and (l.domaine!='informatique'));

select c.*
from `client` c
where 'informatique' = all (select l.domaine
                            from livre l, achat a
							where (l.IdLivre=a.IdLivre) and (c.IdClient=a.IdClient));

select c.*
from `client` c 
where c.IdClient not in (select a2.IdClient 
                         from achat a2, livre l2 
                         where(l2.IdLivre=a2.IdLivre) and (l2.domaine!='informatique'));

/*Requête 8 : Donner le prix moyen des livres par domaine*/
select l.domaine, avg(sl.prix)
from livre l, stocklivre sl
where (l.IdLivre=sl.IdLivre)
group by l.domaine;

/*Requête 9 : Donner les librairies qui vendent plus de 4 livres en mathèmatique*/
select lib.*, count(*)
from librairie lib join achat a on (lib.IdLib=a.IdLib)
group by lib.IdLib
having 4 <= (select count(*)
			 from achat a join livre l on (a.IdLivre=l.IdLivre)
             where (lib.IdLib=a.IdLib) and (l.domaine='mathématique'));

/*Une solution fausse, car les groupes obtenus contiennent au moins un livre en mathématique pas que des livres en mathèmatique*/
select lib.*
from librairie lib, achat a, livre l
where (lib.IdLib=a.IdLib) and (a.IdLivre=l.IdLivre) and (l.domaine='mathèmatique')
group by lib.IdLib
having count(*) > 4;

/*Requête 10 : Donner les librairies qui vendent plus de 4 livres pour au moins un domaine*/
select distinct lib.*
from librairie lib, achat a, livre l
where (lib.IdLib=a.IdLib) and (a.IdLivre=l.IdLivre)
group by lib.IdLib, l.domaine
having count(*) > 4;

/*Requête 11 : Donner le nom des clients et le nom des Livres, pour les clients qui ont 
acheté de ce livre plus que la moyenne des ventes de ce livre parmi tous les clients*/
select c.nom, l.titre
from `client` c, livre l, achat a
where (c.IdClient=a.IdClient) and (l.IdLivre=a.IdLivre)
group by c.IdClient, l.IdLivre
having sum(a.Quantite) >= (select avg(a2.Quantite) 
                           from achat a2 
                           where (a2.IdLivre=l.IdLivre));
       
/*Requête 12 : Donner pour chaque éditeur, l'identifiant, le nom ainsi que le total des ventes réalisées*/
select e.IdEditeur, e.nom, sum(a.Quantite)
from editeur e, livre l, achat a
where (e.IdEditeur=l.IdEditeur) and (l.IdLivre=a.IdLivre)
group by e.IdEditeur;

/*Requête 13 : Donner l'identifiant, le nom ainsi que le total des achats réalisées pour les clients 
qui ont acheté plus de deux livres différents*/
select c.IdClient, c.nom, sum(a.Quantite)
from `client` c, achat a
where (c.IdClient=a.IdClient)
group by c.IdClient
having count(distinct a.IdLivre) > 2;

/*Requête 14 : Donner les clients qui ont acheté tous les livres de l'éditeur PEARSON 
(proposer deux solutions : avec le not exists et avec le group by)*/
/*Solution avec le not exists*/
select c.*
from `client` c
where not exists (select *
                  from editeur e, livre l
				  where (e.IdEditeur=l.IdEditeur) and (e.nom='PEARSON')
						and (l.IdLivre not in (select a.IdLivre 
                                               from achat a 
                                               where (a.IdClient=c.IdClient))));
                        
/*Solution avec le group by*/
select c.*
from `client` c, achat a, livre l, editeur e
where (c.IdClient=a.IdClient) and (l.IdLivre=a.IdLivre) and (e.IdEditeur=l.IdEditeur) and (e.nom='PEARSON') 
group by c.IdClient
having count(*) = (select count(*)
                   from livre l, editeur e, achat a 
				   where (e.IdEditeur=l.IdEditeur) and (l.IdLivre=a.IdLivre) and (e.nom='PEARSON'));       
                   
/*Solution avec le not exists*/
select c.* 
from `client` c 
where not exists (select * 
                  from livre l, editeur e 
                  where (l.IdEditeur=e.IdEditeur) 
                        and (e.nom='PEARSON') and not exists (select * 
                                                              from achat a 
                                                              where (a.IdLivre=l.IdLivre) and (a.idclient=c.idclient) ));

/*Autres solutions avec le not exists*/
select distinct c3.*
from livre l3 join achat a3 join editeur e3 join `client` c3 on (l3.IdEditeur=e3.IdEditeur) and (a3.IdLivre=l3.IdLivre) 
                                                                and (a3.IdClient=c3.IdClient)
where (e3.nom='PEARSON') and not exists (select a1.IdClient
										 from livre l1 join achat a1 join editeur e1 on (l1.IdEditeur=e1.IdEditeur) 
                                                                                        and (a1.IdLivre=l1.IdLivre)
										 where (e1.nom='PEARSON') and (a3.IdClient=a1.IdClient)
                                               and l1.IdLivre not in (select l2.IdLivre
																	  from livre l2 join editeur e2 on (l2.IdEditeur=e2.IdEditeur)
																	  where (e2.nom='PEARSON')));

select distinct c.*
from R r1 join `client` c on (r1.IdClient=c.IdClient)
where not exists (select r2.IdClient
                  from R r2 
				  where (r1.IdClient=r2.IdClient) and r2.IdLivre not in (select l2.IdLivre
																		 from livre l2 join editeur e2 on (l2.IdEditeur=e2.IdEditeur)
												                         where (e2.nom='PEARSON')));

create view R as (select a1.IdClient, a1.IdLivre
				  from livre l1 join achat a1 join editeur e1 on (l1.IdEditeur=e1.IdEditeur) and (a1.IdLivre=l1.IdLivre)
				  where (e1.nom='PEARSON'));

/*Requête 15 : Donner les livres vendus par tous les librairies (proposez deux solutions avec le not 
exists et le group by)*/
/*Solutions avec le not exists*/
select l.*
from livre l
where not exists (select * 
				  from librairie lib 
				  where lib.IdLib not in (select sl.IdLib
                                          from stocklivre sl 
                                          where (l.IdLivre=sl.IdLivre)));
                                          
select l.* 
from livre l 
where not exists (select * 
                  from librairie b 
                  where not exists (select * 
                                    from stocklivre s 
                                    where (b.IdLib=s.IdLib) and (l.IdLivre=s.IdLivre)));

/*Solution avec le group by*/ 
select l.*
from livre l, librairie lib, stocklivre sl
where (l.IdLivre=sl.IdLivre) and (lib.IdLib=sl.IdLib)
group by l.IdLivre
having count(lib.IdLib) = (select count(lib.IdLib)
                           from librairie lib);

/*Requête 16 : Donner les clients qui ont acheté tous les livres achetés par le client dont l'identfiant est '1'*/
select c.*
from `client` c
where not exists (select *
                  from achat a
                  where (a.IdClient='1') and a.IdLivre not in (select a2.IdLivre
                                                               from achat a2
                                                               where (a2.IdClient=c.IdClient)));
                                                               
select c.*
from `client` c
where not exists (select *
                  from achat a
                  where (a.idclient=1) and not exists (select *
                                                       from achat a2
													   where (a.idclient!=c.idclient) and (a2.idclient=c.idclient)
                                                             and (a.idlivre=a2.idlivre)));