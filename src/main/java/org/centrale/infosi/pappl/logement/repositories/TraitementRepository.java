/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package org.centrale.infosi.pappl.logement.repositories;

import org.centrale.infosi.pappl.logement.items.Traitement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author bachir
 */
@Repository
public interface TraitementRepository extends JpaRepository<Traitement, Integer> {

}
