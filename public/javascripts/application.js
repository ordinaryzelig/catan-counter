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
  player.metropolises = function() {
    var metropolises_div = this.find('.metropolises:first')
    metropolises_div.link = function(development_area) { return this.find('a.' + development_area + ':first') }
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

  // AJAX actions.
  player.updateSettlementsCount = function(count) {
    this.settlements().number().html(count)
  }
  player.disableDestroySettlementLink = function() {
    disableLink(this.settlements().destroyLink())
  }
  player.disableUpgradeSettlementLink = function() {
    disableLink(this.settlements().upgradeLink())
  }
  player.updateCitiesCount = function(count) {
    this.cities().number().html(count)
  }
  player.enableDowngradeCityLink = function() {
    enableLink(this.cities().downgradeLink())
  }
  player.disableDowngradeCityLink = function() {
    disableLink(this.cities().downgradeLink())
  }
  player.updateVictoryPoints = function(victoryPoints) {
    this.victoryPoints().number().html(victoryPoints)
  }
  player.disableMetropolisLink = function(development_area) {
    disableLink(this.metropolises().link(development_area))
  }
  player.enableMetropolisLink = function(development_area) {
    enableLink(this.metropolises().link(development_area))
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
