import consumer from "./consumer"

consumer.subscriptions.create("LandingChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    if(data.msg_type == 'warning') {
      toastr.warning(data.content)
    }     
    
    if(data.msg_type == 'success') {
      if(data.display) {
        toastr.success(data.content)
      }

      if(data.update_html) {
        this.update_html(data.id, true, data.url, data.official)
      }

      if(data.update_users) {
        this.update_users(data.id, data.count)
      }
    } else if(data.msg_type == 'error') {
      if(data.display) {
        toastr.error(data.content)
      }

      if(data.update_html) {
        this.update_html(data.id, false, data.url, data.official)
      }

      if(data.update_users) {
        this.update_users(data.id, data.count)
      }
    }
  },
  
  update_html(id, status, url, official) {
    var outerCard = $('#outer-card-' + id)
    var innerCard = $('#inner-card-' + id)
    var cardText = document.getElementById('card-text-' + id)
    var copyBtn = $('#copy-button-' + id)

    if(status) {
      cardText.innerText = url
    } else {
      cardText.innerText = 'OFFLINE'
    }

    // Why god
    cardText = $('#card-text-' + id)

    outerCard.toggleClass("border-success border-danger hoverable")
    innerCard.toggleClass("card-overlay card-offline-overlay")
    cardText.toggleClass("text-success text-danger")
    copyBtn.toggleClass("btn-outline-success btn-outline-danger")
  },

  update_users(id, count) {
    var userCount = document.getElementById('userCount-' + id) 
    var val = parseInt(count) 
    userCount.textContent = val

    // Seriously why. (geteleid + $ selectors required whe changing text + style)
    userCount = $('#userCount-' + id)
    userCount.css({opacity: 0, top: "-10px"})
    userCount.animate({top: "-2px", opacity: 1})
  }
});
