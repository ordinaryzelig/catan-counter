// Add class 'disabled' to element.
// Add special click event to link that will determine whether it sends request or not.
function disableLink(link) {
  if (!link.hasClass('disabled')) {
    link.addClass('disabled')
  }
  link.click(function(event) {
    if (link.hasClass('disabled')) {
      return false
    }
  })
}

// Just let the link do its normal thing.
// Link click event should have already been handled in disableLink().
function enableLink(link) {
  link.removeClass('disabled')
}

// fetch the player div and add the helper ajax methods.
function getPlayer(playerId) {
  var player = $('#player_' + playerId)

  // Children selectors with selectors of their own.
  player.victoryPoints = function() {
    var vPoints = this.find('.victoryPoints:first')
    vPoints.number = function() { return this.find('.number:first') }
    vPoints.toInt = function() { return parseInt(this.number().html()) }
    return vPoints
  }
  player.bonuses = function() {
    return this.find('.bonuses:first')
  }
  player.largestArmy = function() {
    return this.find('.largestArmy:first')
  }
  player.longestRoadImage = function() {
    return this.find('img.longestRoad:first')
  }
  player.longestRoadLink = function() {
    return this.find('a.longestRoad:first')
  }
  player.metropolises = function() {
    var metropolises_div = this.find('.metropolises:first')
    metropolises_div.buildLink = function(development_area) { return this.find('a.' + development_area + ':first') }
    metropolises_div.buildLinks = function() { return this.find('a') }
    return metropolises_div
  }
  player.cities = function() {
    var cities_div = this.find('.cities:first')
    cities_div.number = function() { return this.find('.number:first') }
    cities_div.downgradeLink = function() { return this.find('a.downgrade:first') }
    return cities_div
  }
  player.settlements = function() {
    var settlements_div = this.find('.settlements:first')
    settlements_div.number = function() { return this.find('.number:first') }
    settlements_div.buildLink = function() { return this.find('a.build:first') }
    settlements_div.upgradeLink = function() { return this.find('a.upgrade:first') }
    settlements_div.destroyLink = function() { return this.find('a.destroy:first') }
    return settlements_div
  }
  player.soldiers = function() {
    var soldiers_div = this.find('.soldiers:first')
    soldiers_div.count = function() { return this.find('.count:first') }
    soldiers_div.useLink = function() { return this.find('a.use:first') }
    return soldiers_div
  }
  player.knights = function() {
    var knight_div = this.find('.knights:first')
    knight_div.level = function(level) {
      return this.find('.level' + level + ':first')
    }
    return knight_div
  }
  player.buildKnightLink = function() {
    return this.find('a.buildKnight:first')
  }
  player.playMerchantCardLink = function() { return this.find('a.playMerchantCard:first') }

  // AJAX actions.

  // victory points AJAX.
  player.updateVictoryPoints = function(victoryPoints) {
    this.victoryPoints().number().html(victoryPoints)
  }
  player.adjustVictoryPoints = function(offset) {
    this.victoryPoints().number().html(this.victoryPoints().toInt() + offset)
  }
  player.hasEnoughVictoryPointsToWin = function() {
    this.addClass('hasEnoughVictoryPointsToWin')
  }
  player.noLongerHasEnoughVictoryPointsToWin = function() {
    this.removeClass('hasEnoughVictoryPointsToWin')
  }

  // cities AJAX.
  player.updateCitiesCount = function(count) {
    this.cities().number().html(count)
  }
  player.enableDowngradeCityLink = function() {
    enableLink(this.cities().downgradeLink())
  }
  player.disableDowngradeCityLink = function() {
    disableLink(this.cities().downgradeLink())
  }
  player.adjustCitiesCount = function(offset) {
    var number = this.cities().number()
    number.html(parseInt(number.html()) + offset)
  }

  // settlement AJAX.
  player.updateSettlementsCount = function(count) {
    this.settlements().number().html(count)
  }
  player.disableBuildSettlementLink = function() {
    disableLink(this.settlements().buildLink())
  }
  player.enableBuildSettlementLink = function() {
    enableLink(this.settlements().buildLink())
  }
  player.disableUpgradeSettlementLink = function() {
    disableLink(this.settlements().upgradeLink())
  }
  player.enableUpgradeSettlementLink = function() {
    enableLink(this.settlements().upgradeLink())
  }
  player.disableDestroySettlementLink = function() {
    disableLink(this.settlements().destroyLink())
  }
  player.enableDestroySettlementLink = function() {
    enableLink(this.settlements().destroyLink())
  }

  // soldier AJAX.
  player.updateSoldiersCount = function(count) {
    this.soldiers().count().html(count)
  }
  player.disableUseLink = function() {
    disableLink(this.soldiers().useLink())
  }
  player.enableUseLink = function() {
    enableLink(this.soldiers().useLink())
  }
  player.hideLargestArmy = function() {
    this.largestArmy().hide()
  }
  player.showLargestArmy = function() {
    this.largestArmy().show()
  }

  // metropolis AJAX.
  player.disableBuildMetropolisLink = function(development_area) {
    disableLink(this.metropolises().buildLink(development_area))
  }
  player.enableBuildMetropolisLink = function(development_area) {
    enableLink(this.metropolises().buildLink(development_area))
  }
  player.enableBuildMetropolisLinks = function() {
    this.metropolises().buildLinks().each(function() {
      enableLink($(this))
    })
  }
  player.disableBuildMetropolisLinks = function() {
    this.metropolises().buildLinks().each(function() {
      disableLink($(this))
    })
  }

  // longest road AJAX.
  player.takeLongestRoad = function() {
    this.longestRoadImage().show()
    this.longestRoadLink().hide()
  }
  player.loseLongestRoad = function() {
    this.longestRoadImage().hide()
    this.longestRoadLink().show()
  }

  // knights AJAX.
  player.enableBuildKnightLink = function() {
    enableLink(this.buildKnightLink())
  }
  player.disableBuildKnightLink = function() {
    disableLink(this.buildKnightLink())
  }
  player.addKnight = function(level, html) {
    player.knights().level(level).append(html)
  }

  // merchant AJAX.
  player.enablePlayMerchantCardLink = function() {
    enableLink(this.playMerchantCardLink())
  }
  player.disablePlayMerchantCardLink = function() {
    disableLink(this.playMerchantCardLink())
  }

  return player
}

