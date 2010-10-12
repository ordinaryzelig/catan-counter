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
    var vPoints_div = this.find('.victoryPoints:first')
    vPoints_div.number = function() { return this.find('.number:first') }
    return vPoints_div
  }
  player.largestArmy = function() {
    return this.find('.largestArmy:first')
  }
  player.metropolises = function() {
    var metropolises_div = this.find('.metropolises:first')
    metropolises_div.buildLink = function(development_area) { return this.find('a.' + development_area + ':first') }
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

  // AJAX actions.

  // victory points AJAX.
  player.updateVictoryPoints = function(victoryPoints) {
    this.victoryPoints().number().html(victoryPoints)
  }

  // metropolis AJAX.
  player.disableBuildMetropolisLink = function(development_area) {
    disableLink(this.metropolises().buildLink(development_area))
  }
  player.enableBuildMetropolisLink = function(development_area) {
    enableLink(this.metropolises().buildLink(development_area))
  }
  player.disableBuildMetropolisesLinks = function() {
    this.metropolises().find('a').each(function() {
      disableLink($(this))
    })
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

  return player
}

function updateTotalCitiesCount(count) {
  $('#gameCounts').find('.cities:first').find('.count:first').html(count)
}

function disableDisabledLinks() {
  $('a.disabled').each(function() {
    disableLink($(this))
  })
}

$(document).ready(function() {
  disableDisabledLinks()
})
