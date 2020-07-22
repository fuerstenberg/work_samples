#= require ./map_item

@Motorradfreunde.module 'Application.Model', (Model, App, Backbone, Marionette, $, _) ->

  class Model.User extends Model.MapItem

    backseatStatus:                      -> _.first @get('backseat_list')
    backseatStatusAvailable:             -> !_.isEmpty @get('backseat_list')
    backseatStatusIsBusy:                -> @backseatStatus == "busy"
    backseatStatusIsLookingForABackseat: -> @backseatStatus == "looking_for_a_backseat"
    backseatStatusIsLookingForSomeone:   -> @backseatStatus == "looking_for_someone"
    drivingStyleStatus:                  -> _.first @get('driving_style_list')
    drivingStyleStatusAvailable:         -> !_.isEmpty @get('driving_style_list')
    genderStatus:                        -> _.first @get('gender_list')
    genderStatusAvailable:               -> !_.isEmpty @get('gender_list')
    interestedInGenderStatus:            -> _.first @get('interested_in_gender_list')
    interestedInGenderStatusAvailable:   -> !_.isEmpty @get('interested_in_gender_list')
    ownsMotorcycleStatus:                -> _.first @get('owns_motorcycle_list')
    ownsMotorcycleStatusAvailable:       -> !_.isEmpty @get('owns_motorcycle_list')
    relationshipStatus:                  -> _.first @get('relationship_list')
    relationshipStatusAvailable:         -> !_.isEmpty @get('relationship_list')
    ridesStatus:                         -> _.first @get('rides_list')
    ridesStatusAvailable:                -> !_.isEmpty @get('rides_list')
    ridesWithOtherStatus:                -> _.first @get('rides_with_other_list')
    ridesWithOtherStatusAvailable:       -> !_.isEmpty @get('rides_with_other_list')
    isFacebooker:                        -> !!@get('uid') and @get('provider') == 'facebook'


    # CLOTHING          = %w(textile leather)
    # DRIVING_STYLES    = %w(cruise offroad race tour fast speeder)
    # DRIVE_TYPES       = %w(cardan chain belt)
    # GENDER            = %w(male female)
    # RELATIONSHIP      = %w(single complicated divorced widower relationship married)
    # BACKSEAT          = %w(looking_for_someone looking_for_a_backseat busy)
    # YES_OR_NO         = %w(yes no)