function getKnight(id) {
  var knight = $('#knight_' + id)
  return knight
}

function getMetropolis(developmentArea) {
  return $('#metropolis_' + developmentArea)
}

function updateTotalCitiesCount(count) {
  $('#gameCounts').find('.cities:first').find('.count:first').html(count)
}

function getMerchant() {
  return $('#merchant')
}

function totalActivatedKnights() {
  var activatedKnightsDiv = $('#totalActivatedKnights')
  activatedKnightsDiv.count = function() {
    var count = this.find('.count:first')
    count.toInt = function() { return parseInt(this.html()) }
    count.update = function(num) { this.html(num) }
    return count
  }
  return activatedKnightsDiv
}

function adjustTotalActivatedKnights(offset) {
  var count = totalActivatedKnights().count()
  count.html(count.toInt() + offset)
}

function disableTakeProgressCardVictoryPointLinks() {
  $('.progressCardVictoryPoints a').each(function() {
    disableLink($(this))
  })
}

function disableDisabledLinks() {
  $('a.disabled').each(function() {
    disableLink($(this))
  })
}

function injectOverlayForAjaxLinks() {
  $('a[data-remote="true"]').each(function() {
    $(this).click(function(event) {
      if($(this).hasClass('disabled')) {
        return false
      }
      else {
        $('#overlay').bPopup({opacity: 0.4, escClose: false, fadeSpeed: 0, modalClose: false})
      }
    })
  })
}

$(document).ready(function() {
  disableDisabledLinks()
  injectOverlayForAjaxLinks()
})
