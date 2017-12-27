Player = ->

  @BaseStats:

    # base life stat
    life: 100

    # recharge per second
    life_recharge: 5

    # lowered by attacking or running
    stamina: 100

    # recharge per second, only when not moving
    stamina_recharge: 10

    # factored into attack speed (for melee weapons),
    # range (for ranged weapons),
    # and damage for each unless there is a fixed damage/range e.g. a crossbow
    strength: 20

    # extra options for dialog, and avoid being seen.
    stealth: 0

    # accuracy / block chance
    melee_dexterity: 0

    # accuracy
    ranged_dexterity: 0

    # dodge chance and reduction to stamina loss
    agility: 0

    # adds hints to dialog
    charisma: 0

    vision: 20

  @equip_slots:
    chest_armor: null,
    head_armor: null,
    boots: null,
    leg_armor: null,
    belt: null,
    hand1_item: null
    hand2_item: null
    backpack: null

  @items:

  @skills:

    hand_to_hand_combat:

      stats:
        block_chance: 0
        damage: 0
        attack_speed: 0
        agility: 0
        stealth: 0

      abilities:
        power_strike: null
        flurry: null
        grapple: null
        takedown: null
        twist: null
        disarm: null
        pin: null
        lunge: null
        dive: null

    melee_weapon_combat:

      stats:
        block_chance: 0
        attack_speed: 0
        damage: 0
        agility: 0
        stealth: 0

      abilities:
        power_strike: null
        flurry: null
        throw: null
        disarm: null
        counter: null
        lunge: null

    ranged_weapon_combat:

      stats:
        accuracy: null
        deadliness: null

      abilities:
        long_vision: null
        windup: null
        target: null
        kite: null

    stealth:

      stats:
        invisibility: null
        silence: null
        agility: null

      abilities:
        pounce: null
        decimate: null
        flee: null

  @storage_slots: ->
    backpack = @equip_slots.backpack.num_slots || 0
    belt = @equip_slots.belt.num_slots || 0
    {
      total: backpack + belt
      max_continuous: Math.max(backpack, belt)
    }

  @ranged_attack_range = (item) =>
    Math.max((@stats.strength - item.weight), 0)

  @ranged_attack_accuracy = (item) =>
    100 - Math.max((item.dexterity - @stats.ranged_dexterity), 0)

  @melee_attack_accuracy = (item) =>
    100 - Math.max((item.dexterity - @stats.melee_dexterity), 0)

  this
