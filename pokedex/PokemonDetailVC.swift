//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Shane Lupton on 1/19/16.
//  Copyright © 2016 Shane Lupton. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var bioMove1Lbl: UILabel!
    @IBOutlet weak var bioMove2Lbl: UILabel!
    @IBOutlet weak var bioMove3Lbl: UILabel!
    @IBOutlet weak var bioMove4Lbl: UILabel!
    @IBOutlet weak var bioMove5Lbl: UILabel!
    @IBOutlet weak var bioMove6Lbl: UILabel!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        bioMove1Lbl.text = "Type:"
        bioMove2Lbl.text = "Height:"
        bioMove3Lbl.text = "Weight:"
        bioMove4Lbl.text = "Attack:"
        bioMove5Lbl.text = "Pokedex ID"
        bioMove6Lbl.text = "Defense"
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                
                evoLbl.text = str
            }
        }
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func segmentedControlTab(sender: AnyObject) {
        if segmentedControl.selectedSegmentIndex == 0 {
            updateUI()
            bioMove3Lbl.hidden = false
            bioMove6Lbl.hidden = false
            weightLbl.hidden = false
            defenseLbl.hidden = false
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            
            if pokemon.moves.count > 1 {
                
                print("Has Moves")
                
                bioMove1Lbl.text = "Move 1"
                bioMove2Lbl.text = "Move 2"
                bioMove3Lbl.hidden = true
                bioMove4Lbl.text = "Move 4"
                bioMove5Lbl.text = "Move 5"
                bioMove6Lbl.hidden = true
                typeLbl.text = pokemon.moves[0]
                heightLbl.text = pokemon.moves[1]
                weightLbl.hidden = true
                attackLbl.text = pokemon.moves[3]
                pokedexLbl.text = pokemon.moves[4]
                defenseLbl.hidden = true
                
            } else {
                
                print("No Moves")
                
                bioMove1Lbl.hidden = true
                bioMove2Lbl.hidden = true
                bioMove3Lbl.hidden = true
                bioMove4Lbl.hidden = true
                bioMove5Lbl.hidden = true
                bioMove6Lbl.hidden = true
                typeLbl.hidden = true
                heightLbl.hidden = true
                weightLbl.hidden = true
                attackLbl.hidden = true
                pokedexLbl.hidden = true
                defenseLbl.hidden = true
            }

        }
    }
}
